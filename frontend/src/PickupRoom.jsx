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
    try { setRoom(await api(path + '/arrive','POST')); setError(''); }
    catch (e) { setError(message(e)); }
    finally { setBusy(false); }
  }
  const ownArrival = role === 'FARMER' ? room?.farmer_arrived_at : room?.carrier_arrived_at;
  return <section className="form">
    <button aria-expanded={open} onClick={() => setOpen(!open)}>{open ? 'Close pickup room' : 'Open pickup room'}</button>
    {open && <div className="card form"><h3>Pickup room #{orderId}</h3>
      {error && <p role="alert">{error}</p>}
      {room ? <><p>{room.district} · {room.crop} · {room.quantity_kg} kg</p>
        <div aria-live="polite"><p>{room.farmer_name}: {room.farmer_arrived_at ? 'At pickup' : 'Awaiting farmer'}</p>
          <p>{room.carrier_name}: {room.carrier_arrived_at ? 'At pickup' : 'Awaiting transport'}</p>
          <strong>{room.status !== 'ASSIGNED' ? 'Room closed · ' + statusLabel(room.status)
            : room.farmer_arrived_at && room.carrier_arrived_at ? 'Both participants are at pickup' : 'Waiting for check-in'}</strong></div>
        {room.status === 'ASSIGNED' && !ownArrival && <button className="primary" disabled={busy} onClick={arrive}>I am at the pickup site</button>}
      </> : !error && <p>Connecting…</p>}
    </div>}
  </section>;
}
