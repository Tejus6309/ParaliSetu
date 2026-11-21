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
    return error ? <p role="alert" className="alert">{error}</p> : null;
}
export function Loading({ active }) {
    return active ? <p role="status">Loading…</p> : null;
}
export function Status({ value }) {
    return <span className="status" data-status={value}>{statusLabel(value)}</span>;
}
export function PageTitle({ title, detail }) {
    return <div className="page-title"><h1>{title}</h1><p>{detail}</p></div>;
}
