import './welcome.css';

const ROLE_ICONS = {
  FARMER: '🌾',
  BUYER: '🏪',
  LOGISTICS: '🚛',
  ADMIN: '🛡️',
};

export function Profile({ user, roleLabel }) {
  const roleKey = (user.role || roleLabel || '').toUpperCase();
  const roleIcon = ROLE_ICONS[roleKey] || '👤';

  const cardStyle = {
    background: 'rgba(255,255,255,0.88)',
    backdropFilter: 'blur(18px)',
    WebkitBackdropFilter: 'blur(18px)',
    borderRadius: '1.25rem',
    boxShadow: '0 4px 24px rgba(21,83,45,0.10), 0 1.5px 6px rgba(0,0,0,0.06)',
    border: '1px solid rgba(255,255,255,0.7)',
    padding: '1.75rem 2rem',
  };

  const rowStyle = {
    display: 'flex',
    alignItems: 'center',
    gap: '0.75rem',
    padding: '0.75rem 0',
    borderBottom: '1px solid rgba(21,83,45,0.07)',
  };

  const lastRowStyle = {
    ...rowStyle,
    borderBottom: 'none',
  };

  const labelStyle = {
    fontSize: '0.78rem',
    color: '#6b7280',
    fontWeight: 600,
    letterSpacing: '0.03em',
    textTransform: 'uppercase',
    minWidth: '120px',
  };

  const valueStyle = {
    fontSize: '0.97rem',
    color: '#1a2e1a',
    fontWeight: 500,
  };

  const toggleOn = {
    display: 'inline-flex',
    alignItems: 'center',
    padding: '0.25rem 0.9rem',
    borderRadius: '999px',
    background: 'linear-gradient(90deg, #1d5b32, #22c55e)',
    color: '#fff',
    fontWeight: 700,
    fontSize: '0.82rem',
    letterSpacing: '0.04em',
  };

  const toggleOff = {
    display: 'inline-flex',
    alignItems: 'center',
    padding: '0.25rem 0.9rem',
    borderRadius: '999px',
    background: '#e5e7eb',
    color: '#6b7280',
    fontWeight: 700,
    fontSize: '0.82rem',
    letterSpacing: '0.04em',
  };

  const statTile = {
    background: 'rgba(255,255,255,0.15)',
    border: '1px solid rgba(255,255,255,0.3)',
    borderRadius: '0.85rem',
    padding: '0.85rem 1.1rem',
    minWidth: '130px',
    textAlign: 'center',
  };

  const preferences = [
    { label: 'Email notifications for new orders', on: true },
    { label: 'SMS alerts for delivery updates', on: false },
    { label: 'Weekly impact report digest', on: true },
  ];

  const infoRows = [
    { icon: '👤', label: 'Name', value: user.name },
    { icon: '✉️', label: 'Email', value: user.email },
    { icon: '🏷️', label: 'Role', value: roleLabel || roleKey },
  ];

  const securityRows = [
    { icon: '🔒', label: 'Password', value: '••••••••••' },
    { icon: '🔐', label: 'Two-Factor Auth', value: 'Not configured' },
    { icon: '🕐', label: 'Last Login', value: 'Today' },
  ];

  return (
    <section style={{ maxWidth: '900px', margin: '0 auto', padding: '1.5rem 1rem 2.5rem', display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>

      {/* Hero Banner */}
      <div style={{
        background: 'linear-gradient(135deg, #1d5b32, #14532d)',
        borderRadius: '1.25rem',
        padding: '2rem 2.25rem',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        flexWrap: 'wrap',
        gap: '1.5rem',
        boxShadow: '0 6px 32px rgba(21,83,45,0.22)',
      }}>
        {/* Left: identity */}
        <div style={{ display: 'flex', alignItems: 'center', gap: '1.1rem' }}>
          <span style={{ fontSize: '2.8rem', lineHeight: 1 }}>{roleIcon}</span>
          <div>
            <div style={{ fontSize: '1.55rem', fontWeight: 800, color: '#fff', letterSpacing: '-0.01em' }}>{user.name}</div>
            <div style={{ fontSize: '0.95rem', color: 'rgba(255,255,255,0.78)', fontWeight: 500, marginTop: '0.2rem' }}>{roleLabel || roleKey}</div>
            <div style={{ fontSize: '0.82rem', color: 'rgba(255,255,255,0.55)', marginTop: '0.15rem' }}>Member since 2024</div>
          </div>
        </div>

        {/* Right: stat tiles */}
        <div style={{ display: 'flex', gap: '0.85rem', flexWrap: 'wrap' }}>
          <div style={statTile}>
            <div style={{ fontSize: '1.4rem' }}>{roleIcon}</div>
            <div style={{ color: '#fff', fontWeight: 700, fontSize: '0.82rem', marginTop: '0.3rem' }}>Platform Role</div>
            <div style={{ color: 'rgba(255,255,255,0.65)', fontSize: '0.75rem' }}>{roleLabel || roleKey}</div>
          </div>
          <div style={statTile}>
            <div style={{ fontSize: '1.4rem' }}>✅</div>
            <div style={{ color: '#fff', fontWeight: 700, fontSize: '0.82rem', marginTop: '0.3rem' }}>Account Status</div>
            <div style={{ color: 'rgba(255,255,255,0.65)', fontSize: '0.75rem' }}>Active</div>
          </div>
          <div style={statTile}>
            <div style={{ fontSize: '1.4rem' }}>🏅</div>
            <div style={{ color: '#fff', fontWeight: 700, fontSize: '0.82rem', marginTop: '0.3rem' }}>Verified Member</div>
            <div style={{ color: 'rgba(255,255,255,0.65)', fontSize: '0.75rem' }}>Yes</div>
          </div>
        </div>
      </div>

      {/* 2-column info + security */}
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.25rem' }}>

        {/* Account Information */}
        <div style={cardStyle}>
          <div style={{ fontWeight: 800, fontSize: '1rem', color: '#1d5b32', marginBottom: '0.5rem', letterSpacing: '-0.01em' }}>Account Information</div>
          {infoRows.map(({ icon, label, value }, i) => (
            <div key={label} style={i === infoRows.length - 1 ? lastRowStyle : rowStyle}>
              <span style={{ fontSize: '1.1rem' }}>{icon}</span>
              <span style={labelStyle}>{label}</span>
              <span style={valueStyle}>{value}</span>
            </div>
          ))}
        </div>

        {/* Account Security */}
        <div style={cardStyle}>
          <div style={{ fontWeight: 800, fontSize: '1rem', color: '#1d5b32', marginBottom: '0.5rem', letterSpacing: '-0.01em' }}>Account Security</div>
          {securityRows.map(({ icon, label, value }, i) => (
            <div key={label} style={i === securityRows.length - 1 ? lastRowStyle : rowStyle}>
              <span style={{ fontSize: '1.1rem' }}>{icon}</span>
              <span style={labelStyle}>{label}</span>
              <span style={valueStyle}>{value}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Preferences & Notifications */}
      <div style={cardStyle}>
        <div style={{ fontWeight: 800, fontSize: '1rem', color: '#1d5b32', marginBottom: '1rem', letterSpacing: '-0.01em' }}>Preferences &amp; Notifications</div>
        {preferences.map(({ label, on }, i) => (
          <div key={label} style={i === preferences.length - 1
            ? { ...lastRowStyle, justifyContent: 'space-between' }
            : { ...rowStyle, justifyContent: 'space-between' }}>
            <span style={{ fontSize: '0.96rem', color: '#1a2e1a', fontWeight: 500 }}>{label}</span>
            <span style={on ? toggleOn : toggleOff}>{on ? 'On' : 'Off'}</span>
          </div>
        ))}
      </div>

      {/* Manage Account / Danger Zone */}
      <div style={{ ...cardStyle, background: 'rgba(255,245,245,0.88)', border: '1px solid rgba(239,68,68,0.15)' }}>
        <div style={{ fontWeight: 800, fontSize: '1rem', color: '#b91c1c', marginBottom: '1rem', letterSpacing: '-0.01em' }}>Manage Account</div>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '1rem' }}>
          <a
            href="#"
            className="button primary"
            style={{
              display: 'inline-flex',
              alignItems: 'center',
              gap: '0.4rem',
              padding: '0.6rem 1.4rem',
              borderRadius: '0.75rem',
              background: 'linear-gradient(135deg, #1d5b32, #14532d)',
              color: '#fff',
              fontWeight: 700,
              fontSize: '0.93rem',
              textDecoration: 'none',
              boxShadow: '0 2px 8px rgba(21,83,45,0.18)',
            }}
          >
            ← Back to dashboard
          </a>
          <span style={{ fontSize: '0.84rem', color: '#9ca3af', fontStyle: 'italic' }}>
            Contact support to deactivate account
          </span>
        </div>
      </div>

    </section>
  );
}
