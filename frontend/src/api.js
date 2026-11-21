export class ApiError extends Error {
    status;
    constructor(status, message) {
        super(message);
        this.status = status;
    }
}
export async function api(path, method = 'GET', body) {
    const response = await fetch('/api' + path, {
        method, headers: { 'X-Parali-Client': '1', ...(body === undefined ? {} : { 'Content-Type': 'application/json' }) },
        body: body === undefined ? undefined : JSON.stringify(body),
    });
    if (!response.ok) {
        const problem = await response.json().catch(() => ({}));
        const fields = Object.entries(problem.fields || {}).map(([key, message]) => key + ' ' + message);
        throw new ApiError(response.status, fields.length ? fields.join('. ') : problem.detail || 'Request failed (' + response.status + ').');
    }
    return (response.status === 204 || response.headers.get('content-length') === '0'
        ? undefined : await response.text().then(text => text ? JSON.parse(text) : undefined));
}
export const query = (values) => '?' + new URLSearchParams(values).toString();
export const kg = (value) => new Intl.NumberFormat('en-IN').format(value) + ' kg';
export const money = (value) => new Intl.NumberFormat('en-IN', { style: 'currency', currency: 'INR' }).format(value);
export const statusLabel = (value) => value.toLowerCase().replaceAll('_', ' ');
export const message = (error) => error instanceof Error ? error.message : 'Something went wrong.';
