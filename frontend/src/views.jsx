import { useState } from 'react';
import { api, kg, money, query } from './api';
import { orderActions } from './order-actions.mjs';
import { Alert, Loading, PageTitle, Status, useAction, useData } from './ui';
function ListingCard({ row, match, children }) {
    return <article className="card listing"><div className="spread">
    <p className="muted">{row.district} · {row.farmer_name}</p><Status value={row.status}/>
    </div><h2>{row.crop}</h2><p>{row.description}</p>
    <dl className="facts"><div><dt>Available stock</dt><dd>{kg(row.available_kg)}</dd></div>
      <div><dt>Price per kg</dt><dd>{money(row.price_per_kg)}</dd></div></dl>
    <p className="muted">Harvested {row.harvest_date}<br />Pickup window {row.available_from} to {row.available_until}</p>
    {match && <div className="note"><strong>Match score {match.score}/100</strong>
      <ul className="list-disc pl-5">{match.reasons.map(reason => <li key={reason}>{reason}</li>)}</ul></div>}
    {children}
  </article>;
}
export function Marketplace({ matching }) {
    const [filters, setFilters] = useState(matching ? '' : '/listings?');
    const [offset, setOffset] = useState(0);
    const path = matching ? filters : filters + '&offset=' + offset;
    const result = useData(path || null);
    return <>
    <PageTitle title={matching ? 'Find matching supply' : 'Residue marketplace'} detail={matching
            ? 'Find listings with enough stock. Preferred district and budget improve the score.'
            : 'Browse crop residue available from local farmers.'}/>
    <form className="card filters" onSubmit={event => {
            event.preventDefault();
            const values = new URLSearchParams();
            new FormData(event.currentTarget).forEach((value, key) => { if (typeof value === 'string' && value.trim())
                values.set(key, value.trim()); });
            setOffset(0);
            setFilters((matching ? '/matches' : '/listings') + query(values));
            result.reload();
        }}>
      {!matching && <label>Search<input name="q" placeholder="Crop, district or farmer" maxLength={100}/></label>}
      <label>Crop type<input name="crop" maxLength={40} list="crops" required={matching} placeholder="e.g. Rice straw"/></label>
      <label>{matching ? 'Preferred district' : 'District'}<input name="district" maxLength={80} required={matching} placeholder="e.g. Ludhiana"/></label>
      <label>{matching ? 'Quantity needed (kg)' : 'Minimum stock (kg)'}<input name={matching ? 'quantityKg' : 'minKg'} type="number" min={1} max={10000000} required={matching}/></label>
      {matching ? <label>Budget per kg (₹)<input name="maxPrice" type="number" min="0.01" step="0.01"/></label>
            : <label>Harvested on or after<input type="date" name="harvestAfter"/></label>}
      <button className="primary">{matching ? 'Find matches' : 'Search listings'}</button>
    </form>
    <datalist id="crops">{['Rice straw', 'Wheat straw', 'Maize stalks', 'Sugarcane trash', 'Cotton stalks'].map(crop => <option key={crop} value={crop}/>)}</datalist>
    <Alert error={result.error}/><Loading active={result.loading}/>
    {result.data && <><p role="status" className="my-3">{result.data.length ? result.data.length + ' results on this page' : 'No listings fit those filters.'}</p>
      <div className="cards">{result.data.map(item => {
                const row = 'listing' in item ? item.listing : item;
                return <ListingCard key={row.id} row={row} match={'listing' in item ? item : undefined}>
          <a className="button" href={'#listing/' + row.id}>View listing</a>
        </ListingCard>;
            })}</div>
      {!matching && (offset > 0 || result.data.length === 100) && <div className="actions mt-4">
        <button disabled={offset === 0} onClick={() => setOffset(offset - 100)}>Previous page</button>
        <button disabled={result.data.length < 100} onClick={() => setOffset(offset + 100)}>Next page</button></div>}
    </>}
  </>;
}
export function ListingDetail({ id }) {
    const result = useData('/listings/' + id);
    const [error, busy, run] = useAction();
    const [sent, setSent] = useState(false);
    const row = result.data;
    return <>
    <a href="#market" className="back">← Marketplace</a>
    <PageTitle title={row?.crop ?? 'Listing details'} detail="Review the listing and request the quantity you need."/>
    <Alert error={result.error}/><Loading active={result.loading}/>
    {row && <div className="cards"><ListingCard row={row}/><section className="card form">
      <h2>Purchase request</h2><p>Stock is reserved when the farmer accepts your request.</p>
      <Alert error={error}/>
      {sent ? <p role="status">Request sent. <a className="text-link" href="#orders">View my orders</a></p>
                : row.available_kg > 0 ? <form className="form" onSubmit={event => {
                        event.preventDefault();
                        const quantityKg = Number(new FormData(event.currentTarget).get('quantityKg'));
                        void run(async () => { await api('/orders', 'POST', { listingId: id, quantityKg }); setSent(true); });
                    }}><label>Quantity (kg)<input type="number" name="quantityKg" required min={1} max={Math.min(row.available_kg, 10000000)}/></label>
          <button className="primary" disabled={busy}>Send purchase request</button></form> : <p>This listing is sold out.</p>}
    </section></div>}
  </>;
}
export function ManageListings({ admin }) {
    const base = admin ? '/admin/listings' : '/farmer/listings';
    const result = useData(base);
    const [editor, setEditor] = useState(null);
    const [error, busy, run] = useAction();
    const row = editor === 'new' ? null : editor;
    function update(path, method, body) {
        void run(async () => { await api(path, method, body); result.reload(); });
    }
    return <>
    <PageTitle title={admin ? 'Listing moderation' : 'My residue listings'} detail={admin
            ? 'Review supply and remove or restore listings.' : 'Manage your available stock and pickup windows.'}/>
    {!admin && !editor && <button className="primary mb-5" onClick={() => setEditor('new')}>+ Create listing</button>}
    <Alert error={error || result.error}/><Loading active={result.loading}/>
    {editor && <form key={row?.id ?? 'new'} className="card form mb-4" onSubmit={event => {
                event.preventDefault();
                const values = new FormData(event.currentTarget);
                const input = { ...Object.fromEntries(values), availableKg: Number(values.get('availableKg')),
                    pricePerKg: Number(values.get('pricePerKg')), version: row?.version };
                void run(async () => {
                    await api(row ? base + '/' + row.id : base, row ? 'PUT' : 'POST', input);
                    setEditor(null);
                    result.reload();
                });
            }}>
      <h2>{row ? 'Edit listing' : 'Create a residue listing'}</h2>
      <div className="filters">
        <label>Crop<input name="crop" required maxLength={40} defaultValue={row?.crop}/></label>
        <label>District<input name="district" required maxLength={80} defaultValue={row?.district}/></label>
        <label>Unreserved stock (kg)<input name="availableKg" type="number" min={0} max={10000000} required defaultValue={row?.available_kg}/></label>
        <label>Price per kg (₹)<input name="pricePerKg" type="number" min="0.01" max="99999999.99" step="0.01" required defaultValue={row?.price_per_kg}/></label>
        <label>Harvest date<input name="harvestDate" type="date" required defaultValue={row?.harvest_date}/></label>
        <label>Available from<input name="availableFrom" type="date" required defaultValue={row?.available_from}/></label>
        <label>Available until<input name="availableUntil" type="date" required defaultValue={row?.available_until}/></label>
      </div>
      <label>Description<textarea name="description" required maxLength={1000} rows={3} defaultValue={row?.description}/></label>
      <div className="actions"><button className="primary" disabled={busy}>Save listing</button>
        <button type="button" disabled={busy} onClick={() => { setEditor(null); result.reload(); }}>Close editor</button></div>
    </form>}
    {result.data?.length === 0 && <p>No listings yet.</p>}
    <div className="cards">{result.data?.map(listing => {
            const path = base + '/' + listing.id;
            return <ListingCard row={listing} key={listing.id}><div className="actions">
        {admin ? <button disabled={busy} onClick={() => update(path + '/status', 'PATCH', { status: listing.status === 'REMOVED' ? 'PAUSED' : 'REMOVED' })}>
          {listing.status === 'REMOVED' ? 'Restore as paused' : 'Remove listing'}</button>
                    : <>
          {listing.status !== 'REMOVED' && <>
            <button disabled={busy || !!editor} onClick={() => setEditor(listing)}>Edit</button>
            <button disabled={busy} onClick={() => update(path + '/status', 'PATCH', { status: listing.status === 'ACTIVE' ? 'PAUSED' : 'ACTIVE' })}>{listing.status === 'ACTIVE' ? 'Pause' : 'Resume'}</button>
          </>}
          <button disabled={busy} className="danger" onClick={() => {
                            if (window.confirm('Delete this listing? Existing orders retain their history.'))
                                update(path, 'DELETE');
                        }}>Delete</button>
        </>}
      </div></ListingCard>;
        })}</div>
  </>;
}
const actionLabels = {
    ACCEPT: 'Accept & reserve', REJECT: 'Reject request', CANCEL: 'Cancel', ASSIGN: 'Assign pickup',
    PICK_UP: 'Mark picked up', DELIVER: 'Mark delivered',
};
export function OrdersView({ role }) {
    const result = useData('/orders');
    const carriers = useData(role === 'FARMER' ? '/carriers' : null);
    const [error, busy, run] = useAction();
    const title = { FARMER: 'Requests & orders', BUYER: 'My orders', LOGISTICS: 'Delivery assignments', ADMIN: 'All orders' }[role];
    return <>
    <PageTitle title={title} detail="Follow purchase requests and track confirmed orders through delivery."/>
    <Alert error={error || result.error || carriers.error}/><Loading active={result.loading}/>
    {result.data?.length === 0 && <p>No orders to display yet.</p>}
    <div className="form">{result.data?.map(order => <article className="card order" key={order.id}>
      <div><p className="muted">Order #{order.id} · {order.district}</p><h2>{order.crop}</h2>
        <p>{kg(order.quantity_kg)} at {money(order.price_per_kg)} per kg</p>
        <p className="muted">{order.farmer_name} → {order.buyer_name}</p>
        {order.carrier_name && <p className="muted">Transport by {order.carrier_name}</p>}</div>
      <div className="form order-side"><Status value={order.status}/>
        <div className="actions">{orderActions(role, order.status).map(action => {
                const submit = (carrierId) => {
                    if (action === 'CANCEL' && !window.confirm('Cancel this order?'))
                        return;
                    void run(async () => { await api('/orders/' + order.id, 'PATCH', { action, carrierId }); result.reload(); });
                };
                return action === 'ASSIGN' ? <form key={action} className="form" onSubmit={event => {
                        event.preventDefault();
                        submit(Number(new FormData(event.currentTarget).get('carrierId')));
                    }}><label>Transport provider<select name="carrierId" required>
            <option value="">Choose provider</option>{carriers.data?.map(carrier => <option key={carrier.id} value={carrier.id}>{carrier.name}</option>)}
          </select></label><button className="primary" disabled={busy}>{actionLabels[action]}</button></form>
                    : <button key={action} disabled={busy} className={['CANCEL', 'REJECT'].includes(action) ? 'danger' : 'primary'} onClick={() => submit()}>{actionLabels[action]}</button>;
            })}</div>
      </div>
    </article>)}</div>
  </>;
}
export function Impact() {
    const result = useData('/impact');
    const stats = result.data;
    return <>
    <PageTitle title="Marketplace impact" detail="Platform-wide totals from deliveries marked complete by their transport provider."/>
    <Alert error={result.error}/><Loading active={result.loading}/>
    {stats && <>
      <div className="cards metrics">
        <div className="card"><p>Residue delivered</p><strong>{kg(stats.delivered_kg)}</strong></div>
        <div className="card"><p>Completed deliveries</p><strong>{stats.deliveries}</strong></div>
        <div className="card"><p>Estimated burning diversion</p><strong>{kg(stats.estimated_diverted_kg)}</strong></div>
      </div>
      <p className="note my-4">{stats.caveat}</p>
      <section className="card"><h2>Delivered by crop</h2>
        {stats.by_crop.length ? <dl className="form mt-3">{stats.by_crop.map(crop => <div key={crop.crop}>
          <div className="spread"><dt>{crop.crop}</dt><dd>{kg(crop.delivered_kg)}</dd></div>
          <meter className="w-full" aria-label={crop.crop + ' share of delivered stock'} value={crop.delivered_kg} max={stats.delivered_kg}/></div>)}</dl> : <p>No completed deliveries yet.</p>}
      </section>
    </>}
  </>;
}
