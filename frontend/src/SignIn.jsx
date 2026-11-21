import { useEffect, useRef, useState } from 'react';
import { api } from './api';
import { useAction } from './ui';
import './glass.css';

export function SignIn({ onLogin, register }) {
  const panel = useRef(null);
  const previousMode = useRef(register);
  useEffect(() => {
    if (previousMode.current === register) return;
    previousMode.current = register;
    panel.current?.querySelector('form:not([inert]) h1')?.focus({ preventScroll: true });
  }, [register]);

  return <main className="glass-login">
    <div className="glass-card">
      <header className="auth-brand">Parali<span>Setu</span></header>
      <div className="auth-panel" ref={panel}>
        <nav className="auth-switch" aria-label="Account access">
          <a href="#register" aria-current={register ? 'page' : undefined}>Create account</a>
          <a href="#login" aria-current={!register ? 'page' : undefined}>Sign in</a>
        </nav>
        <div className="auth-viewport">
          <div className="auth-track" data-register={register}>
            <AccountForm active={register} register onLogin={onLogin} />
            <AccountForm active={!register} register={false} onLogin={onLogin} />
          </div>
        </div>
      </div>
    </div>
  </main>;
}

function AccountForm({ active, register, onLogin }) {
  const [error, busy, run] = useAction();
  const [visible, setVisible] = useState(false);
  const formId = register ? 'signup' : 'signin';
  function submit(event) {
    event.preventDefault();
    const values = Object.fromEntries(new FormData(event.currentTarget));
    void run(async () => {
      const account = await api(register ? '/auth/register' : '/auth/login', 'POST', values);
      onLogin(account);
    });
  }
  return <div className="auth-slide">
      <form className="form-wrapper" inert={!active} onSubmit={submit} aria-labelledby={formId + '-title'}>
        <header className="auth-intro">
          <h1 id={formId + '-title'} tabIndex={-1}>{register ? 'Create your account' : 'Welcome back'}</h1>
        </header>
        {error && <p className="auth-error" role="alert">{error}</p>}
        {register && <div className="auth-profile-fields">
          <label>Full name<input name="name" required maxLength={100} autoComplete="name" /></label>
          <label>Account type<select name="role"><option value="FARMER">Farmer</option><option value="BUYER">Buyer</option></select></label>
        </div>}
        <label>Email address<input name="email" type="email" required maxLength={160} autoComplete="email" /></label>
        <div className="auth-password">
          <label htmlFor={formId + '-password'}>Password</label>
          <div className="auth-password-field">
            <input id={formId + '-password'} name="password" type={visible ? 'text' : 'password'} required
              minLength={register ? 10 : undefined} maxLength={72} autoComplete={register ? 'new-password' : 'current-password'}
              aria-describedby={register ? 'signup-password-hint' : undefined} />
            <button className="auth-toggle" type="button" aria-controls={formId + '-password'}
              aria-label={visible ? 'Hide password' : 'Show password'} onClick={() => setVisible(!visible)}>
              {visible ? 'Hide' : 'Show'}
            </button>
          </div>
          {register && <p className="auth-hint" id="signup-password-hint">Use at least 10 characters.</p>}
        </div>
        <button className="btn-action" disabled={busy}>
          {register ? (busy ? 'Creating account…' : 'Create account') : (busy ? 'Signing in…' : 'Sign in to dashboard')}
        </button>
      </form>
  </div>;
}
