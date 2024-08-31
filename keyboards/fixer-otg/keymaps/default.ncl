let { tap, hold, td, combo, macro, .. } = import "fak/keycode.ncl" in
let util = import "fak/util_functions.ncl" in

let virtual_keys' = [
] in

let key_count = 40 + std.array.length virtual_keys' in

let kc = tap.reg.kc in
let ks = tap.reg.ks in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let me = tap.custom.media in
let MO = hold.reg.layer in
let tsm = tap.sticky.mod in

let ki = {
  hp = { decision = 'hold, trigger_on = 'press },
  tp = { decision = 'tap, trigger_on = 'press },
  hr = { decision = 'hold, trigger_on = 'release },
  tr = { decision = 'tap, trigger_on = 'release },
  xx = { decision = 'none },
} in

let XXXX = tap.none & hold.none in

let L' = fun layer => 
  let filler = std.array.replicate (key_count - std.array.length layer) XXXX in
  layer @ filler
in


let alphas = fun layout => layout
  |> std.string.characters
  |> util.array.enumerate
  |> std.array.map (fun { index, value } => kc."%{value}")
in

let cu = {
  SCSH = tm.lgui & tm.lsft & kc.S,
  PWSP = tm.lgui & kc.PGDN,
  NWSP = tm.lgui & kc.PGUP,
  CT =   tm.lctl & kc.TAB,
  CST =  tm.lctl & tm.lsft & kc.TAB,
  BOOT = tap.custom.fak.BOOT,
  PANL = tm.lctl & kc.LEFT,
  PANR = tm.lctl & kc.RIGHT,
  DRAGL = tm.lctl & tm.lsft & kc.LEFT,
  DRAGR = tm.lctl & tm.lsft & kc.RIGHT,
  AT = tm.lalt & kc.TAB
} in

let thumb = fun i =>
  let htb_generic = {
    timeout_ms = 200,
    quick_tap_ms = 150,
    key_interrupts = std.array.replicate key_count ki.hr,
  } in
  [
    kc.ESC & md.lgui & hold.reg.behavior htb_generic,
    kc.TAB & md.lctl & hold.reg.behavior htb_generic,
    kc.SPC & MO 1 & hold.reg.behavior htb_generic,
    XXXX & MO 2 & hold.reg.behavior htb_generic, # Not used
    kc.BSPC & md.lsft & hold.reg.behavior htb_generic,
    kc.ENT & md.lalt & hold.reg.behavior htb_generic,
  ]
  |> std.array.at i
in

# let m_window_l = macro.make [
#   macro.press md.lctl,
#   macro.tap kc.LEFT,
#   macro.release md.lctl
# ] in

# let m_drag_l = macro.make [
#   macro.press md.lctl,
#   macro.press md.lsft,
#   macro.tap kc.LEFT,
#   macro.release md.lsft,
#   macro.release md.lctl
# ] in

# let m_window_r = macro.make [
#   macro.press md.lctl,
#   macro.tap kc.RIGHT,
#   macro.release md.lctl
# ] in

# let m_drag_r = macro.make [
#   macro.press md.lctl,
#   macro.press md.lsft,
#   macro.tap kc.RIGHT,
#   macro.release md.lsft,
#   macro.release md.lctl
# ] in

let m_lambda = macro.make [
  macro.tap kc.EQL,
  macro.tap ks.RABK
] in

let LP_L0 = td.make 200 [ kc.A, MO 1 ] in
let niceTAB = td.make 200 [ kc.TAB, cu.AT ] in
let arrow_L = td.make 200 [ kc.LEFT, cu.PANL, cu.DRAGL ] in
let arrow_R = td.make 200 [ kc.RIGHT, cu.PANR, cu.DRAGR ] in
let zoomU = td.make 200 [ kc.UP, hold.none & kc.PGUP ] in
let zoomD = td.make 200 [ kc.DOWN, hold.none & kc.PGDN ] in
let lambda = td.make 200 [ kc.EQL, m_lambda ] in
let excellent_layering = td.make 200 [ md.lsft, MO 1, MO 1 & md.lsft ] in
# TODO: I want spacebar to also register as MO 1 at the same time, and tap-dance MO 2. Haven't figured it out yet.
let woomod = # td.make 200 [ kc.SPC, MO 2 & hold.reg.behavior {} ] in
  MO 1 & tap.sticky.layer 2 & hold.reg.behavior {} in
let keymap = {
  virtual_keys = virtual_keys',
  layers = [
    [
                      kc.T,                         kc.Y,
            kc.W,     kc.G,                         kc.H,   kc.P,
            kc.Q,     kc.E,   kc.R,       kc.U,     kc.I,   kc.O,
      LP_L0,kc.S,     kc.D,   kc.F,       kc.J,     kc.K,   kc.L,   excellent_layering,
      kc.Z, kc.X,     kc.C,   kc.V,       kc.B,     kc.N,   kc.M,   kc.ENT,
            kc.SCLN,  kc.QUOT,kc.COMM,    XXXX,     lambda, kc.DOT,
            cu.CT,    ks.LPRN,kc.BSPC,    kc.SPC,   woomod, kc.SLSH
    ],
    [
                      kc.LBRC,                      kc.RBRC,
            kc.BSLS,  niceTAB,				              XXXX,	  XXXX,
            kc.GRV,	  zoomU,  XXXX,       kc.MINS,  XXXX,   XXXX,
    	XXXX, arrow_L,  zoomD,  arrow_R,		kc.N7,    kc.N8,  kc.N9,  md.rsft,  
      XXXX, kc.HOME,  XXXX,   kc.END,     kc.N4,    kc.N5,  kc.N6,  XXXX,
            XXXX,	    XXXX,	  XXXX,		    kc.N1,    kc.N2,  kc.N3,
            XXXX,		  XXXX,	  XXXX,		    XXXX,     kc.N0,  XXXX
    ],
    [
    					        kc.ESC,						            kc.PSCR,
				    kc.F1,	  kc.F7,						            XXXX,	  XXXX,
				    kc.F2,	  kc.F8,	XXXX,		    XXXX,	    XXXX,	  XXXX,
		  XXXX,	kc.F3,	  kc.F9,	XXXX,		    XXXX,	    XXXX,	  XXXX,	  XXXX,
		  XXXX,	kc.F4,	  kc.F10,	XXXX,		    XXXX,	    XXXX,	  XXXX,	  XXXX,
				    kc.F5,	  kc.F11,	XXXX,		    me.NEXT,  XXXX,	  me.VOLU,
				    kc.F6,	  kc.F12,	XXXX,		    me.PLAY,  XXXX,	  me.VOLD
    ]
  ]
} in

keymap
