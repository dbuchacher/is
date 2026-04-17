// Atlas — loads lattice.json + slides.json, renders everything
const DIM_N = ['space','mass','signal','time'];
const DIM_F = ['L','M','Q','T'];
const DIM_C = ['var(--L)','var(--M)','var(--Q)','var(--T)'];

let DATA = [], allByCoord = new Map(), SLIDES = [];

function esc(s) { return (s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }
function ckey(c) { return c.join(','); }
function fmtCoord(c) {
  return c.map(v => {
    const s = v === 0.5 ? '½' : v > 0 ? '+'+v : ''+v;
    const cls = v > 0 ? 'p' : v < 0 ? 'n' : 'z';
    return `<span class="${cls}">${s}</span>`;
  }).join(' ');
}

// ── Box builders ──
function buildStaticBoxes(boxes) {
  return boxes.map(b => {
    const entries = allByCoord.get(ckey(b.coord)) || [];
    const names = entries.map(e => e.name).filter(Boolean);
    return `<div class="box" style="border-color:${b.color}30" onclick="showCoord([${b.coord}])">
      <div class="box-title" style="color:${b.color}">${b.title}</div>
      <div class="box-coord">${fmtCoord(b.coord)}</div>
      <div class="box-sub">${b.sub}</div>
      ${names.length ? `<div class="box-preview">${names.join(', ')}</div>` : ''}
    </div>`;
  }).join('');
}

function buildWaveBoxes(boxes) {
  const W = 1000, H = 440;
  const marginL = 60; // left margin for Y axis
  const marginR = 30;
  const plotW = W - marginL - marginR;
  const midY = H / 2;
  const amp = 160;

  // Y axis grid lines and labels
  const yLevels = [
    { val: 1,   label: '+1', color: 'var(--pos)' },
    { val: 0,   label: '  0', color: 'var(--zero)' },
    { val:-1,   label: '−1', color: 'var(--neg)' },
  ];
  let grid = '';
  for (const lv of yLevels) {
    const y = midY - lv.val * amp;
    const dashAttr = lv.dash ? 'stroke-dasharray="3 6"' : 'stroke-dasharray="4 4"';
    grid += `<line x1="${marginL}" y1="${y}" x2="${W-marginR}" y2="${y}" stroke="${lv.color}" stroke-width="1" opacity="0.2" ${dashAttr}/>`;
    grid += `<text x="${marginL-8}" y="${y+4}" fill="${lv.color}" font-size="11" font-family="inherit" text-anchor="end" opacity="0.6">${lv.label}</text>`;
  }

  // Y axis line
  grid += `<line x1="${marginL}" y1="${midY - amp - 20}" x2="${marginL}" y2="${midY + amp + 20}" stroke="var(--zero)" stroke-width="1" opacity="0.3"/>`;

  // Sine wave centered: phase -π to +π, so 0-crossing is at center
  let path = '';
  for (let px = 0; px <= plotW; px += 2) {
    const x = marginL + px;
    const t = (px / plotW) * 2 * Math.PI - Math.PI; // range: -π to +π
    const y = midY - Math.sin(t) * amp;
    path += (px === 0 ? 'M' : 'L') + x + ',' + y.toFixed(1);
  }

  // Centered layout: neutrino at center (phase 0), electron left, positron right
  // phase -π/2 = trough (electron) at x=25%
  // phase 0 = zero crossing rising (neutrino) at x=50%
  // phase π/6 = sin=½ (hylo) at x≈58%
  // phase π/2 = peak (positron) at x=75%
  const nodes = [
    { idx: 0, phase: -Math.PI/2,  val: -1,  isBond: false }, // electron at trough
    { idx: 1, phase: 0,           val: 0,   isBond: false }, // neutrino at center
    { idx: 3, phase: Math.PI/2,   val: 1,   isBond: false }, // positron at peak
  ];

  const nodeHtml = nodes.map(n => {
    const b = boxes[n.idx];
    // Convert phase to x position: phase -π maps to 0%, phase +π maps to 100%
    const xFrac = (n.phase + Math.PI) / (2 * Math.PI);
    const xPct = (marginL + xFrac * plotW) / W * 100;
    const yPct = (midY - n.val * amp) / H * 100;

    if (n.isBond) {
      // Bond = dot on the line + small label
      return `<div class="wave-box" style="left:${xPct}%;top:${yPct}%" onclick="showCoord([${b.coord}])">
        <div style="width:14px;height:14px;border-radius:50%;background:var(--Q);margin:0 auto;cursor:pointer;box-shadow:0 0 12px var(--Q)"></div>
        <div style="text-align:center;margin-top:6px;font-size:13px;font-weight:700;color:var(--Q);cursor:pointer">${b.title}</div>
        <div style="text-align:center;font-size:9px;color:var(--zero)">${b.sub}</div>
      </div>`;
    } else {
      // Node = compact box
      return `<div class="wave-box box" style="left:${xPct}%;top:${yPct}%;border-color:${b.color}30;min-width:100px;padding:10px 14px" onclick="showCoord([${b.coord}])">
        <div class="box-title" style="color:${b.color};font-size:15px">${b.title}</div>
        <div class="box-coord" style="font-size:9px">${fmtCoord(b.coord)}</div>
        <div class="box-sub" style="font-size:9px">${b.sub}</div>
      </div>`;
    }
  }).join('');

  return `<div class="wave-container" id="wave-container">
    <button class="spin-btn" onclick="document.getElementById('wave-container').classList.toggle('spinning')">⟳ spin</button>
    <div class="wave-inner">
      <svg class="wave-svg" viewBox="0 0 ${W} ${H}">
        ${grid}
        <path class="wave-line" d="${path}"/>
      </svg>
      ${nodeHtml}
    </div>
  </div>`;
}

function buildSingleBoxes() {
  return [0,1,2,3].map(d => {
    const plus = allByCoord.get(ckey([0,0,0,0].map((v,i)=>i===d?1:0))) || [];
    const minus = allByCoord.get(ckey([0,0,0,0].map((v,i)=>i===d?-1:0))) || [];
    const bond = allByCoord.get(ckey([0,0,0,0].map((v,i)=>i===d?0.5:0))) || [];
    const atomNames = [...plus,...minus].map(e=>e.name).filter(Boolean);
    const bondNames = bond.map(e=>e.name).filter(Boolean);
    return `<div class="box" style="border-color:${DIM_C[d]}30" onclick="showGroup([${d}])">
      <div class="box-title" style="color:${DIM_C[d]}">${DIM_F[d]}</div>
      <div class="box-sub">${DIM_N[d]}</div>
      <div class="box-stats"><span class="filled">${plus.length+minus.length}</span>/2 atoms</div>
      ${atomNames.length ? `<div class="box-preview">${atomNames.join(', ')}</div>` : ''}
      ${bondNames.length ? `<div class="box-bond">½ ${bondNames.join(', ')}</div>` : ''}
    </div>`;
  }).join('');
}

function buildMultiBoxes(n) {
  const combos = [];
  function pick(start, dims) {
    if (dims.length === n) { combos.push([...dims]); return; }
    for (let i = start; i < 4; i++) pick(i+1, [...dims, i]);
  }
  pick(0, []);

  return combos.map(dims => {
    function genSigns(k) {
      if (k===0) return [[]];
      const out=[], sub=genSigns(k-1);
      for (const s of sub) { out.push([...s,1]); out.push([...s,-1]); }
      return out;
    }
    const signs = genSigns(dims.length);
    let atomCount = 0, atomNames = [];
    for (const sg of signs) {
      const c = [0,0,0,0];
      dims.forEach((d,i) => c[d] = sg[i]);
      const k = ckey(c);
      if (n===4 && (k==='1,1,1,1' || k==='-1,-1,-1,-1')) continue;
      const entries = allByCoord.get(k) || [];
      if (entries.length) { atomCount++; atomNames.push(...entries.map(e=>e.name).filter(Boolean)); }
    }
    const bc = [0,0,0,0]; dims.forEach(d => bc[d] = 0.5);
    const bondEntries = n===4 ? [] : (allByCoord.get(ckey(bc)) || []);
    const bondNames = bondEntries.map(e=>e.name).filter(Boolean);
    const total = n===4 ? signs.length - 2 : signs.length;

    return `<div class="box" onclick="showGroup([${dims}])">
      <div class="box-title">${dims.map(d => `<span style="color:${DIM_C[d]}">${DIM_F[d]}</span>`).join('·')}</div>
      <div class="box-sub">${dims.map(d => DIM_N[d]).join(' · ')}</div>
      <div class="box-stats"><span class="filled">${atomCount}</span>/${total} atoms</div>
      ${atomNames.length ? `<div class="box-preview">${atomNames.slice(0,6).join(', ')}${atomNames.length>6?' ...':''}</div>` : ''}
      ${bondNames.length ? `<div class="box-bond">½ ${bondNames.join(', ')}</div>` : ''}
    </div>`;
  }).join('');
}

// ── Render slides ──
function renderSlides() {
  const container = document.getElementById('slides');
  let html = '';
  SLIDES.forEach((s, i) => {
    html += `<div class="slide" id="slide-${s.id}" data-idx="${i}">`;
    html += `<div class="slide-label">${s.label}</div>`;
    html += `<div class="slide-desc"><h2>${s.title}</h2><p>${s.desc}</p></div>`;

    // Build boxes
    if (s.id === 'diagonal' && s.boxes) {
      html += buildWaveBoxes(s.boxes);
    } else {
      html += '<div class="slide-boxes">';
      if (s.boxes) html += buildStaticBoxes(s.boxes);
      else if (s.generate === 'single') html += buildSingleBoxes();
      else if (s.generate && s.generate.startsWith('multi:')) html += buildMultiBoxes(parseInt(s.generate.split(':')[1]));
      html += '</div>';
    }

    // Deep sections
    if (s.deep && s.deep.length) {
      html += '<div class="deep">';
      for (const d of s.deep) {
        html += `<div class="deep-card" onclick="this.classList.toggle('open')">`;
        html += `<div class="deep-head"><span class="deep-arrow">▸</span><span class="deep-title">${d.title}</span><span class="deep-tag">${d.tag}</span></div>`;
        html += `<div class="deep-body">${d.body}</div></div>`;
      }
      html += '</div>';
    }
    if (i === 0) html += '<div class="scroll-hint">↓ scroll</div>';
    html += '</div>';
  });
  container.innerHTML = html;

  // Nav dots
  const nav = document.getElementById('nav');
  nav.innerHTML = SLIDES.map((s,i) =>
    `<button class="nav-dot${i===0?' active':''}" title="${s.title}" onclick="document.getElementById('slide-${s.id}').scrollIntoView({behavior:'smooth'})"></button>`
  ).join('');

  const observer = new IntersectionObserver(entries => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        const idx = e.target.dataset.idx;
        document.querySelectorAll('.nav-dot').forEach((d,i) =>
          d.classList.toggle('active', i === parseInt(idx)));
      }
    });
  }, { threshold: 0.5 });
  document.querySelectorAll('.slide').forEach(s => observer.observe(s));
}

// ── Detail views ──
function closeDetail() {
  document.getElementById('detail-overlay').style.display = 'none';
}

function openDetail() {
  history.pushState({ detail: true }, '');
}

window.addEventListener('popstate', e => {
  if (document.getElementById('detail-overlay').style.display === 'block') {
    closeDetail();
  }
});

document.addEventListener('keydown', e => { if (e.key === 'Escape') { closeDetail(); history.back(); } });

function showCoord(coord) {
  const entries = allByCoord.get(ckey(coord)) || [];
  if (!entries.length) return;
  let html = '<div class="detail-page">';
  for (const e of entries) html += renderEntryFull(e, coord);
  const anti = coord.map(v => v === 0.5 ? 0.5 : -v);
  if (anti.some((v,i) => v !== coord[i])) {
    const antiEntries = allByCoord.get(ckey(anti)) || [];
    if (antiEntries.length) {
      html += '<div class="section-title">Inverse</div>';
      for (const e of antiEntries) html += renderEntryFull(e, anti);
    }
  }
  html += '</div>';
  document.getElementById('detail-title').textContent = `${entries[0].formula || ''} — ${entries[0].name || ''}`;
  document.getElementById('detail-content').innerHTML = html;
  document.getElementById('detail-overlay').style.display = 'block';
  document.getElementById('detail-overlay').scrollTop = 0;
  openDetail();
}

function showGroup(dims) {
  function genSigns(k) {
    if (k===0) return [[]];
    const out=[], sub=genSigns(k-1);
    for (const s of sub) { out.push([...s,1]); out.push([...s,-1]); }
    return out;
  }
  const title = dims.map(d => DIM_F[d]).join('·') + ' — ' + dims.map(d => DIM_N[d]).join(' + ');
  let html = '<div class="detail-page">';

  const bc = [0,0,0,0]; dims.forEach(d => bc[d] = 0.5);
  const isQuad = dims.length === 4;
  const bondEntries = isQuad ? [] : (allByCoord.get(ckey(bc)) || []);
  if (bondEntries.length) {
    html += `<div class="coord-slot has-entry" style="border-color:var(--Q)40" onclick="showCoord([${bc}])">`;
    html += `<div style="display:flex;align-items:baseline;gap:8px"><span style="font-size:13px;font-weight:700;letter-spacing:2px">${fmtCoord(bc)}</span><span style="font-size:9px;color:var(--Q)">BOND</span></div>`;
    for (const b of bondEntries) {
      html += `<div style="display:flex;gap:12px;align-items:baseline;margin-top:4px">`;
      html += `<span style="color:var(--Q);font-weight:700">${esc(b.forces)}</span>`;
      html += `<span style="font-weight:600">${esc(b.name)}</span>`;
      html += `<span style="font-size:11px;color:var(--zero)">${esc(b.operation||'')}</span></div>`;
    }
    html += '</div><div style="text-align:center;font-size:10px;color:var(--zero);margin:12px 0">— atoms —</div>';
  }

  const signs = genSigns(dims.length);
  const seen = new Set();
  const isFixed = k => k === '1,1,1,1' || k === '-1,-1,-1,-1';
  for (const sg of signs) {
    const c = [0,0,0,0]; dims.forEach((d,i) => c[d] = sg[i]);
    const k = ckey(c);
    if (seen.has(k) || (isQuad && isFixed(k))) { seen.add(k); continue; }
    const anti = c.map(v => -v); const ak = ckey(anti);
    seen.add(k); seen.add(ak);
    if (isQuad && isFixed(ak)) continue;
    const entries = allByCoord.get(k) || [];
    const antiEntries = allByCoord.get(ak) || [];
    html += renderSlotBox(c, entries);
    html += '<div class="pair-divider"></div>';
    html += renderSlotBox(anti, antiEntries);
    html += '<div style="margin-bottom:20px"></div>';
  }
  html += '</div>';
  document.getElementById('detail-title').textContent = title;
  document.getElementById('detail-content').innerHTML = html;
  document.getElementById('detail-overlay').style.display = 'block';
  document.getElementById('detail-overlay').scrollTop = 0;
  openDetail();
}

function renderSlotBox(coord, entries) {
  const has = entries.length > 0;
  let html = `<div class="coord-slot ${has?'has-entry':''}" onclick="${has?`showCoord([${coord}])`:''}">`;
  html += `<div style="font-size:13px;font-weight:700;letter-spacing:2px">${fmtCoord(coord)}</div>`;
  if (!has) { html += '<div style="color:var(--zero);font-size:11px;font-style:italic;margin-top:4px">—</div>'; }
  else for (const e of entries) {
    html += `<div style="display:flex;gap:16px;align-items:baseline;margin-top:4px">`;
    html += `<span style="font-size:16px;color:var(--accent);font-weight:700">${esc(e.formula)}</span>`;
    html += `<span style="font-size:14px;font-weight:600">${esc(e.name)}</span></div>`;
    const fields = [e.physics&&`physics: ${esc(e.physics)}`, e.computing&&`computing: ${esc(e.computing)}`, e.element&&`element: ${esc(e.element)}`].filter(Boolean);
    for (const f of fields) html += `<div style="font-size:11px;color:var(--zero);margin-top:1px">${f}</div>`;
  }
  html += '</div>'; return html;
}

function renderEntryFull(e, coord) {
  let html = '<div class="detail-hero">';
  html += `<div class="hero-type">${e.type==='S'?'structural':e.type==='B'?'bond':'atom'} · ${esc(e.level)||'—'}</div>`;
  html += `<div class="hero-formula">${esc(e.formula)}</div>`;
  html += `<div class="hero-name">${esc(e.name)}</div>`;
  if (coord) html += `<div class="hero-coord">${fmtCoord(coord)}</div>`;
  html += '</div>';
  const pills = [e.physics&&['physics',e.physics], e.computing&&['computing',e.computing], e.element&&['element',e.element], e.shell!=null&&['shell',e.shell], e.conf&&['conf',e.conf]].filter(Boolean);
  if (pills.length) {
    html += '<div class="pills">';
    for (const [l,v] of pills) html += `<div class="pill"><span class="pill-l">${l}</span><span class="pill-v">${esc(''+v)}</span></div>`;
    html += '</div>';
  }
  const sections = [
    ['Identity', [['formula',e.formula],['name',e.name],['physics',e.physics],['computing',e.computing]]],
    ['Engineering', [['ee',e.ee],['network',e.network],['element',e.element]]],
    ['Bond', [['forces',e.forces],['pattern',e.pattern],['operation',e.operation],['asm',e.asm],['args',e.args]]],
    ['Structure', [['level',e.level],['shell',e.shell],['algebra',e.algebra]]],
    ['History', [['discovered',e.discovered]]],
  ];
  for (const [title, fields] of sections) {
    const active = fields.filter(([,v]) => v != null);
    if (!active.length) continue;
    html += `<div class="section-title">${title}</div><div class="field-grid">`;
    for (const [l,v] of active) html += `<div class="field-l">${l}</div><div class="field-v">${esc(''+v)}</div>`;
    html += '</div>';
  }
  return html;
}

// ── Init: load both JSON files ──
Promise.all([
  fetch('lattice.json').then(r => r.json()),
  fetch('slides.json').then(r => r.json()),
]).then(([lattice, slides]) => {
  DATA = lattice;
  SLIDES = slides;
  allByCoord = new Map();
  for (const p of DATA) {
    if (!p.coord) continue;
    const k = ckey(p.coord);
    if (!allByCoord.has(k)) allByCoord.set(k, []);
    allByCoord.get(k).push(p);
  }
  renderSlides();
});
