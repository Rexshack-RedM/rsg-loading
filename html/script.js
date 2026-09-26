const progressFill = document.getElementById('progressFill');
const percentText = document.getElementById('percentText');
const statusText = document.getElementById('statusText');
const tipText = document.getElementById('tipText');
const clockEl = document.getElementById('clock');
const brandTitle = document.getElementById('brandTitle');
const brandSubtitle = document.getElementById('brandSubtitle');
const footerResourceName = document.getElementById('footerResourceName');

// UI text: defaults in locales/en.json, overridden by the "text" block in config.json.
let locale = {
  brand_title: '',
  brand_subtitle: '',
  status_loading: '',
  status_ready: '',
  footer_resource_name: '',
  tips: []
};

let tipIndex = 0;
let tipInterval = null;
let tipDelay = 5000;

function applyLocale(data) {
  locale = Object.assign(locale, data);

  brandTitle.textContent = locale.brand_title;
  brandSubtitle.textContent = locale.brand_subtitle;
  statusText.textContent = locale.status_loading;
  footerResourceName.textContent = locale.footer_resource_name;

  if (locale.tips.length) {
    tipText.textContent = locale.tips[0];
  }

  if (tipInterval) clearInterval(tipInterval);
  tipInterval = setInterval(() => {
    if (!locale.tips.length) return;
    tipIndex = (tipIndex + 1) % locale.tips.length;
    tipText.style.opacity = 0;
    setTimeout(() => {
      tipText.textContent = locale.tips[tipIndex];
      tipText.style.opacity = 1;
    }, 250);
  }, tipDelay);
}

tipText.style.transition = 'opacity 0.25s ease';

// Background image — set "background_image" in config.json (path relative to html/, or a URL).
// If the image is missing or fails to load, the default dark gradient is shown.
function applyBackground(cfg) {
  const bg = document.getElementById('bg-image');
  if (!bg || !cfg || !cfg.background_image) return;
  if (typeof cfg.background_dim === 'number') {
    bg.style.setProperty('--bg-dim', Math.max(0, Math.min(1, cfg.background_dim)));
  }
  const img = new Image();
  img.onload = () => {
    bg.style.backgroundImage = `url("${cfg.background_image}")`;
    bg.classList.add('loaded');
  };
  img.src = cfg.background_image;
}

const FALLBACK_TEXT = {
  brand_title: 'Rex Shack',
  brand_subtitle: 'REDEMPTION AWAITS',
  status_loading: 'Loading...',
  status_ready: 'Ready.',
  footer_resource_name: 'rsg-loading',
  tips: ['Loading...']
};

const getJSON = (url) => fetch(url).then((r) => r.json()).catch(() => ({}));

// Load locale first, then config.json. Any keys in config.json "text" override the locale.
Promise.all([getJSON('locales/en.json'), getJSON('config.json')]).then(([loc, cfg]) => {
  if (typeof cfg.tip_interval_seconds === 'number' && cfg.tip_interval_seconds > 0) {
    tipDelay = cfg.tip_interval_seconds * 1000;
  }
  applyLocale(Object.assign({}, FALLBACK_TEXT, loc, cfg.text || {}));
  applyBackground(cfg);
});

function updateClock() {
  const now = new Date();
  const h = String(now.getHours()).padStart(2, '0');
  const m = String(now.getMinutes()).padStart(2, '0');
  clockEl.textContent = `${h}:${m}`;
}
updateClock();
setInterval(updateClock, 1000 * 30);

// Fallback simulated progress in case loadProgress events never fire
// (e.g. previewing this loading screen outside of RedM).
let simulated = 0;
let receivedRealProgress = false;
const simInterval = setInterval(() => {
  if (receivedRealProgress) {
    clearInterval(simInterval);
    return;
  }
  simulated = Math.min(simulated + Math.random() * 4, 96);
  setProgress(simulated);
}, 200);

function setProgress(pct) {
  pct = Math.max(0, Math.min(100, pct));
  progressFill.style.width = pct + '%';
  percentText.textContent = Math.floor(pct) + '%';
}

window.addEventListener('message', (event) => {
  const data = event.data || {};

  // Native RedM/FiveM loadProgress event: { loadFraction: 0..1 }
  if (typeof data.loadFraction === 'number') {
    receivedRealProgress = true;
    setProgress(data.loadFraction * 100);
  }

  // Native onLoadDone-ish signal / custom "endLoading" NUI message
  if (data.eventName === 'endLoading' || data.type === 'endLoading') {
    finishLoading();
  }

  if (typeof data.statusText === 'string') {
    statusText.textContent = data.statusText;
  }
});

function finishLoading() {
  setProgress(100);
  statusText.textContent = locale.status_ready;
  setTimeout(() => {
    if (window.invokeNative) {
      window.invokeNative('shutdownLoadingScreenNui');
    }
    document.getElementById('root').classList.add('hidden');
  }, 400);
}

// Safety net: auto-finish after 45s if the game never signals completion.
setTimeout(finishLoading, 45000);
