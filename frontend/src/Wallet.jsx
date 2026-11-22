import { useState } from 'react';
import { money } from './api';

/* ─── Mock demo data ─────────────────────────────────────────────────── */
const MOCK = {
  FARMER: {
    balance: 42750,
    totalEarned: 87400,
    totalWithdrawn: 44650,
    pendingClearance: 3200,
    bank: 'SBI ••••4821',
    transactions: [
      { id: 1, date: '2026-11-18', type: 'earning',    desc: 'Order #34 · Rice straw · 800 kg',    amount:  18400, status: 'settled' },
      { id: 2, date: '2026-11-14', type: 'withdrawal', desc: 'Bank transfer → SBI ••••4821',       amount: -12000, status: 'completed' },
      { id: 3, date: '2026-11-10', type: 'earning',    desc: 'Order #29 · Wheat stubble · 500 kg', amount:  11200, status: 'settled' },
      { id: 4, date: '2026-11-05', type: 'pending',    desc: 'Order #31 · Cotton stalks · 300 kg', amount:   3200, status: 'pending' },
      { id: 5, date: '2026-10-28', type: 'withdrawal', desc: 'Bank transfer → SBI ••••4821',       amount: -20000, status: 'completed' },
      { id: 6, date: '2026-10-20', type: 'earning',    desc: 'Order #22 · Rice straw · 1 200 kg',  amount:  28000, status: 'settled' },
      { id: 7, date: '2026-10-12', type: 'withdrawal', desc: 'Bank transfer → SBI ••••4821',       amount: -12650, status: 'completed' },
    ],
  },
  BUYER: {
    balance: 15800,
    totalEarned: 15800,
    totalWithdrawn: 0,
    pendingClearance: 0,
    bank: 'HDFC ••••2093',
    transactions: [
      { id: 1, date: '2026-11-16', type: 'earning',    desc: 'Cashback · Order #33 bulk purchase',  amount:  800,  status: 'settled' },
      { id: 2, date: '2026-11-01', type: 'earning',    desc: 'Referral bonus · 2 new sellers',      amount:  1500, status: 'settled' },
      { id: 3, date: '2026-10-22', type: 'earning',    desc: 'Cashback · Order #27 bulk purchase',  amount:  500,  status: 'settled' },
      { id: 4, date: '2026-10-10', type: 'pending',    desc: 'Cashback · Order #31 (processing)',   amount:  200,  status: 'pending' },
    ],
  },
  LOGISTICS: {
    balance: 9340,
    totalEarned: 23540,
    totalWithdrawn: 14200,
    pendingClearance: 1800,
    bank: 'PNB ••••7612',
    transactions: [
      { id: 1, date: '2026-11-19', type: 'earning',    desc: 'Delivery fee · Order #34 · 42 km',   amount:  1860, status: 'settled' },
      { id: 2, date: '2026-11-15', type: 'earning',    desc: 'Delivery fee · Order #32 · 28 km',   amount:  1240, status: 'settled' },
      { id: 3, date: '2026-11-12', type: 'pending',    desc: 'Delivery fee · Order #35 (transit)',  amount:  1800, status: 'pending' },
      { id: 4, date: '2026-11-08', type: 'withdrawal', desc: 'Bank transfer → PNB ••••7612',        amount: -8000, status: 'completed' },
      { id: 5, date: '2026-10-30', type: 'earning',    desc: 'Delivery fee · Order #28 · 61 km',   amount:  2700, status: 'settled' },
      { id: 6, date: '2026-10-20', type: 'withdrawal', desc: 'Bank transfer → PNB ••••7612',        amount: -6200, status: 'completed' },
      { id: 7, date: '2026-10-14', type: 'earning',    desc: 'Delivery fee · Order #24 · 35 km',   amount:  1540, status: 'settled' },
    ],
  },
  ADMIN: {
    balance: 318200,
    totalEarned: 1240000,
    totalWithdrawn: 921800,
    pendingClearance: 24600,
    bank: 'Platform settlement account',
    transactions: [
      { id: 1, date: '2026-11-18', type: 'earning',    desc: 'Platform fee · 14 orders settled',   amount:  42000, status: 'settled' },
      { id: 2, date: '2026-11-15', type: 'withdrawal', desc: 'Payout batch · 32 farmer accounts',  amount: -180000, status: 'completed' },
      { id: 3, date: '2026-11-10', type: 'earning',    desc: 'Platform fee · 11 orders settled',   amount:  33000, status: 'settled' },
      { id: 4, date: '2026-11-05', type: 'pending',    desc: 'Payout batch (processing) · 8 accs', amount: -24600,  status: 'pending' },
      { id: 5, date: '2026-10-28', type: 'earning',    desc: 'Platform fee · 18 orders settled',   amount:  54000, status: 'settled' },
    ],
  },
};

const BANKS = {
  FARMER:    ['SBI ••••4821', 'UCO Bank ••••3302'],
  BUYER:     ['HDFC ••••2093', 'Axis ••••7741'],
  LOGISTICS: ['PNB ••••7612', 'Canara ••••0821'],
  ADMIN:     ['Platform settlement account'],
};

const TYPE_ICON  = { earning: '💰', withdrawal: '🏦', pending: '⏳' };
const TYPE_LABEL = { earning: 'Earning', withdrawal: 'Withdrawal', pending: 'Pending' };

function formatDate(iso) {
  return new Date(iso).toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' });
}

export function Wallet({ role = 'FARMER' }) {
  const data = MOCK[role] ?? MOCK.FARMER;
  const banks = BANKS[role] ?? BANKS.FARMER;

  const [amount, setAmount]       = useState('');
  const [bank, setBank]           = useState(banks[0]);
  const [toast, setToast]         = useState('');
  const [filter, setFilter]       = useState('all');

  function requestWithdrawal(e) {
    e.preventDefault();
    const val = parseFloat(amount);
    if (!val || val <= 0) return;
    if (val > data.balance) {
      setToast('⚠️ Amount exceeds available balance.');
      return;
    }
    setToast(`✅ Withdrawal of ${money(val)} to ${bank} has been requested. Funds will arrive in 2–3 business days.`);
    setAmount('');
  }

  const txList = filter === 'all'
    ? data.transactions
    : data.transactions.filter(t => t.type === filter);

  return (
    <div className="wallet-page">
      {/* ── Balance hero ─────────────────────────── */}
      <div className="wallet-balance-card">
        <div className="wallet-balance-inner">
          <div>
            <div className="wallet-balance-label">Available Balance</div>
            <div className="wallet-balance-amount">{money(data.balance)}</div>
            <div className="wallet-balance-sub">Available for withdrawal · {data.bank}</div>
          </div>
          <div className="wallet-balance-icon" aria-hidden="true">💳</div>
        </div>
      </div>

      {/* ── Quick stats ───────────────────────────── */}
      <div className="wallet-quick-stats">
        <div className="wallet-stat-tile">
          <span className="wallet-stat-icon">📈</span>
          <span className="wallet-stat-value">{money(data.totalEarned)}</span>
          <span className="wallet-stat-label">Total Earned</span>
        </div>
        <div className="wallet-stat-tile">
          <span className="wallet-stat-icon">🏦</span>
          <span className="wallet-stat-value">{money(data.totalWithdrawn)}</span>
          <span className="wallet-stat-label">Total Withdrawn</span>
        </div>
        <div className="wallet-stat-tile pending">
          <span className="wallet-stat-icon">⏳</span>
          <span className="wallet-stat-value">{money(data.pendingClearance)}</span>
          <span className="wallet-stat-label">Pending Clearance</span>
        </div>
      </div>

      <div className="wallet-lower">
        {/* ── Withdraw panel ───────────────────────── */}
        {role !== 'ADMIN' && (
          <section className="withdraw-panel">
            <h2 className="wallet-section-title">💸 Withdraw Funds</h2>
            {toast && (
              <div className={`wallet-toast ${toast.startsWith('⚠') ? 'warn' : 'ok'}`}>
                {toast}
                <button className="wallet-toast-close" onClick={() => setToast('')} aria-label="Dismiss">✕</button>
              </div>
            )}
            <form className="withdraw-form" onSubmit={requestWithdrawal}>
              <label className="withdraw-label">
                Amount (₹)
                <div className="withdraw-input-wrap">
                  <span className="withdraw-currency">₹</span>
                  <input
                    className="withdraw-input"
                    type="number"
                    min="1"
                    max={data.balance}
                    step="1"
                    value={amount}
                    onChange={e => { setAmount(e.target.value); setToast(''); }}
                    placeholder="Enter amount"
                    required
                  />
                </div>
              </label>
              <label className="withdraw-label">
                Bank Account
                <select className="withdraw-select" value={bank} onChange={e => setBank(e.target.value)}>
                  {banks.map(b => <option key={b} value={b}>{b}</option>)}
                </select>
              </label>
              <button className="withdraw-btn" type="submit">
                Request Withdrawal
              </button>
            </form>
            <p className="withdraw-note">
              🕐 Withdrawals are processed within 2–3 business days to your registered bank account. Minimum ₹100.
            </p>
          </section>
        )}

        {/* ── Transaction history ──────────────────── */}
        <section className="transaction-section">
          <div className="tx-header">
            <h2 className="wallet-section-title">📋 Transaction History</h2>
            <div className="tx-filter-row">
              {['all', 'earning', 'withdrawal', 'pending'].map(f => (
                <button
                  key={f}
                  className={`tx-filter-btn${filter === f ? ' active' : ''}`}
                  onClick={() => setFilter(f)}
                >
                  {f === 'all' ? 'All' : TYPE_LABEL[f]}
                </button>
              ))}
            </div>
          </div>

          {txList.length === 0 ? (
            <div className="tx-empty">No transactions found.</div>
          ) : (
            <ul className="transaction-list">
              {txList.map(tx => (
                <li key={tx.id} className={`transaction-row tx-${tx.type}`}>
                  <span className="tx-icon" aria-hidden="true">{TYPE_ICON[tx.type]}</span>
                  <div className="tx-info">
                    <span className="tx-desc">{tx.desc}</span>
                    <span className="tx-date">{formatDate(tx.date)}</span>
                  </div>
                  <div className="tx-right">
                    <span className={`tx-amount ${tx.amount >= 0 ? 'tx-credit' : 'tx-debit'}`}>
                      {tx.amount >= 0 ? '+' : ''}{money(tx.amount)}
                    </span>
                    <span className={`tx-status-badge tx-status-${tx.status}`}>
                      {tx.status}
                    </span>
                  </div>
                </li>
              ))}
            </ul>
          )}
        </section>
      </div>
    </div>
  );
}
