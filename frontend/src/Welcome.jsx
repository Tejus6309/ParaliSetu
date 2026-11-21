import './welcome.css';

export function Profile({ user, roleLabel }) {
  return <section className="profile-panel">
    <header className="profile-cover"><div>
      <span className="profile-avatar" aria-hidden="true">{user.name.slice(0,1).toUpperCase()}</span>
      <h1>{user.name}</h1><p>{roleLabel} account</p>
    </div></header>
    <div className="profile-details"><h2>My profile</h2>
      <dl>{[['Name', user.name], ['Email address', user.email], ['Account role', roleLabel]].map(([label,value]) =>
        <div key={label}><dt>{label}</dt><dd>{value}</dd></div>)}</dl>
      <a className="button primary" href="#workspace">Back to workspace</a>
    </div>
  </section>;
}
