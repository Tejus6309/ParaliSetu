import { SignIn } from './SignIn';
import Splash from './Splash';
import { StrictMode, useEffect, useRef, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { api, ApiError, message } from './api';
import { Impact, ListingDetail, ManageListings, Marketplace, OrdersView } from './views';
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
      <summary aria-label="Account options"><span className="avatar">{user.name.trim().slice(0,1).toUpperCase()}</span>
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
    FARMER: [['listings', 'My listings'], ['orders', 'Requests & orders']],
    BUYER: [['market', 'Marketplace'], ['matches', 'Find matches'], ['orders', 'My orders']],
    LOGISTICS: [['orders', 'Delivery assignments']],
    ADMIN: [['moderation', 'Listing moderation'], ['orders', 'All orders']],
};
function Brand() {
    return <span className="brand"><ReferenceCrop className="brand-logo" region="999 89 164 146" />Parali<span>Setu</span></span>;
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
        return <><Alert error={startupError}/><SignIn register={route !== 'login'} onLogin={next => {
                location.hash = defaultPage[next.role];
                setUser(next);
                setStartupError('');
            }}/></>;
    const nav = [...mainNav[user.role], ['impact', 'Impact']];
    const details = /^listing\/(\d+)$/.exec(route);
    const page = route === 'profile' || nav.some(([key]) => key === route) ? route : defaultPage[user.role];
    return <>
    <a className="skip" href="#main" onClick={event => { event.preventDefault(); document.getElementById('main')?.focus(); }}>Skip to content</a>
    <header className="top"><div className="container top-inner"><Brand />
      <AccountMenu user={user} busy={busy} onLogout={() => void run(async () => {
          await api('/auth/logout', 'POST'); setUser(null); location.hash = 'welcome';
      })}/>
    </div></header>
    <nav className="nav" aria-label="Workspace"><div className="container nav-inner">{nav.map(([key, label]) => <a key={key} href={'#' + key} aria-current={!details && key === page ? 'page' : undefined}>{label}</a>)}</div></nav>
    <main id="main" tabIndex={-1} className={page === 'profile' ? 'profile-content' : 'container content'}><Alert error={error}/>
      {details && user.role === 'BUYER' ? <ListingDetail key={route} id={Number(details[1])}/>
            : page === 'market' || page === 'matches' ? <Marketplace key={page} matching={page === 'matches'}/>
                : page === 'orders' ? <OrdersView role={user.role}/>
                    : page === 'profile' ? <Profile user={user} roleLabel={roles[user.role]}/>
                    : page === 'impact' ? <Impact />
                        : <ManageListings key={page} admin={page === 'moderation'}/>}
    </main>
    <footer className="container foot">ParaliSetu <span>Crop residue, put to work.</span></footer>
  </>;
}
createRoot(document.getElementById('root')).render(
    <StrictMode>
      <Splash>
        <App />
      </Splash>
    </StrictMode>
);
