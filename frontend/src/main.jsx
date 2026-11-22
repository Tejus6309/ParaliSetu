import Splash from "./Splash";
import { WindLeavesBackground } from "./WindLeavesBackground";
import { StrictMode, useEffect, useRef, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { api, ApiError, message } from './api';
import { Impact, ListingDetail, ManageListings, Marketplace, OrdersView } from './views';
import { Wallet } from './Wallet';
import { Feedback } from './Feedback';
import { Alert, useAction } from './ui';
import './styles.css';
import { Profile } from './Welcome';
import artwork from './assets/paralisetu-story.jpg';

function ReferenceCrop({ region, className }) {
  return <svg className={className} aria-hidden="true" viewBox={region} preserveAspectRatio="xMidYMid slice">
    <image href={artwork} width="1280" height="853" />
  </svg>;
}

function AccountMenu({ user, busy, onLogout }) {
  const menu = useRef(null);
  useEffect(() => {
    function closeOutside(event) {
      if (!menu.current?.contains(event.target)) menu.current.open = false;
    }
    function escape(event) {
      if (event.key === 'Escape' && menu.current?.open) {
        menu.current.open = false;
        menu.current.querySelector('summary').focus();
      }
    }
    document.addEventListener('pointerdown', closeOutside);
    document.addEventListener('focusin', closeOutside);
    document.addEventListener('keydown', escape);
    return () => {
      document.removeEventListener('pointerdown', closeOutside);
      document.removeEventListener('focusin', closeOutside);
      document.removeEventListener('keydown', escape);
    };
  }, []);
  return <details className="account-menu" ref={menu}>
    <summary aria-label="Account options"><span className="avatar">{user.name.trim().slice(0, 1).toUpperCase()}</span>
      <span className="account-name">{user.name}</span><span aria-hidden="true">▾</span></summary>
    <div className="account-pop"><small>{roles[user.role]} account</small>
      <a href="#profile" onClick={() => { menu.current.open = false; }}>My profile</a>
      <button disabled={busy} onClick={onLogout}>Sign out</button>
    </div>
  </details>;
}

const roles = { FARMER: 'Farmer', BUYER: 'Buyer', LOGISTICS: 'Logistics', ADMIN: 'Admin' };
const defaultPage = { FARMER: 'listings', BUYER: 'market', LOGISTICS: 'orders', ADMIN: 'moderation' };
const mainNav = {
  FARMER: [['listings', '🌾 My listings'], ['orders', '📋 Requests & orders'], ['wallet', '💰 Wallet']],
  BUYER: [['market', '🏪 Marketplace'], ['orders', '📦 My orders'], ['wallet', '💰 Wallet']],
  LOGISTICS: [['orders', '🚛 Delivery assignments'], ['wallet', '💰 Wallet']],
  ADMIN: [['moderation', '🛡️ Listing moderation'], ['orders', '📑 All orders'], ['wallet', '💰 Wallet']],
};
function Brand() {
  return <span className="brand"><ReferenceCrop className="brand-logo" region="999 89 164 146" />Parali<span>Setu</span></span>;
}
function SignIn({ onLogin, initialRegister }) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const register = initialRegister;
  const [error, busy, run] = useAction();
  return <div className="auth-page">
    <header className="auth-header"><div className="auth-width"><a href="#welcome" aria-label="ParaliSetu home"><Brand /></a>
      <a className="auth-header-link" href={register ? '#login' : '#register'}>{register ? 'Sign in' : 'Join ParaliSetu'}</a>
    </div></header>
    <main className="auth-layout auth-width">
      <section className="farm-hero">
        <div className="hero-copy"><h1>Turn crop residue into opportunity.</h1>
          <p>Connect with farmers, buyers and transport partners to give each harvest a second life.</p></div>
      </section>
      <section className="auth-card">
        <nav aria-label="Account access" className="auth-tabs">
          <a href="#login" aria-current={!register ? 'page' : undefined}>Sign in</a>
          <a href="#register" aria-current={register ? 'page' : undefined}>Sign up</a>
        </nav>
        <form onSubmit={event => {
          event.preventDefault();
          const data = new FormData(event.currentTarget);
          void run(async () => onLogin(await api(register ? '/auth/register' : '/auth/login', 'POST', register ? { email, password, name: data.get('name'), role: data.get('role') } : { email, password })));
        }}>

          <h2>{register ? 'Create your account' : 'Welcome back'}</h2>
          <Alert error={error} />
          {register && <><label>Name<input name="name" required maxLength={100} autoComplete="name" /></label>
            <label>Role<select name="role"><option value="FARMER">Farmer</option><option value="BUYER">Buyer</option></select></label></>}
          <label>Email<input required type="email" value={email} onChange={e => setEmail(e.target.value)} autoComplete="email" maxLength={160} /></label>
          <label>Password<input required type="password" value={password} onChange={e => setPassword(e.target.value)} autoComplete={register ? 'new-password' : 'current-password'} minLength={register ? 10 : undefined} maxLength={72} /></label>
          <button className="primary" disabled={busy}>{register ? 'Create account' : 'Sign in'}</button>
          {!register && import.meta.env.VITE_DEMO_HINTS === 'true' && <div className="demo">
            <strong>Try a demo account</strong><p>Choose a role to fill the sign-in form.</p>
            <div className="actions">{Object.entries(roles).map(([role, label]) => <button type="button" key={role} onClick={() => { setEmail(role.toLowerCase() + '@demo.paralisetu.org'); setPassword('ParaliDemo123!'); }}>{label}</button>)}</div>
          </div>}
        </form>
      </section>
    </main></div>;
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
    return <><WindLeavesBackground /><Alert error={startupError} /><SignIn key={route} initialRegister={route === 'register'} onLogin={next => {
      location.hash = defaultPage[next.role];
      setUser(next);
      setStartupError('');
    }} /></>;
  const nav = [...mainNav[user.role], ['impact', '🌱 Impact'], ['feedback', '💬 Feedback']];
  const details = /^listing\/(\d+)$/.exec(route);
  const page = route === 'profile' || nav.some(([key]) => key === route) ? route : defaultPage[user.role];
  return <>
    <WindLeavesBackground />
    <a className="skip" href="#main" onClick={event => { event.preventDefault(); document.getElementById('main')?.focus(); }}>Skip to content</a>
    <header className="top"><div className="container top-inner"><Brand />
      <AccountMenu user={user} busy={busy} onLogout={() => void run(async () => {
        await api('/auth/logout', 'POST'); setUser(null); location.hash = 'welcome';
      })} />
    </div></header>
    <nav className="nav" aria-label="Workspace"><div className="container nav-inner">{nav.map(([key, label]) => <a key={key} href={'#' + key} aria-current={!details && key === page ? 'page' : undefined}>{label}</a>)}</div></nav>
    <main id="main" tabIndex={-1} className={page === 'profile' ? 'profile-content' : 'container content'}><Alert error={error} />
      {details && user.role === 'BUYER' ? <ListingDetail key={route} id={Number(details[1])} />
        : page === 'market' || page === 'matches' ? <Marketplace key={page} />
          : page === 'orders' ? <OrdersView role={user.role} />
            : page === 'profile' ? <Profile user={user} roleLabel={roles[user.role]} />
              : page === 'impact' ? <Impact />
                : page === 'feedback' ? <Feedback role={user.role} />
                  : page === 'wallet' ? <Wallet role={user.role} />
                    : <ManageListings key={page} admin={page === 'moderation'} />}
    </main>
    <footer className="site-footer">
      <div className="footer-inner">
        <div className="footer-grid">
          <div className="footer-brand-col">
            <div className="footer-logo">Parali<span>Setu</span></div>
            <p>Connecting farmers, buyers, and logistics partners to transform crop residue into sustainable value — ending stubble burning, one harvest at a time.</p>
            <div className="footer-social-row">
              <span className="footer-social-btn" title="Twitter">𝕏</span>
              <span className="footer-social-btn" title="LinkedIn">in</span>
              <span className="footer-social-btn" title="Instagram">📷</span>
              <span className="footer-social-btn" title="YouTube">▶</span>
            </div>
          </div>
          <div className="footer-col">
            <h4>Platform</h4>
            <ul>
              <li><a href="#market">Marketplace</a></li>
              <li><a href="#impact">Impact Dashboard</a></li>
              <li><a href="#feedback">Feedback</a></li>
              <li><a href="#wallet">Wallet</a></li>
            </ul>
          </div>
          <div className="footer-col">
            <h4>Help & Support</h4>
            <ul>
              <li><span>FAQs</span></li>
              <li><span>How It Works</span></li>
              <li><span>Seller Guide</span></li>
              <li><span>Buyer Guide</span></li>
              <li><span>Report an Issue</span></li>
            </ul>
          </div>
          <div className="footer-col">
            <h4>Contact Us</h4>
            <ul>
              <li><div className="footer-contact-item"><span className="footer-contact-icon">📧</span> support@paralisetu.org</div></li>
              <li><div className="footer-contact-item"><span className="footer-contact-icon">📞</span> +91 1800-XXX-XXXX</div></li>
              <li><div className="footer-contact-item"><span className="footer-contact-icon">📍</span> Chandigarh, India</div></li>
            </ul>
          </div>
        </div>
        <hr className="footer-divider" />
        <div className="footer-bottom">
          <div className="footer-bottom-left">
            © 2024–2026 ParaliSetu. All rights reserved.
            <div className="footer-badge-row">
              <span className="footer-badge">🌿 Carbon Neutral Platform</span>
              <span className="footer-badge">🛡️ Data Protected</span>
              <span className="footer-badge">🇮🇳 Made in India</span>
            </div>
          </div>
          <div className="footer-bottom-right">
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
            <a href="#">Cookie Policy</a>
          </div>
        </div>
      </div>
    </footer>
  </>;
}
createRoot(document.getElementById('root')).render(<StrictMode> <Splash>
  <App />
</Splash></StrictMode>);
