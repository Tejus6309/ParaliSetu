import { useEffect, useState } from 'react';
import { api, message, statusLabel } from './api';

export function PickupRoom({ orderId, role }) {
  const path = '/orders/' + orderId + '/pickup-room';
  const [open, setOpen] = useState(false);
  const [room, setRoom] = useState(null);
  const [error, setError] = useState('');
  const [busy, setBusy] = useState(false);

  useEffect(() => {
    if (!open) return;
    let active = true;
    let timer;
    async function refresh() {
      try {
        const next = await api(path);
        if (active) { setRoom(next); setError(''); }
      } catch (e) {
        if (active) setError(message(e));
      } finally {
        if (active) timer = setTimeout(refresh, 2000);
      }
    }
    refresh();
    return () => { active = false; clearTimeout(timer); };
  }, [open, path]);

  async function arrive() {
    setBusy(true);
    try { setRoom(await api(path + '/arrive', 'POST')); setError(''); }
    catch (e) { setError(message(e)); }
    finally { setBusy(false); }
  }

  const ownArrival = role === 'FARMER' ? room?.farmer_arrived_at : room?.carrier_arrived_at;

  return (
    <section className="pickup-room-section">
      <button
        type="button"
        className="pickup-toggle-btn"
        aria-expanded={open}
        onClick={() => setOpen(!open)}
      >
        <span className="pickup-pulse" aria-hidden="true"></span>
        <span>{open ? 'Hide dispatch check-in' : 'Live dispatch room'}</span>
        <span className="pickup-toggle-arrow">{open ? '▲' : '▼'}</span>
      </button>

      {open && (
        <div className="card pickup-box">
          <div className="pickup-header">
            <div>
              <h3>Dispatch Room #{orderId}</h3>
              <p className="muted">Coordinate pickup location check-in in real time</p>
            </div>
            <span className="pickup-live-badge">Live status</span>
          </div>

          {error && <div role="alert" className="alert">{error}</div>}

          {room ? (
            <div className="pickup-details">
              <div className="pickup-summary-strip">
                <span>📍 {room.district}</span>
                <span>🌾 {room.crop}</span>
                <span>⚖️ {new Intl.NumberFormat('en-IN').format(room.quantity_kg)} kg</span>
              </div>

              <div className="pickup-checkin-grid" aria-live="polite">
                <div className={`checkin-card ${room.farmer_arrived_at ? 'arrived' : 'pending'}`}>
                  <div className="checkin-role">🧑‍🌾 Farmer</div>
                  <div className="checkin-name">{room.farmer_name}</div>
                  <div className="checkin-status">
                    <span className="dot"></span>
                    {room.farmer_arrived_at ? 'Checked in at pickup site' : 'Awaiting arrival'}
                  </div>
                </div>

                <div className={`checkin-card ${room.carrier_arrived_at ? 'arrived' : 'pending'}`}>
                  <div className="checkin-role">🚛 Transport Partner</div>
                  <div className="checkin-name">{room.carrier_name}</div>
                  <div className="checkin-status">
                    <span className="dot"></span>
                    {room.carrier_arrived_at ? 'Checked in at pickup site' : 'En route / awaiting arrival'}
                  </div>
                </div>
              </div>

              <div className="pickup-verdict">
                {room.status !== 'ASSIGNED' ? (
                  <span className="verdict-closed">Dispatch stage: {statusLabel(room.status)}</span>
                ) : room.farmer_arrived_at && room.carrier_arrived_at ? (
                  <span className="verdict-ready">✓ Both participants arrived. Ready for cargo loading!</span>
                ) : (
                  <span className="verdict-waiting">⏳ Waiting for both parties to confirm site arrival.</span>
                )}
              </div>

              {room.status === 'ASSIGNED' && !ownArrival && (
                <button
                  type="button"
                  className="primary w-full arrive-btn"
                  disabled={busy}
                  onClick={arrive}
                >
                  📍 I have arrived at the pickup site
                </button>
              )}
            </div>
          ) : !error ? (
            <p className="muted py-2">Connecting to dispatch server…</p>
          ) : null}
        </div>
      )}
    </section>
  );
}
