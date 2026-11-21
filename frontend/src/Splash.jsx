import { useEffect, useState } from "react";
import "./splash.css";

export default function Splash({ children }) {
  const [show, setShow] = useState(true);
  const [exiting, setExiting] = useState(false);

  useEffect(() => {
    if (!show) return;

    // Trigger smooth fade-out exit towards the end of the narrative animation
    const exitTimer = setTimeout(() => {
      setExiting(true);
    }, 4800);

    // Unmount splash completely once exit animation finishes
    const finishTimer = setTimeout(() => {
      sessionStorage.setItem("splashSeen", "1");
      setShow(false);
    }, 5500);

    const handleKeyDown = (e) => {
      if (e.key === "Escape" || e.key === "Enter" || e.key === " ") {
        handleSkip();
      }
    };
    window.addEventListener("keydown", handleKeyDown);

    return () => {
      clearTimeout(exitTimer);
      clearTimeout(finishTimer);
      window.removeEventListener("keydown", handleKeyDown);
    };
  }, [show]);

  const handleSkip = (e) => {
    if (e) e.stopPropagation();
    setExiting(true);
    setTimeout(() => {
      sessionStorage.setItem("splashSeen", "1");
      setShow(false);
    }, 450);
  };

  return (
    <>
      {show && (
        <div
          className={`splash-overlay ${exiting ? "exiting" : ""}`}
          onClick={handleSkip}
          role="region"
          aria-label="Welcome animation"
        >
          {/* Skip Button */}
          <button
            type="button"
            className="splash-skip"
            onClick={handleSkip}
            aria-label="Skip intro animation"
          >
            Skip ✕
          </button>

          {/* Ambient Warm Golden Sunlight Glow */}
          <div className="splash-ambient-glow" aria-hidden="true" />

          {/* Golden Ripple Rings (Step 1) */}
          <div className="splash-ripples" aria-hidden="true">
            <div className="splash-ripple r1" />
            <div className="splash-ripple r2" />
            <div className="splash-ripple r3" />
          </div>

          {/* Floating Leaves (Atmosphere) */}
          <svg className="splash-leaf l1" viewBox="0 0 32 32" fill="none" aria-hidden="true">
            <path d="M6 26C6 26 8 16 18 10C28 4 28 6 28 6C28 6 26 16 16 22C6 28 6 26 6 26Z" fill="#588b35" />
            <path d="M8 24C14 18 20 12 26 8" stroke="#3b6320" strokeWidth="1.2" strokeLinecap="round" />
          </svg>
          <svg className="splash-leaf l2" viewBox="0 0 32 32" fill="none" aria-hidden="true">
            <path d="M26 26C26 26 24 16 14 10C4 4 4 6 4 6C4 6 6 16 16 22C26 28 26 26 26 26Z" fill="#71a842" />
            <path d="M24 24C18 18 12 12 6 8" stroke="#487524" strokeWidth="1.2" strokeLinecap="round" />
          </svg>
          <svg className="splash-leaf l3" viewBox="0 0 32 32" fill="none" aria-hidden="true">
            <path d="M6 26C6 26 8 16 18 10C28 4 28 6 28 6C28 6 26 16 16 22C6 28 6 26 6 26Z" fill="#93be56" />
          </svg>
          <svg className="splash-leaf l4" viewBox="0 0 32 32" fill="none" aria-hidden="true">
            <path d="M26 26C26 26 24 16 14 10C4 4 4 6 4 6C4 6 6 16 16 22C26 28 26 26 26 26Z" fill="#4d7f2c" />
          </svg>
          <svg className="splash-leaf l5" viewBox="0 0 32 32" fill="none" aria-hidden="true">
            <path d="M6 26C6 26 8 16 18 10C28 4 28 6 28 6C28 6 26 16 16 22C6 28 6 26 6 26Z" fill="#699f38" />
          </svg>

          {/* Central Progressive Narrative Stages */}
          <div className="splash-content">
            <div className="splash-stages">
              {/* Step 1: The glowing seed drop */}
              <img
                src="/anim_step1.png"
                alt=""
                className="stage-seed"
                aria-hidden="true"
              />

              {/* Step 2: Sprouting leaves, rising sun & field furrows */}
              <img
                src="/anim_step2.png"
                alt=""
                className="stage-sprout"
                aria-hidden="true"
              />

              {/* Step 3: Complete sharp high-res logo emblem */}
              <img
                src="/logo.png"
                alt="ParaliSetu Logo"
                className="stage-emblem"
              />

              {/* Gentle shimmer across the emblem */}
              <div className="splash-shimmer" aria-hidden="true" />
            </div>

            {/* Brand Typography */}
            <h1 className="splash-title">
              <span className="splash-title-parali">Parali</span>
              <span className="splash-title-setu">Setu</span>
            </h1>

            {/* Step 4: Tagline */}
            <div className="splash-tagline">
              <span className="splash-line" aria-hidden="true" />
              <span className="splash-tag-text">
                Connect · Trade · Build a Greener India
              </span>
              <span className="splash-line" aria-hidden="true" />
            </div>
          </div>

          {/* Rolling Agricultural Green Landscape */}
          <svg
            className="splash-landscape"
            viewBox="0 0 1440 260"
            fill="none"
            preserveAspectRatio="none"
            aria-hidden="true"
          >
            <defs>
              <linearGradient id="hillGrad1" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" stopColor="#a3c477" stopOpacity="0.45" />
                <stop offset="100%" stopColor="#7a9e4d" stopOpacity="0.65" />
              </linearGradient>
              <linearGradient id="hillGrad2" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" stopColor="#81ad4a" stopOpacity="0.75" />
                <stop offset="100%" stopColor="#5d8b30" stopOpacity="0.9" />
              </linearGradient>
              <linearGradient id="hillGrad3" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" stopColor="#5f9235" />
                <stop offset="100%" stopColor="#3c6a1d" />
              </linearGradient>
            </defs>
            <path
              d="M0 160 C320 80 540 180 880 120 C1140 70 1320 140 1440 110 L1440 260 L0 260 Z"
              fill="url(#hillGrad1)"
            />
            <path
              d="M0 190 C260 120 520 210 820 150 C1100 90 1280 180 1440 140 L1440 260 L0 260 Z"
              fill="url(#hillGrad2)"
            />
            <path
              d="M0 220 C360 150 680 240 1020 170 C1240 130 1380 190 1440 170 L1440 260 L0 260 Z"
              fill="url(#hillGrad3)"
            />
          </svg>
        </div>
      )}

      {children}
    </>
  );
}
