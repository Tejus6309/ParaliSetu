import { StrictMode, useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { api, ApiError, message } from './api';
import { Impact, ListingDetail, ManageListings, Marketplace, OrdersView } from './views';
import { Alert, useAction } from './ui';
import './styles.css';
const roles = { FARMER: 'Farmer', BUYER: 'Buyer', LOGISTICS: 'Logistics', ADMIN: 'Admin' };
const defaultPage = { FARMER: 'listings', BUYER: 'market', LOGISTICS: 'orders', ADMIN: 'moderation' };
const mainNav = {
    FARMER: [['listings', 'My listings'], ['orders', 'Requests & orders']],
    BUYER: [['market', 'Marketplace'], ['matches', 'Find matches'], ['orders', 'My orders']],
    LOGISTICS: [['orders', 'Delivery assignments']],
    ADMIN: [['moderation', 'Listing moderation'], ['orders', 'All orders']],
};
function Brand() {
    return <span className="brand"><span aria-hidden="true" className="brand-mark">🌾</span>Parali<span>Setu</span></span>;
}
function SignIn({ onLogin }) {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [register, setRegister] = useState(false);
    const [error, busy, run] = useAction();
    return <main className="welcome">
    <section className="welcome-intro">
      <Brand />
      <div><p className="eyebrow">CROP RESIDUE MARKETPLACE</p><h1>Give crop residue a second life.</h1>
      <p>Connect farms, biomass buyers and transport partners to put harvest leftovers to work.</p></div>
      <p className="intro-foot">From local supply to delivered residue.</p>
    </section>
    <section className="welcome-form">
      <form onSubmit={event => {
            event.preventDefault();
            const data = new FormData(event.currentTarget);
            void run(async () => onLogin(await api(register ? '/auth/register' : '/auth/login', 'POST', register ? { email, password, name: data.get('name'), role: data.get('role') } : { email, password })));
        }}>
        <p className="eyebrow">PARALISETU WORKSPACE</p>
        <h2>{register ? 'Create an account' : 'Sign in'}</h2>
        <Alert error={error}/>
        {register && <><label>Name<input name="name" required maxLength={100} autoComplete="name"/></label>
          <label>Role<select name="role"><option value="FARMER">Farmer</option><option value="BUYER">Buyer</option></select></label></>}
        <label>Email<input required type="email" value={email} onChange={e => setEmail(e.target.value)} autoComplete="email" maxLength={160}/></label>
        <label>Password<input required type="password" value={password} onChange={e => setPassword(e.target.value)} autoComplete={register ? 'new-password' : 'current-password'} minLength={register ? 10 : undefined} maxLength={72}/></label>
        <button className="primary" disabled={busy}>{register ? 'Create account' : 'Sign in'}</button>
        <button type="button" className="link" onClick={() => setRegister(!register)}>{register ? 'Back to sign in' : 'Create a farmer or buyer account'}</button>
        {!register && import.meta.env.VITE_DEMO_HINTS === 'true' && <div className="demo">
          <strong>Try a demo account</strong><p>Choose a role to fill the sign-in form.</p>
          <div className="actions">{Object.entries(roles).map(([role, label]) => <button type="button" key={role} onClick={() => { setEmail(role.toLowerCase() + '@demo.paralisetu.org'); setPassword('ParaliDemo123!'); }}>{label}</button>)}</div>
        </div>}
      </form>
    </section>
  </main>;
}
function App() {
    const [user, setUser] = useState();
    const [startupError, setStartupError] = useState('');
    const [error, busy, run] = useAction();
    const [route, setRoute] = useState(location.hash.slice(1));
    useEffect(() => {
        api('/auth/me').then(setUser).catch((e) => {
            if (!(e instanceof ApiError && e.status === 401))
                setStartupError(message(e));
            setUser(null);
        });
        const update = () => setRoute(location.hash.slice(1));
        window.addEventListener('hashchange', update);
        return () => window.removeEventListener('hashchange', update);
    }, []);
    if (user === undefined)
        return <main className="container py-12" role="status">Loading workspace…</main>;
    if (!user)
        return <><Alert error={startupError}/><SignIn onLogin={next => {
                location.hash = defaultPage[next.role];
                setUser(next);
                setStartupError('');
            }}/></>;
    const nav = [...mainNav[user.role], ['impact', 'Impact']];
    const details = /^listing\/(\d+)$/.exec(route);
    const page = nav.some(([key]) => key === route) ? route : defaultPage[user.role];
    return <>
    <a className="skip" href="#main" onClick={event => { event.preventDefault(); document.getElementById('main')?.focus(); }}>Skip to content</a>
    <header className="top"><div className="container top-inner"><Brand />
      <div className="account"><span>{user.name}<small>{roles[user.role]}</small></span>
        <button disabled={busy} onClick={() => void run(async () => { await api('/auth/logout', 'POST'); setUser(null); })}>Sign out</button></div>
    </div></header>
    <nav className="nav" aria-label="Workspace"><div className="container nav-inner">{nav.map(([key, label]) => <a key={key} href={'#' + key} aria-current={!details && key === page ? 'page' : undefined}>{label}</a>)}</div></nav>
    <main id="main" tabIndex={-1} className="container content"><Alert error={error}/>
      {details && user.role === 'BUYER' ? <ListingDetail key={route} id={Number(details[1])}/>
            : page === 'market' || page === 'matches' ? <Marketplace key={page} matching={page === 'matches'}/>
                : page === 'orders' ? <OrdersView role={user.role}/>
                    : page === 'impact' ? <Impact />
                        : <ManageListings key={page} admin={page === 'moderation'}/>}
    </main>
    <footer className="container foot">ParaliSetu <span>Crop residue, put to work.</span></footer>
  </>;
}
createRoot(document.getElementById('root')).render(<StrictMode><App /></StrictMode>);
