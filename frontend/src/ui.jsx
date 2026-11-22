import { useEffect, useState } from 'react';
import { api, message, statusLabel } from './api';

export function useData(path) {
    const [state, setState] = useState();
    const [version, setVersion] = useState(0);
    useEffect(() => {
        if (!path)
            return;
        let current = true;
        api(path).then(data => { if (current)
            setState({ path, version, data }); })
            .catch(error => { if (current)
            setState({ path, version, error: message(error) }); });
        return () => { current = false; };
    }, [path, version]);
    const result = state?.path === path && state.version === version ? state : undefined;
    return { ...result, loading: !!path && !result, reload: () => setVersion(value => value + 1) };
}

export function useAction() {
    const [error, setError] = useState('');
    const [busy, setBusy] = useState(false);
    async function run(action) {
        setBusy(true);
        setError('');
        try {
            await action();
        }
        catch (error) {
            setError(message(error));
        }
        finally {
            setBusy(false);
        }
    }
    return [error, busy, run];
}

export function Alert({ error }) {
    if (!error) return null;
    return (
        <div role="alert" className="alert">
            <svg className="alert-icon" viewBox="0 0 20 20" fill="currentColor" width="18" height="18" aria-hidden="true">
                <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clipRule="evenodd" />
            </svg>
            <span>{error}</span>
        </div>
    );
}

export function Loading({ active }) {
    if (!active) return null;
    return (
        <div role="status" className="loading-state">
            <span className="loading-spinner" aria-hidden="true"></span>
            <span>Loading data…</span>
        </div>
    );
}

export function Status({ value }) {
    return (
        <span className="status" data-status={value}>
            <span className="status-dot" aria-hidden="true"></span>
            <span>{statusLabel(value)}</span>
        </span>
    );
}

export function PageTitle({ title, detail, action }) {
    return (
        <div className="page-title">
            <div className="page-title-main">
                <h1>{title}</h1>
                {detail && <p>{detail}</p>}
            </div>
            {action && <div className="page-title-action">{action}</div>}
        </div>
    );
}
