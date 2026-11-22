import './wind-leaves.css';

// SVG Leaf Type 1: Classic Paddy / Crop Leaf
function CropLeaf() {
  return (
    <svg viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
        d="M16 2C8 9 5 18 8 24C11 30 20 28 25 19C29 11 24 3 16 2Z"
        fill="currentColor"
        fillOpacity="0.85"
      />
      <path
        d="M16 3C14 11 15 19 9 24"
        stroke="rgba(255, 255, 255, 0.45)"
        strokeWidth="1.2"
        strokeLinecap="round"
      />
      <path
        d="M15 12C12 14 9 15 8 16"
        stroke="rgba(255, 255, 255, 0.35)"
        strokeWidth="0.8"
        strokeLinecap="round"
      />
      <path
        d="M16 16C19 18 21 20 22 21"
        stroke="rgba(255, 255, 255, 0.35)"
        strokeWidth="0.8"
        strokeLinecap="round"
      />
    </svg>
  );
}

// SVG Leaf Type 2: Slender Golden Parali Straw Blade
function StrawBlade() {
  return (
    <svg viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
        d="M4 32C8 24 16 12 32 4C28 14 18 26 4 32Z"
        fill="currentColor"
        fillOpacity="0.88"
      />
      <path
        d="M5 31C13 22 22 13 31 5"
        stroke="rgba(255, 255, 255, 0.5)"
        strokeWidth="1"
        strokeLinecap="round"
      />
    </svg>
  );
}

// SVG Leaf Type 3: Tender Farm Sprout Leaf
function SproutLeaf() {
  return (
    <svg viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
        d="M14 2C6 2 2 8 2 15C2 21 6 25 12 26C20 26 26 19 26 10C26 5 21 2 14 2Z"
        fill="currentColor"
        fillOpacity="0.82"
      />
      <path
        d="M14 3C11 10 9 17 12 25"
        stroke="rgba(255, 255, 255, 0.45)"
        strokeWidth="1"
        strokeLinecap="round"
      />
    </svg>
  );
}

export function WindLeavesBackground() {
  const leaves = [
    { id: 1, type: 'crop', cls: 'leaf-1' },
    { id: 2, type: 'straw', cls: 'leaf-2' },
    { id: 3, type: 'sprout', cls: 'leaf-3' },
    { id: 4, type: 'straw', cls: 'leaf-4' },
    { id: 5, type: 'crop', cls: 'leaf-5' },
    { id: 6, type: 'straw', cls: 'leaf-6' },
    { id: 7, type: 'sprout', cls: 'leaf-7' },
    { id: 8, type: 'straw', cls: 'leaf-8' },
    { id: 9, type: 'crop', cls: 'leaf-9' },
    { id: 10, type: 'straw', cls: 'leaf-10' },
    { id: 11, type: 'sprout', cls: 'leaf-11' },
    { id: 12, type: 'straw', cls: 'leaf-12' },
    { id: 13, type: 'crop', cls: 'leaf-13' },
    { id: 14, type: 'straw', cls: 'leaf-14' },
    { id: 15, type: 'sprout', cls: 'leaf-15' },
    { id: 16, type: 'straw', cls: 'leaf-16' },
  ];

  const chaffs = ['chaff-1', 'chaff-2', 'chaff-3', 'chaff-4', 'chaff-5', 'chaff-6', 'chaff-7'];

  return (
    <div className="ambient-wind-container" aria-hidden="true">
      {/* Lightest Bluish Glassy Ambient Backdrop Aura */}
      <div className="ambient-glass-glow"></div>

      {/* Increased Blowing Wind Breeze Stream Lines */}
      <svg
        className="wind-stream-canvas"
        viewBox="0 0 1440 900"
        fill="none"
        preserveAspectRatio="none"
      >
        <defs>
          <linearGradient id="windGlowCyan" x1="0%" y1="0%" x2="100%" y2="0%">
            <stop offset="0%" stopColor="#38bdf8" stopOpacity="0" />
            <stop offset="25%" stopColor="#0ea5e9" stopOpacity="0.45" />
            <stop offset="65%" stopColor="#38bdf8" stopOpacity="0.3" />
            <stop offset="100%" stopColor="#0284c7" stopOpacity="0" />
          </linearGradient>

          <linearGradient id="windGlowGreen" x1="0%" y1="0%" x2="100%" y2="0%">
            <stop offset="0%" stopColor="#22c55e" stopOpacity="0" />
            <stop offset="30%" stopColor="#4ade80" stopOpacity="0.45" />
            <stop offset="70%" stopColor="#16a34a" stopOpacity="0.35" />
            <stop offset="100%" stopColor="#15803d" stopOpacity="0" />
          </linearGradient>

          <linearGradient id="windGlowGold" x1="0%" y1="0%" x2="100%" y2="0%">
            <stop offset="0%" stopColor="#f59e0b" stopOpacity="0" />
            <stop offset="35%" stopColor="#fde047" stopOpacity="0.5" />
            <stop offset="75%" stopColor="#d97706" stopOpacity="0.3" />
            <stop offset="100%" stopColor="#b45309" stopOpacity="0" />
          </linearGradient>
        </defs>

        {/* Gust 1 - High air flow */}
        <path
          className="wind-line wind-line-1"
          d="M -120 90 C 240 40, 520 140, 920 70 C 1180 30, 1390 100, 1620 75"
          stroke="url(#windGlowCyan)"
          strokeWidth="3"
          strokeLinecap="round"
        />

        {/* Gust 2 - Upper mid current */}
        <path
          className="wind-line wind-line-2"
          d="M -150 220 C 200 170, 560 280, 940 210 C 1200 160, 1420 240, 1650 215"
          stroke="url(#windGlowGreen)"
          strokeWidth="2.8"
          strokeLinecap="round"
        />

        {/* Gust 3 - Center parali breeze */}
        <path
          className="wind-line wind-line-3"
          d="M -160 380 C 220 320, 600 440, 980 360 C 1240 310, 1440 390, 1680 365"
          stroke="url(#windGlowGold)"
          strokeWidth="3.2"
          strokeLinecap="round"
        />

        {/* Gust 4 - Lower mid current */}
        <path
          className="wind-line wind-line-4"
          d="M -100 540 C 280 480, 640 600, 1020 530 C 1260 480, 1450 560, 1640 535"
          stroke="url(#windGlowCyan)"
          strokeWidth="2.6"
          strokeLinecap="round"
        />

        {/* Gust 5 - Ground level field current */}
        <path
          className="wind-line wind-line-5"
          d="M -130 690 C 260 630, 620 740, 1040 670 C 1280 620, 1460 700, 1650 675"
          stroke="url(#windGlowGreen)"
          strokeWidth="3"
          strokeLinecap="round"
        />

        {/* Gust 6 - Bottom swirling breeze */}
        <path
          className="wind-line wind-line-6"
          d="M -90 840 C 310 790, 690 880, 1080 810 C 1300 770, 1490 840, 1660 820"
          stroke="url(#windGlowGold)"
          strokeWidth="2.5"
          strokeLinecap="round"
        />
      </svg>

      {/* Floating Golden Chaff / Pollen Motes Dancing in the Wind */}
      {chaffs.map(cls => (
        <div key={cls} className={`chaff-particle ${cls}`}></div>
      ))}

      {/* 16 Falling Leaves and Parali Straw Blades */}
      {leaves.map(leaf => (
        <div key={leaf.id} className={`leaf-particle ${leaf.cls}`}>
          {leaf.type === 'crop' && <CropLeaf />}
          {leaf.type === 'straw' && <StrawBlade />}
          {leaf.type === 'sprout' && <SproutLeaf />}
        </div>
      ))}
    </div>
  );
}
export default WindLeavesBackground;
