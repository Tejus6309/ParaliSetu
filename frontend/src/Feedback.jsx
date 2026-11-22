import { useState } from 'react';

const COMMUNITY_FEEDBACK = [
  {
    id: 1,
    name: 'Ramesh Kumar',
    role: 'Farmer',
    roleColor: '#1d5b32',
    rating: 5,
    date: 'Nov 15, 2026',
    emoji: '🌾',
    text: 'ParaliSetu has completely transformed how I manage my paddy straw. Instead of burning, I now sell it profitably. The platform is easy to use even on my basic smartphone.',
  },
  {
    id: 2,
    name: 'Priya Sharma',
    role: 'Buyer',
    roleColor: '#1e3a8a',
    rating: 4,
    date: 'Nov 10, 2026',
    emoji: '🌿',
    text: 'Sourcing agricultural biomass has never been this seamless. The logistics coordination is excellent and the quality of straw received has been consistently good.',
  },
  {
    id: 3,
    name: 'Arvind Singh',
    role: 'Logistics',
    roleColor: '#7c3aed',
    rating: 5,
    date: 'Nov 5, 2026',
    emoji: '🚜',
    text: 'Managing pickups and deliveries through the app is very efficient. The route planning and real-time updates help me serve more farmers in a day.',
  },
  {
    id: 4,
    name: 'Sunita Devi',
    role: 'Farmer',
    roleColor: '#1d5b32',
    rating: 4,
    date: 'Oct 28, 2026',
    emoji: '🌱',
    text: 'I was skeptical at first, but the support team was very patient. Now I regularly list my straw on the platform and have received payments within 48 hours every time.',
  },
];

function StarRating({ value, onChange, readOnly = false, size = 24 }) {
  const [hovered, setHovered] = useState(0);
  return (
    <span style={{ display: 'inline-flex', gap: 2 }}>
      {[1, 2, 3, 4, 5].map((star) => (
        <span
          key={star}
          onClick={() => !readOnly && onChange && onChange(star)}
          onMouseEnter={() => !readOnly && setHovered(star)}
          onMouseLeave={() => !readOnly && setHovered(0)}
          style={{
            fontSize: size,
            cursor: readOnly ? 'default' : 'pointer',
            color: star <= (hovered || value) ? '#f59e0b' : '#d1d5db',
            transition: 'color 0.15s',
            userSelect: 'none',
          }}
          aria-label={`${star} star${star > 1 ? 's' : ''}`}
        >
          ★
        </span>
      ))}
    </span>
  );
}

function AvatarCircle({ name, bgColor }) {
  return (
    <div
      style={{
        width: 44,
        height: 44,
        borderRadius: '50%',
        background: bgColor || '#1d5b32',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        color: '#fff',
        fontWeight: 700,
        fontSize: 20,
        flexShrink: 0,
        boxShadow: '0 2px 8px rgba(0,0,0,0.13)',
      }}
    >
      {name ? name[0].toUpperCase() : '?'}
    </div>
  );
}

export function Feedback({ role = 'FARMER' }) {
  const defaultName =
    role === 'FARMER'
      ? 'Farmer User'
      : role === 'BUYER'
      ? 'Buyer User'
      : role === 'LOGISTICS'
      ? 'Logistics User'
      : '';

  const [formName, setFormName] = useState(defaultName);
  const [formRole, setFormRole] = useState(
    role === 'FARMER'
      ? 'Farmer'
      : role === 'BUYER'
      ? 'Buyer'
      : role === 'LOGISTICS'
      ? 'Logistics'
      : 'Other'
  );
  const [subject, setSubject] = useState('');
  const [rating, setRating] = useState(0);
  const [message, setMessage] = useState('');
  const [photo, setPhoto] = useState(null);
  const [photoPreview, setPhotoPreview] = useState(null);
  const [submitted, setSubmitted] = useState(false);

  const MAX_CHARS = 1000;

  function handlePhotoChange(e) {
    const file = e.target.files[0];
    if (file) {
      setPhoto(file);
      setPhotoPreview(URL.createObjectURL(file));
    }
  }

  function handleSubmit(e) {
    e.preventDefault();
    if (!rating) return alert('Please select a star rating.');
    if (!subject) return alert('Please select a subject.');
    if (!message.trim()) return alert('Please enter a message.');
    setSubmitted(true);
  }

  const glassCard = {
    background: 'rgba(255,255,255,0.88)',
    backdropFilter: 'blur(18px)',
    WebkitBackdropFilter: 'blur(18px)',
    borderRadius: '1.25rem',
    boxShadow: '0 8px 32px rgba(29,91,50,0.10)',
    border: '1px solid rgba(255,255,255,0.7)',
    padding: '2rem',
    marginBottom: '2rem',
  };

  const inputStyle = {
    width: '100%',
    padding: '0.6rem 0.9rem',
    borderRadius: '0.6rem',
    border: '1.5px solid #d1fae5',
    fontSize: 15,
    background: 'rgba(255,255,255,0.7)',
    outline: 'none',
    boxSizing: 'border-box',
    transition: 'border-color 0.2s',
  };

  const labelStyle = {
    display: 'block',
    fontWeight: 600,
    color: '#14532d',
    marginBottom: 6,
    fontSize: 14,
  };

  const fieldWrap = { marginBottom: '1.1rem' };

  if (submitted) {
    return (
      <div style={{ maxWidth: 560, margin: '3rem auto', padding: '0 1rem' }}>
        <div
          style={{
            ...glassCard,
            textAlign: 'center',
            padding: '3rem 2rem',
          }}
        >
          <div
            style={{
              width: 72,
              height: 72,
              borderRadius: '50%',
              background: 'linear-gradient(135deg, #22c55e, #16a34a)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              margin: '0 auto 1.25rem',
              boxShadow: '0 4px 16px rgba(34,197,94,0.3)',
            }}
          >
            <svg width="38" height="38" viewBox="0 0 24 24" fill="none">
              <path
                d="M5 13l4 4L19 7"
                stroke="#fff"
                strokeWidth="2.5"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
          </div>
          <h2 style={{ color: '#14532d', marginBottom: 8, fontSize: '1.5rem' }}>
            Thank You!
          </h2>
          <p style={{ color: '#374151', fontSize: 15 }}>
            Your feedback has been submitted successfully. We appreciate you helping
            us improve ParaliSetu.
          </p>
          <button
            onClick={() => setSubmitted(false)}
            style={{
              marginTop: '1.5rem',
              padding: '0.6rem 1.6rem',
              borderRadius: '0.6rem',
              background: 'linear-gradient(135deg, #1d5b32, #14532d)',
              color: '#fff',
              fontWeight: 600,
              border: 'none',
              cursor: 'pointer',
              fontSize: 15,
            }}
          >
            Submit Another
          </button>
        </div>
      </div>
    );
  }

  return (
    <div style={{ maxWidth: 680, margin: '0 auto', padding: '0 1rem 3rem' }}>
      {/* Hero Title */}
      <div
        style={{
          background: 'linear-gradient(135deg, #1d5b32, #14532d)',
          borderRadius: '1.25rem',
          padding: '2.5rem 2rem',
          marginBottom: '2rem',
          marginTop: '1.5rem',
          textAlign: 'center',
          boxShadow: '0 8px 32px rgba(29,91,50,0.18)',
        }}
      >
        <div style={{ fontSize: 48, marginBottom: 10 }}>💬</div>
        <h1 style={{ color: '#fff', margin: 0, fontSize: '2rem', fontWeight: 700 }}>
          Share Your Feedback
        </h1>
        <p style={{ color: 'rgba(255,255,255,0.8)', marginTop: 8, fontSize: 15 }}>
          Help us grow and improve — your voice shapes the future of ParaliSetu.
        </p>
      </div>

      {/* Glassmorphic Form Card */}
      <div style={glassCard}>
        <h2 style={{ color: '#14532d', marginTop: 0, marginBottom: '1.5rem', fontSize: '1.2rem' }}>
          📝 Your Feedback
        </h2>
        <form onSubmit={handleSubmit} noValidate>
          {/* Name */}
          <div style={fieldWrap}>
            <label style={labelStyle}>Your Name</label>
            <input
              type="text"
              value={formName}
              onChange={(e) => setFormName(e.target.value)}
              placeholder="Enter your name"
              style={inputStyle}
              required
            />
          </div>

          {/* Role */}
          <div style={fieldWrap}>
            <label style={labelStyle}>Your Role</label>
            <select
              value={formRole}
              onChange={(e) => setFormRole(e.target.value)}
              style={inputStyle}
            >
              <option value="Farmer">Farmer</option>
              <option value="Buyer">Buyer</option>
              <option value="Logistics">Logistics</option>
              <option value="Other">Other</option>
            </select>
          </div>

          {/* Subject */}
          <div style={fieldWrap}>
            <label style={labelStyle}>Subject</label>
            <select
              value={subject}
              onChange={(e) => setSubject(e.target.value)}
              style={inputStyle}
              required
            >
              <option value="">— Select a subject —</option>
              <option value="Platform Experience">Platform Experience</option>
              <option value="Order Issue">Order Issue</option>
              <option value="Logistics Issue">Logistics Issue</option>
              <option value="Environmental Impact">Environmental Impact</option>
              <option value="Suggestion">Suggestion</option>
              <option value="Other">Other</option>
            </select>
          </div>

          {/* Star Rating */}
          <div style={fieldWrap}>
            <label style={labelStyle}>Rating</label>
            <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
              <StarRating value={rating} onChange={setRating} size={30} />
              {rating > 0 && (
                <span style={{ color: '#6b7280', fontSize: 13 }}>
                  {['', 'Poor', 'Fair', 'Good', 'Very Good', 'Excellent'][rating]}
                </span>
              )}
            </div>
          </div>

          {/* Message */}
          <div style={fieldWrap}>
            <label style={labelStyle}>
              Message
              <span
                style={{
                  float: 'right',
                  fontWeight: 400,
                  color: message.length > MAX_CHARS * 0.9 ? '#ef4444' : '#9ca3af',
                }}
              >
                {message.length}/{MAX_CHARS}
              </span>
            </label>
            <textarea
              value={message}
              onChange={(e) => {
                if (e.target.value.length <= MAX_CHARS) setMessage(e.target.value);
              }}
              placeholder="Share your experience, suggestions, or concerns…"
              rows={5}
              style={{ ...inputStyle, resize: 'vertical', fontFamily: 'inherit' }}
              required
            />
          </div>

          {/* Photo Upload */}
          <div style={fieldWrap}>
            <label style={labelStyle}>Attach a Photo (optional)</label>
            <input
              type="file"
              accept="image/*"
              onChange={handlePhotoChange}
              style={{
                display: 'block',
                fontSize: 14,
                color: '#374151',
                marginBottom: 10,
              }}
            />
            {photoPreview && (
              <div style={{ marginTop: 8 }}>
                <img
                  src={photoPreview}
                  alt="Preview"
                  style={{
                    width: 120,
                    height: 90,
                    objectFit: 'cover',
                    borderRadius: '0.6rem',
                    border: '2px solid #d1fae5',
                    boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
                  }}
                />
                <div style={{ fontSize: 12, color: '#6b7280', marginTop: 4 }}>
                  {photo && photo.name}
                </div>
              </div>
            )}
          </div>

          {/* Submit */}
          <button
            type="submit"
            style={{
              width: '100%',
              padding: '0.75rem',
              borderRadius: '0.75rem',
              background: 'linear-gradient(135deg, #1d5b32, #14532d)',
              color: '#fff',
              fontWeight: 700,
              fontSize: 16,
              border: 'none',
              cursor: 'pointer',
              marginTop: '0.5rem',
              boxShadow: '0 4px 14px rgba(29,91,50,0.25)',
              letterSpacing: 0.3,
              transition: 'opacity 0.2s',
            }}
          >
            Submit Feedback
          </button>
        </form>
      </div>

      {/* Recent Community Feedback */}
      <div style={{ marginTop: '0.5rem' }}>
        <h2
          style={{
            color: '#14532d',
            fontWeight: 700,
            fontSize: '1.2rem',
            marginBottom: '1.25rem',
            display: 'flex',
            alignItems: 'center',
            gap: 8,
          }}
        >
          🌍 Recent Community Feedback
        </h2>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
          {COMMUNITY_FEEDBACK.map((fb) => (
            <div
              key={fb.id}
              style={{
                ...glassCard,
                marginBottom: 0,
                padding: '1.3rem 1.5rem',
              }}
            >
              <div style={{ display: 'flex', alignItems: 'flex-start', gap: 12 }}>
                <AvatarCircle name={fb.name} bgColor={fb.roleColor} />
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      flexWrap: 'wrap',
                      gap: 8,
                      marginBottom: 4,
                    }}
                  >
                    <span style={{ fontWeight: 700, color: '#111827', fontSize: 15 }}>
                      {fb.name}
                    </span>
                    <span
                      style={{
                        background: fb.roleColor,
                        color: '#fff',
                        borderRadius: 20,
                        padding: '1px 10px',
                        fontSize: 11,
                        fontWeight: 600,
                        letterSpacing: 0.3,
                      }}
                    >
                      {fb.role}
                    </span>
                    <span style={{ color: '#9ca3af', fontSize: 12, marginLeft: 'auto' }}>
                      {fb.date}
                    </span>
                  </div>
                  <div style={{ marginBottom: 6 }}>
                    <StarRating value={fb.rating} readOnly size={16} />
                  </div>
                  <p
                    style={{
                      color: '#374151',
                      fontSize: 14,
                      lineHeight: 1.6,
                      margin: '0 0 10px',
                    }}
                  >
                    {fb.text}
                  </p>
                  {/* Photo Thumbnail Placeholder */}
                  <div
                    className="fb-photo-thumb"
                    style={{
                      display: 'inline-flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      width: 56,
                      height: 44,
                      borderRadius: '0.5rem',
                      background: '#1d5b32',
                      fontSize: 24,
                      boxShadow: '0 2px 6px rgba(29,91,50,0.2)',
                    }}
                    title="Photo attachment"
                  >
                    {fb.emoji}
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
