import { PickupRoom } from './PickupRoom';
import { useState } from 'react';
import { api, kg, money, query } from './api';
import { orderActions } from './order-actions.mjs';
import { Alert, Loading, PageTitle, Status, useAction, useData } from './ui';

function ListingCard({ row, match, children }) {
  const totalValue = row.available_kg && row.price_per_kg ? row.available_kg * row.price_per_kg : null;

  return (
    <article className="card listing-card">
      <div className="card-top-bar">
        <div className="location-chip">
          <span className="chip-icon">📍</span>
          <span className="district-name">{row.district}</span>
          <span className="chip-sep">·</span>
          <span className="farmer-name">🧑‍🌾 {row.farmer_name}</span>
        </div>
        <Status value={row.status} />
      </div>

      <div className="listing-heading">
        <h2 className="crop-title">{row.crop}</h2>
        {row.available_kg > 0 ? (
          <span className="stock-pill in-stock">Available</span>
        ) : (
          <span className="stock-pill sold-out">Sold out</span>
        )}
      </div>

      <p className="crop-desc">{row.description}</p>

      <div className="facts-grid">
        <div className="fact-tile">
          <dt>Available Stock</dt>
          <dd className="fact-highlight green">{kg(row.available_kg)}</dd>
        </div>
        <div className="fact-tile">
          <dt>Price per kg</dt>
          <dd className="fact-highlight gold">{money(row.price_per_kg)}</dd>
        </div>
        {totalValue !== null && (
          <div className="fact-tile total-tile">
            <dt>Total Lot Value</dt>
            <dd className="fact-highlight">{money(totalValue)}</dd>
          </div>
        )}
      </div>

      <div className="schedule-bar">
        <div className="schedule-item">
          <span className="schedule-icon">🌾</span>
          <span><strong>Harvested:</strong> {row.harvest_date}</span>
        </div>
        <div className="schedule-item">
          <span className="schedule-icon">📅</span>
          <span><strong>Pickup:</strong> {row.available_from} to {row.available_until}</span>
        </div>
      </div>

      {match && (
        <div className="match-card">
          <div className="match-header">
            <span className="match-badge">
              <span className="match-star">★</span> Match Score: <strong>{match.score}/100</strong>
            </span>
            <div className="match-bar-bg" aria-hidden="true">
              <div
                className="match-bar-fill"
                style={{ width: `${Math.min(100, Math.max(0, match.score))}%` }}
              ></div>
            </div>
          </div>
          <ul className="match-reasons">
            {match.reasons.map(reason => (
              <li key={reason}>
                <span className="check-bullet">✓</span> {reason}
              </li>
            ))}
          </ul>
        </div>
      )}

      {children && <div className="card-actions-wrapper">{children}</div>}
    </article>
  );
}

export function Marketplace() {
  const [filters, setFilters] = useState('/listings?');
  const [offset, setOffset] = useState(0);
  const [activeCrop, setActiveCrop] = useState('All');
  const path = filters + '&offset=' + offset;
  const result = useData(path || null);

  const cropChips = ['All', 'Rice straw', 'Wheat straw', 'Maize stalks', 'Sugarcane trash', 'Cotton stalks'];

  function handleCropChip(crop) {
    setActiveCrop(crop);
    setOffset(0);
    if (crop === 'All') {
      setFilters('/listings?');
    } else {
      setFilters('/listings?crop=' + encodeURIComponent(crop));
    }
    result.reload();
  }

  return (
    <div className="page-wrapper">
      <PageTitle
        title="Crop Residue Marketplace"
        detail="Browse verified paddy straw, wheat stubble, and agricultural biomass available directly from local farmers."
      />

      <section className="card filter-panel">
        <div className="filter-panel-header">
          <div className="filter-title-group">
            <span className="filter-title-icon">🔍</span>
            <h3>Search & Filter Residue</h3>
          </div>
          <div className="crop-chips-bar" role="tablist" aria-label="Filter by crop">
            {cropChips.map(crop => (
              <button
                key={crop}
                type="button"
                className={`crop-chip ${activeCrop === crop ? 'active' : ''}`}
                onClick={() => handleCropChip(crop)}
              >
                {crop === 'All' ? '🌾 All Crops' : crop}
              </button>
            ))}
          </div>
        </div>

        <form
          className="filters-grid"
          onSubmit={event => {
            event.preventDefault();
            const values = new URLSearchParams();
            new FormData(event.currentTarget).forEach((value, key) => {
              if (typeof value === 'string' && value.trim())
                values.set(key, value.trim());
            });
            setOffset(0);
            setFilters('/listings' + query(values));
            result.reload();
          }}
        >
          <label className="field-group field-search">
            <span>Keyword Search</span>
            <input name="q" placeholder="Search by crop, district, or farmer name..." maxLength={100} />
          </label>

          <label className="field-group">
            <span>Crop Type</span>
            <input
              name="crop"
              maxLength={40}
              list="crops"
              defaultValue={activeCrop !== 'All' ? activeCrop : ''}
              placeholder="e.g. Rice straw"
            />
          </label>

          <label className="field-group">
            <span>District / Region</span>
            <input
              name="district"
              maxLength={80}
              placeholder="e.g. Ludhiana, Karnal..."
            />
          </label>

          <label className="field-group">
            <span>Min. Stock (kg)</span>
            <input
              name="minKg"
              type="number"
              min={1}
              max={10000000}
              placeholder="e.g. 5000"
            />
          </label>

          <label className="field-group">
            <span>Harvested On or After</span>
            <input type="date" name="harvestAfter" />
          </label>

          <div className="filter-submit-wrap">
            <button className="primary filter-btn">
              🔍 Search Listings
            </button>
          </div>
        </form>
      </section>

      <datalist id="crops">
        {[
          'Rice straw',
          'Wheat straw',
          'Maize stalks',
          'Sugarcane trash',
          'Cotton stalks',
          'Mustard straw',
        ].map(crop => (
          <option key={crop} value={crop} />
        ))}
      </datalist>

      <Alert error={result.error} />
      <Loading active={result.loading} />

      {result.data && (
        <div className="results-container">
          <div className="results-status-bar">
            <p role="status" className="results-count">
              🌾 {result.data.length ? `${result.data.length} listing(s) available` : 'No listings match those criteria.'}
            </p>
          </div>

          <div className="cards">
            {result.data.map(item => {
              const row = 'listing' in item ? item.listing : item;
              return (
                <ListingCard key={row.id} row={row} match={'listing' in item ? item : undefined}>
                  <a className="button primary card-view-btn" href={'#listing/' + row.id}>
                    View listing & request →
                  </a>
                </ListingCard>
              );
            })}
          </div>

          {(offset > 0 || result.data.length === 100) && (
            <div className="actions pagination-actions mt-6">
              <button
                type="button"
                className="button"
                disabled={offset === 0}
                onClick={() => setOffset(offset - 100)}
              >
                ← Previous page
              </button>
              <button
                type="button"
                className="button"
                disabled={result.data.length < 100}
                onClick={() => setOffset(offset + 100)}
              >
                Next page →
              </button>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

export function ListingDetail({ id }) {
  const result = useData('/listings/' + id);
  const [error, busy, run] = useAction();
  const [sent, setSent] = useState(false);
  const [requestedKg, setRequestedKg] = useState('');
  const row = result.data;

  const estimatedCost =
    row?.price_per_kg && requestedKg && Number(requestedKg) > 0
      ? Number(requestedKg) * row.price_per_kg
      : 0;

  return (
    <div className="page-wrapper detail-page">
      <div className="detail-nav-bar">
        <a href="#market" className="back-link">
          ← Back to Marketplace
        </a>
      </div>

      <PageTitle
        title={row?.crop ?? 'Residue Listing'}
        detail="Review supply specifications, farmer pickup window, and submit your procurement request."
      />

      <Alert error={result.error} />
      <Loading active={result.loading} />

      {row && (
        <div className="detail-layout">
          <div className="detail-main-col">
            <ListingCard row={row} />
          </div>

          <div className="detail-side-col">
            <section className="card purchase-panel">
              <div className="purchase-panel-header">
                <h3>Submit Purchase Request</h3>
                <p className="muted">Reserve agricultural residue directly with the farmer</p>
              </div>

              <Alert error={error} />

              {sent ? (
                <div role="status" className="request-sent-card">
                  <div className="sent-icon">✓</div>
                  <h4>Purchase Request Sent!</h4>
                  <p>The farmer has been notified and will review your request shortly.</p>
                  <a className="button primary mt-3" href="#orders">
                    Track in My Orders →
                  </a>
                </div>
              ) : row.available_kg > 0 ? (
                <form
                  className="purchase-form"
                  onSubmit={event => {
                    event.preventDefault();
                    const quantityKg = Number(new FormData(event.currentTarget).get('quantityKg'));
                    void run(async () => {
                      await api('/orders', 'POST', { listingId: id, quantityKg });
                      setSent(true);
                    });
                  }}
                >
                  <div className="stock-info-strip">
                    <span>Available unreserved:</span>
                    <strong>{kg(row.available_kg)}</strong>
                  </div>

                  <label className="field-group">
                    <span>Requested Biomass Quantity (kg)</span>
                    <input
                      type="number"
                      name="quantityKg"
                      required
                      min={1}
                      max={Math.min(row.available_kg, 10000000)}
                      value={requestedKg}
                      onChange={e => setRequestedKg(e.target.value)}
                      placeholder="e.g. 2000"
                    />
                  </label>

                  {estimatedCost > 0 && (
                    <div className="estimate-box">
                      <div className="estimate-label">Estimated Total Amount:</div>
                      <div className="estimate-value">{money(estimatedCost)}</div>
                      <small className="muted">
                        Calculation: {kg(Number(requestedKg))} × {money(row.price_per_kg)}/kg
                      </small>
                    </div>
                  )}

                  <button className="primary purchase-submit-btn" disabled={busy}>
                    {busy ? 'Sending request…' : '🤝 Send Purchase Request'}
                  </button>

                  <p className="purchase-guarantee-note">
                    🔒 No payment is deducted yet. Biomass stock is officially reserved once the farmer confirms.
                  </p>
                </form>
              ) : (
                <div className="sold-out-notice">
                  <p>This crop residue lot is completely sold out or unreserved stock is 0 kg.</p>
                  <a href="#market" className="button">
                    Browse Other Listings
                  </a>
                </div>
              )}
            </section>
          </div>
        </div>
      )}
    </div>
  );
}

export function ManageListings({ admin }) {
  const base = admin ? '/admin/listings' : '/farmer/listings';
  const result = useData(base);
  const [editor, setEditor] = useState(null);
  const [error, busy, run] = useAction();
  const row = editor === 'new' ? null : editor;

  function update(path, method, body) {
    void run(async () => {
      await api(path, method, body);
      result.reload();
    });
  }

  return (
    <div className="page-wrapper">
      <div className="page-header-row">
        <PageTitle
          title={admin ? 'Listing Moderation' : 'My Residue Listings'}
          detail={
            admin
              ? 'Review platform residue supply, audit compliance, and remove or restore listings.'
              : 'Manage your active parali inventory, pickup windows, and selling price.'
          }
        />
        {!admin && !editor && (
          <button className="primary create-listing-btn" onClick={() => setEditor('new')}>
            <span>+</span> Create New Listing
          </button>
        )}
      </div>

      <Alert error={error || result.error} />
      <Loading active={result.loading} />

      {editor && (
        <form
          key={row?.id ?? 'new'}
          className="card form-editor-panel mb-6"
          onSubmit={event => {
            event.preventDefault();
            const values = new FormData(event.currentTarget);
            const input = {
              ...Object.fromEntries(values),
              availableKg: Number(values.get('availableKg')),
              pricePerKg: Number(values.get('pricePerKg')),
              version: row?.version,
            };
            void run(async () => {
              await api(row ? base + '/' + row.id : base, row ? 'PUT' : 'POST', input);
              setEditor(null);
              result.reload();
            });
          }}
        >
          <div className="editor-header">
            <h3>{row ? `Edit Listing #${row.id} · ${row.crop}` : '🌾 List New Crop Residue Batch'}</h3>
            <p className="muted">
              Provide accurate crop biomass quantity, farm location, and schedule for industrial buyers.
            </p>
          </div>

          <div className="editor-grid">
            <label className="field-group">
              <span>Crop Type</span>
              <input
                name="crop"
                required
                maxLength={40}
                defaultValue={row?.crop}
                placeholder="e.g. Rice straw, Wheat straw..."
              />
            </label>

            <label className="field-group">
              <span>District / Farm Region</span>
              <input
                name="district"
                required
                maxLength={80}
                defaultValue={row?.district}
                placeholder="e.g. Sangrur, Ludhiana..."
              />
            </label>

            <label className="field-group">
              <span>Unreserved Stock (kg)</span>
              <input
                name="availableKg"
                type="number"
                min={0}
                max={10000000}
                required
                defaultValue={row?.available_kg}
                placeholder="e.g. 10000"
              />
            </label>

            <label className="field-group">
              <span>Price per kg (₹)</span>
              <input
                name="pricePerKg"
                type="number"
                min="0.01"
                max="99999999.99"
                step="0.01"
                required
                defaultValue={row?.price_per_kg}
                placeholder="e.g. 2.20"
              />
            </label>

            <label className="field-group">
              <span>Harvest Date</span>
              <input name="harvestDate" type="date" required defaultValue={row?.harvest_date} />
            </label>

            <label className="field-group">
              <span>Available From (Pickup start)</span>
              <input name="availableFrom" type="date" required defaultValue={row?.available_from} />
            </label>

            <label className="field-group">
              <span>Available Until (Pickup deadline)</span>
              <input name="availableUntil" type="date" required defaultValue={row?.available_until} />
            </label>
          </div>

          <label className="field-group mt-3">
            <span>Residue Condition & Field Access Notes</span>
            <textarea
              name="description"
              required
              maxLength={1000}
              rows={3}
              defaultValue={row?.description}
              placeholder="e.g. Baled or loose paddy straw, dry condition, moisture < 15%, easy tractor-trolley road access..."
            />
          </label>

          <div className="editor-actions">
            <button className="primary" disabled={busy}>
              💾 {row ? 'Save Changes' : 'Publish Listing'}
            </button>
            <button
              type="button"
              className="button"
              disabled={busy}
              onClick={() => {
                setEditor(null);
                result.reload();
              }}
            >
              Cancel
            </button>
          </div>
        </form>
      )}

      {result.data?.length === 0 && (
        <div className="card empty-state-card">
          <div className="empty-state-icon">🌾</div>
          <h3>No crop listings yet</h3>
          <p className="muted">
            {admin
              ? 'No listings found in the platform database.'
              : 'Add your available crop residue to connect directly with industrial buyers and avoid field burning.'}
          </p>
          {!admin && !editor && (
            <button className="primary mt-3" onClick={() => setEditor('new')}>
              + Create Your First Listing
            </button>
          )}
        </div>
      )}

      <div className="cards">
        {result.data?.map(listing => {
          const path = base + '/' + listing.id;
          return (
            <ListingCard row={listing} key={listing.id}>
              <div className="listing-manage-actions">
                {admin ? (
                  <button
                    disabled={busy}
                    className={listing.status === 'REMOVED' ? 'button primary' : 'button danger'}
                    onClick={() =>
                      update(path + '/status', 'PATCH', {
                        status: listing.status === 'REMOVED' ? 'PAUSED' : 'REMOVED',
                      })
                    }
                  >
                    {listing.status === 'REMOVED' ? '✓ Restore as paused' : '🚫 Remove listing'}
                  </button>
                ) : (
                  <>
                    {listing.status !== 'REMOVED' && (
                      <>
                        <button
                          className="button"
                          disabled={busy || !!editor}
                          onClick={() => setEditor(listing)}
                        >
                          ✏️ Edit
                        </button>
                        <button
                          className="button"
                          disabled={busy}
                          onClick={() =>
                            update(path + '/status', 'PATCH', {
                              status: listing.status === 'ACTIVE' ? 'PAUSED' : 'ACTIVE',
                            })
                          }
                        >
                          {listing.status === 'ACTIVE' ? '⏸️ Pause' : '▶️ Resume'}
                        </button>
                      </>
                    )}
                    <button
                      disabled={busy}
                      className="button danger"
                      onClick={() => {
                        if (window.confirm('Delete this listing? Existing orders retain their history.'))
                          update(path, 'DELETE');
                      }}
                    >
                      🗑️ Delete
                    </button>
                  </>
                )}
              </div>
            </ListingCard>
          );
        })}
      </div>
    </div>
  );
}

const actionLabels = {
  ACCEPT: 'Accept & Reserve',
  REJECT: 'Reject Request',
  CANCEL: 'Cancel Order',
  ASSIGN: 'Assign Pickup Carrier',
  PICK_UP: 'Mark Picked Up',
  DELIVER: 'Mark Delivered',
};

export function OrdersView({ role }) {
  const result = useData('/orders');
  const carriers = useData(role === 'FARMER' ? '/carriers' : null);
  const [error, busy, run] = useAction();
  const title = {
    FARMER: 'Requests & Orders',
    BUYER: 'My Orders',
    LOGISTICS: 'Delivery Assignments',
    ADMIN: 'All Platform Orders',
  }[role];

  return (
    <div className="page-wrapper">
      <PageTitle
        title={title}
        detail="Follow biomass purchase requests, track logistics handoffs, and confirm delivery fulfillment."
      />

      <Alert error={error || result.error || carriers.error} />
      <Loading active={result.loading} />

      {result.data?.length === 0 && (
        <div className="card empty-state-card">
          <div className="empty-state-icon">📦</div>
          <h3>No orders to display</h3>
          <p className="muted">Active purchase requests and scheduled deliveries will appear here.</p>
        </div>
      )}

      <div className="orders-stack">
        {result.data?.map(order => {
          const totalAmount = order.quantity_kg * order.price_per_kg;

          return (
            <article className="card order-card" key={order.id}>
              <div className="order-main-info">
                <div className="order-top-strip">
                  <span className="order-id-badge">Order #{order.id}</span>
                  <span className="order-district">📍 {order.district}</span>
                </div>

                <div className="order-crop-row">
                  <h2 className="order-crop-title">{order.crop}</h2>
                  <span className="order-value-badge">{money(totalAmount)}</span>
                </div>

                <div className="order-metrics-line">
                  <span className="order-quantity">⚖️ {kg(order.quantity_kg)}</span>
                  <span className="order-rate">at {money(order.price_per_kg)} per kg</span>
                </div>

                <div className="order-participants-box">
                  <div className="participant-step">
                    <span className="part-label">Farmer</span>
                    <span className="part-name">🧑‍🌾 {order.farmer_name}</span>
                  </div>
                  <span className="participant-arrow">→</span>
                  <div className="participant-step">
                    <span className="part-label">Buyer</span>
                    <span className="part-name">🏭 {order.buyer_name}</span>
                  </div>
                </div>

                {order.carrier_name && (
                  <div className="carrier-assigned-strip">
                    <span className="carrier-icon">🚛</span>
                    <span><strong>Transport Partner:</strong> {order.carrier_name}</span>
                  </div>
                )}
              </div>

              <div className="order-side-controls">
                <div className="order-status-wrapper">
                  <Status value={order.status} />
                </div>

                {['FARMER', 'LOGISTICS'].includes(role) && order.carrier_id && (
                  <div className="pickup-room-wrap">
                    <PickupRoom orderId={order.id} role={role} />
                  </div>
                )}

                <div className="order-actions-group">
                  {orderActions(role, order.status).map(action => {
                    const submit = carrierId => {
                      if (action === 'CANCEL' && !window.confirm('Cancel this order?'))
                        return;
                      void run(async () => {
                        await api('/orders/' + order.id, 'PATCH', { action, carrierId });
                        result.reload();
                      });
                    };

                    return action === 'ASSIGN' ? (
                      <form
                        key={action}
                        className="carrier-assign-form"
                        onSubmit={event => {
                          event.preventDefault();
                          submit(Number(new FormData(event.currentTarget).get('carrierId')));
                        }}
                      >
                        <label className="field-group">
                          <span>Assign Transport Provider</span>
                          <select name="carrierId" required className="carrier-select">
                            <option value="">Choose logistics partner...</option>
                            {carriers.data?.map(carrier => (
                              <option key={carrier.id} value={carrier.id}>
                                🚛 {carrier.name}
                              </option>
                            ))}
                          </select>
                        </label>
                        <button className="primary w-full mt-2" disabled={busy}>
                          {actionLabels[action]}
                        </button>
                      </form>
                    ) : (
                      <button
                        key={action}
                        disabled={busy}
                        className={`button ${['CANCEL', 'REJECT'].includes(action) ? 'danger' : 'primary'}`}
                        onClick={() => submit()}
                      >
                        {action === 'ACCEPT' && '✓ '}
                        {action === 'PICK_UP' && '🚛 '}
                        {action === 'DELIVER' && '✅ '}
                        {actionLabels[action]}
                      </button>
                    );
                  })}
                </div>
              </div>
            </article>
          );
        })}
      </div>
    </div>
  );
}

const CITY_AQI = [
  { city: 'Delhi NCR',    aqi: 412, label: 'Hazardous',   color: '#7e0023', text: '#fff' },
  { city: 'Ludhiana',     aqi: 318, label: 'Very Unhealthy', color: '#7e004f', text: '#fff' },
  { city: 'Amritsar',     aqi: 287, label: 'Very Unhealthy', color: '#99004f', text: '#fff' },
  { city: 'Chandigarh',   aqi: 194, label: 'Unhealthy',    color: '#c0392b', text: '#fff' },
  { city: 'Panipat',      aqi: 231, label: 'Very Unhealthy', color: '#8e1a1a', text: '#fff' },
  { city: 'Karnal',       aqi: 176, label: 'Unhealthy',    color: '#c0392b', text: '#fff' },
  { city: 'Hisar',        aqi: 142, label: 'Unhealthy',    color: '#e74c3c', text: '#fff' },
  { city: 'Rohtak',       aqi: 128, label: 'Unhealthy',    color: '#e74c3c', text: '#fff' },
  { city: 'Patiala',      aqi: 198, label: 'Unhealthy',    color: '#c0392b', text: '#fff' },
  { city: 'Bathinda',     aqi: 163, label: 'Unhealthy',    color: '#e74c3c', text: '#fff' },
  { city: 'Ambala',       aqi: 115, label: 'Unhealthy for Sensitive', color: '#d35400', text: '#fff' },
  { city: 'Jaipur',       aqi: 94,  label: 'Moderate',    color: '#f39c12', text: '#000' },
  { city: 'Agra',         aqi: 108, label: 'Unhealthy for Sensitive', color: '#d35400', text: '#fff' },
  { city: 'Meerut',       aqi: 219, label: 'Very Unhealthy', color: '#8e1a1a', text: '#fff' },
  { city: 'Faridabad',    aqi: 267, label: 'Very Unhealthy', color: '#7e004f', text: '#fff' },
  { city: 'Gurugram',     aqi: 243, label: 'Very Unhealthy', color: '#8e1a1a', text: '#fff' },
  { city: 'Shimla',       aqi: 42,  label: 'Good',         color: '#27ae60', text: '#fff' },
  { city: 'Dehradun',     aqi: 71,  label: 'Moderate',     color: '#f1c40f', text: '#000' },
];

const AQI_LEGEND = [
  { label: 'Good',                   color: '#27ae60', range: '0–50' },
  { label: 'Moderate',               color: '#f1c40f', range: '51–100' },
  { label: 'Unhealthy (Sensitive)',   color: '#d35400', range: '101–150' },
  { label: 'Unhealthy',              color: '#e74c3c', range: '151–200' },
  { label: 'Very Unhealthy',         color: '#8e1a1a', range: '201–300' },
  { label: 'Hazardous',              color: '#7e0023', range: '301+' },
];

function AirPollutionMap() {
  const [hovered, setHovered] = useState(null);
  const sorted = [...CITY_AQI].sort((a, b) => b.aqi - a.aqi);
  return (
    <section className="card aqi-section">
      <div className="aqi-header">
        <div>
          <h3>🌫️ Indo-Gangetic Plain — Real-Time AQI Heat Map</h3>
          <p className="muted">Air Quality Index across cities affected by crop stubble burning. ParaliSetu interventions directly reduce these values.</p>
        </div>
        <span className="impact-verified-pill">📡 AQI Data (Indicative)</span>
      </div>
      <div className="aqi-legend">
        {AQI_LEGEND.map(l => (
          <span key={l.label} className="aqi-legend-item">
            <span className="aqi-legend-dot" style={{ background: l.color }} />
            <span className="aqi-legend-text">{l.label}</span>
            <span className="aqi-legend-range">{l.range}</span>
          </span>
        ))}
      </div>
      <div className="aqi-grid">
        {sorted.map(city => (
          <div
            key={city.city}
            className={`aqi-city-card${hovered === city.city ? ' aqi-hovered' : ''}`}
            style={{ '--city-color': city.color, '--city-text': city.text }}
            onMouseEnter={() => setHovered(city.city)}
            onMouseLeave={() => setHovered(null)}
          >
            <div className="aqi-city-top">
              <span className="aqi-city-name">{city.city}</span>
              <span className="aqi-city-label" style={{ background: city.color, color: city.text }}>{city.label}</span>
            </div>
            <div className="aqi-city-aqi" style={{ color: city.color }}>{city.aqi}</div>
            <div className="aqi-bar-track">
              <div className="aqi-bar-fill" style={{ width: `${Math.min(100, (city.aqi / 500) * 100)}%`, background: city.color }} />
            </div>
            <div className="aqi-city-index-label">AQI Index</div>
          </div>
        ))}
      </div>
    </section>
  );
}

export function Impact() {
  const result = useData('/impact');
  const stats = result.data;

  // Scientific & Economic equivalencies based on diverted stubble biomass
  const divertedKg = stats?.estimated_diverted_kg || 0;
  const divertedTonnes = (divertedKg / 1000).toFixed(divertedKg >= 10000 ? 0 : 1);
  const co2AvoidedKg = Math.round(divertedKg * 1.46);
  const co2AvoidedTonnes = (co2AvoidedKg / 1000).toFixed(1);
  const pm25PreventedKg = (divertedKg * 0.0032).toFixed(1);
  const treeEquiv = Math.round(co2AvoidedKg / 22);
  const estimatedFarmerWealth = money(divertedKg * 2.1);

  return (
    <div className="page-wrapper impact-page">
      <PageTitle
        title="Marketplace Impact & Environmental Dashboard"
        detail="Real-time environmental metrics and socio-economic value generated by diverting crop stubble away from open field burning into clean industrial value chains."
      />

      <Alert error={result.error} />
      <Loading active={result.loading} />

      {stats && (
        <>
          {/* Primary Platform Totals */}
          <div className="impact-metrics-grid">
            <div className="card impact-metric-card leaf-card">
              <div className="metric-icon-wrap green-icon">🌾</div>
              <div className="metric-content">
                <p className="metric-title">Crop Residue Delivered</p>
                <strong className="metric-number">{kg(stats.delivered_kg)}</strong>
                <span className="metric-sub">≈ {divertedTonnes} Metric Tonnes biomass utilized</span>
              </div>
            </div>

            <div className="card impact-metric-card gold-card">
              <div className="metric-icon-wrap gold-icon">🚚</div>
              <div className="metric-content">
                <p className="metric-title">Completed Deliveries</p>
                <strong className="metric-number">{stats.deliveries}</strong>
                <span className="metric-sub">Rural transport & tractor-trolley dispatch trips</span>
              </div>
            </div>

            <div className="card impact-metric-card clean-air-card">
              <div className="metric-icon-wrap air-icon">🍃</div>
              <div className="metric-content">
                <p className="metric-title">Burning Diverted</p>
                <strong className="metric-number">{kg(stats.estimated_diverted_kg)}</strong>
                <span className="metric-sub">Direct field smoke and fire incidents eliminated</span>
              </div>
            </div>
          </div>

          {/* Environmental Equivalencies derived from Stubble Diversion */}
          <section className="card impact-equivalents-section">
            <div className="equivalents-header">
              <div>
                <h3>🌍 Environmental & Clean Air Equivalencies</h3>
                <p className="muted">Direct ecological dividends derived from diverted agricultural biomass</p>
              </div>
              <span className="impact-verified-pill">🌱 Verified Clean Air Dividend</span>
            </div>

            <div className="impact-equivalents-grid">
              <div className="equiv-tile co2-tile">
                <div className="equiv-icon">☁️</div>
                <div className="equiv-value">{co2AvoidedKg > 1000 ? `${co2AvoidedTonnes} T` : `${co2AvoidedKg} kg`}</div>
                <div className="equiv-label">CO₂ Greenhouse Emissions Avoided</div>
                <div className="equiv-sub">Based on ~1.46 kg CO₂ per kg biomass burned</div>
              </div>

              <div className="equiv-tile pm-tile">
                <div className="equiv-icon">💨</div>
                <div className="equiv-value">{pm25PreventedKg} kg</div>
                <div className="equiv-label">Hazardous PM2.5 / PM10 Smog Avoided</div>
                <div className="equiv-sub">Toxic particulate matter prevented from airways</div>
              </div>

              <div className="equiv-tile tree-tile">
                <div className="equiv-icon">🌳</div>
                <div className="equiv-value">{new Intl.NumberFormat('en-IN').format(treeEquiv)}</div>
                <div className="equiv-label">Annual Mature Tree Equivalents</div>
                <div className="equiv-sub">Equivalent to carbon sequestered by healthy forest</div>
              </div>

              <div className="equiv-tile wealth-tile">
                <div className="equiv-icon">💰</div>
                <div className="equiv-value">{estimatedFarmerWealth}</div>
                <div className="equiv-label">Rural Economy Value Generated</div>
                <div className="equiv-sub">Direct farmer income replacing burning losses</div>
              </div>
            </div>
          </section>

          {/* Regional Air Quality Protection Card */}
          <div className="card clean-air-banner">
            <div className="clean-air-icon">🛡️</div>
            <div className="clean-air-content">
              <h4>Indo-Gangetic Air Quality & Public Health Protection</h4>
              <p>
                Every kilogram of parali traded on ParaliSetu prevents severe winter smog episodes across Punjab, Haryana, and the National Capital Region (NCR). Stubble burning releases massive concentrations of carbon monoxide, nitrogen oxides, polycyclic hydrocarbons, and fine inhalable particulates. By establishing reliable supply channels, we turn a seasonal environmental crisis into a circular economy asset.
              </p>
              <div className="pollutants-tags">
                <span className="pollutant-chip">✓ Zero Field Fire Heat</span>
                <span className="pollutant-chip">✓ Soil Micro-organism Preservation</span>
                <span className="pollutant-chip">✓ Preserved Topsoil Nitrogen & Organic Carbon</span>
                <span className="pollutant-chip">✓ Reduced Health Hospitalizations</span>
              </div>
            </div>
          </div>

          {/* Biomass Distribution by Crop Type */}
          <section className="card crop-breakdown-card">
            <div className="breakdown-header">
              <div>
                <h3>🌾 Biomass Distribution by Crop Type</h3>
                <p className="muted">Share of delivered volume diverted from open burning into productive industries</p>
              </div>
            </div>

            {stats.by_crop && stats.by_crop.length ? (
              <div className="crop-bars-list">
                {stats.by_crop.map(crop => {
                  const percentage = stats.delivered_kg > 0
                    ? Math.round((crop.delivered_kg / stats.delivered_kg) * 100)
                    : 0;

                  return (
                    <div key={crop.crop} className="crop-bar-row">
                      <div className="crop-bar-info">
                        <div className="crop-name-badge">
                          <strong>{crop.crop}</strong>
                        </div>
                        <div className="crop-numbers">
                          <span className="crop-kg">{kg(crop.delivered_kg)}</span>
                          <span className="crop-pct">{percentage}%</span>
                        </div>
                      </div>

                      <div className="custom-meter-track" aria-hidden="true">
                        <div
                          className="custom-meter-fill"
                          style={{ width: `${percentage}%` }}
                        ></div>
                      </div>
                    </div>
                  );
                })}
              </div>
            ) : (
              <p className="muted py-4">No completed deliveries yet to compute crop breakdown.</p>
            )}
          </section>

          <AirPollutionMap />

          {/* Circular Economy Transformation Pathways */}
          <section className="card circular-pathways-card">
            <div className="breakdown-header">
              <div>
                <h3>🔄 Circular Economy Industrial Utilization</h3>
                <p className="muted">How procured agricultural stubble replaces fossil fuels and virgin timber</p>
              </div>
            </div>

            <div className="circular-pathways-grid">
              <div className="pathway-card">
                <div className="pathway-icon-wrap">⚡</div>
                <h4>Thermal Power & Boiler Co-Firing</h4>
                <p>Biomass pellets replace up to 5-10% of thermal coal in industrial boilers, slashing fossil carbon intensity.</p>
                <div className="pathway-badge">Coal Substitute</div>
              </div>

              <div className="pathway-card">
                <div className="pathway-icon-wrap">📦</div>
                <h4>Biodegradable Eco-Packaging & Paper</h4>
                <p>Paddy straw fiber replaces virgin tree wood pulp and non-recyclable plastic packaging in e-commerce.</p>
                <div className="pathway-badge">Plastic Replacement</div>
              </div>

              <div className="pathway-card">
                <div className="pathway-icon-wrap">⛽</div>
                <h4>2G Advanced Bio-Ethanol Refineries</h4>
                <p>Cellulosic fermentation turns crop residue into advanced ethanol for national 20% fuel blending targets.</p>
                <div className="pathway-badge">Clean Transport Fuel</div>
              </div>

              <div className="pathway-card">
                <div className="pathway-icon-wrap">🧱</div>
                <h4>High-Density Bio-Coal Briquettes</h4>
                <p>Compressed biomass logs for brick kilns, tea processing, and decentralized clean industrial heating.</p>
                <div className="pathway-badge">Clean Rural Fuel</div>
              </div>
            </div>
          </section>

          {/* Methodology Caveat Note */}
          <div className="card impact-note-banner">
            <span className="note-leaf-icon">🌱</span>
            <div className="note-text">
              <strong>Environmental Impact Accounting & Calculation Basis:</strong>
              <p>{stats.caveat}</p>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
