import 'package:jaspr/dom.dart';

import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_motion.dart';
import 'css_rules.dart';

export 'app_colors.dart';
export 'app_effects.dart';
export 'app_fonts.dart';
export 'app_motion.dart';
export 'app_spacing.dart';

/// The ONLY global stylesheet in the project.
///
/// What belongs here: things true of every page — font loading, the document
/// reset, link and focus colours, selection, keyframes, and the
/// reduced-motion override.
///
/// What does NOT belong here: component looks. Cards, chips, the timeline and
/// the project card style themselves with inline `Styles(...)` built from the
/// token files, or with their own scoped `@css` block when they need
/// `:hover`.
@css
List<StyleRule> get styles => [
  // ------------------------------------------------------------------ fonts
  // Six files in web/fonts/. Subset them to latin + latin-ext before shipping;
  // full Google Fonts woff2s are ~3x bigger than this page needs.
  const FontFace('Space Grotesk', '/fonts/space-grotesk-v22-latin-regular.woff2', weight: 400),
  const FontFace('Space Grotesk', '/fonts/space-grotesk-v22-latin-500.woff2', weight: 500),
  const FontFace('Space Grotesk', '/fonts/space-grotesk-v22-latin-700.woff2', weight: 700),
  const FontFace('IBM Plex Sans', '/fonts/ibm-plex-sans-v23-latin-regular.woff2', weight: 400),
  const FontFace('IBM Plex Sans', '/fonts/ibm-plex-sans-v23-latin-500.woff2', weight: 500),
  const FontFace('JetBrains Mono', '/fonts/jetbrains-mono-v24-latin-regular.woff2', weight: 400),
  const FontFace('JetBrains Mono', '/fonts/jetbrains-mono-v24-latin-500.woff2', weight: 500),

  // ------------------------------------------------------------------ reset
  css('*, *::before, *::after').styles(raw: {'box-sizing': 'border-box'}),

  css('html').styles(
    raw: {
      'scroll-behavior': 'smooth',
      // Sticky header height + a little air, so anchor targets don't hide
      // under the nav.
      'scroll-padding-top': '96px',
      '-webkit-text-size-adjust': '100%',
    },
  ),

  css('body').styles(
    margin: Margin.zero,
    color: AppColors.ink,
    fontFamily: AppFonts.body,
    fontSize: AppType.body,
    backgroundColor: AppColors.background,
    raw: {
      'line-height': AppType.bodyLeading,
      'min-height': '100vh',
      'overflow-x': 'hidden',
      '-webkit-font-smoothing': 'antialiased',
      'text-rendering': 'optimizeLegibility',
    },
  ),

  // --------------------------------------------------------------- headings
  css('h1, h2, h3, h4, h5, h6').styles(
    margin: Margin.zero,
    color: AppColors.ink,
    fontFamily: AppFonts.display,
    fontWeight: FontWeight.bold,
    raw: {
      'line-height': AppType.headingLeading,
      'letter-spacing': '-0.03em',
      'text-wrap': 'balance',
    },
  ),

  css('p').styles(margin: Margin.zero, raw: {'text-wrap': 'pretty'}),

  // ------------------------------------------------------------------ links
  // Define these before you have any links, or the first one you add renders
  // browser blue on a near-black background.
  css('a').styles(
    color: AppColors.amber,
    raw: {'text-decoration': 'none', 'transition': AppMotion.transitionFast},
  ),
  css('a:hover').styles(color: AppColors.amberLift),

  // --------------------------------------------------------------- controls
  css('button, input, textarea').styles(
    color: AppColors.ink,
    fontFamily: AppFonts.body,
    fontSize: AppType.bodySmall,
    raw: {'font': 'inherit'},
  ),
  css('button').styles(raw: {'cursor': 'pointer', 'border': '0', 'background': 'none'}),
  css('input::placeholder, textarea::placeholder').styles(color: AppColors.inkGhost),

  // ---------------------------------------------------------------- a11y
  // Keyboard focus only — never a ring on mouse click.
  css(':focus:not(:focus-visible)').styles(raw: {'outline': 'none'}),
  css(':focus-visible').styles(
    raw: {
      'outline': '2px solid #F5A623',
      'outline-offset': '2px',
      'border-radius': '4px',
    },
  ),

  css('::selection').styles(raw: {'background': 'rgba(245,166,35,0.30)'}),

  // Skip link: visually hidden until focused.
  css('.skip-link').styles(
    raw: {
      'position': 'absolute',
      'left': '-9999px',
      'top': '16px',
    },
  ),
  css('.skip-link:focus').styles(
    raw: {
      'left': '16px',
      'z-index': '100',
      'padding': '10px 16px',
      'border-radius': '8px',
      'background': '#F5A623',
      'color': '#0B0B14',
    },
  ),

  // ------------------------------------------------------------- reveal base
  // The IntersectionObserver flips these to visible. Declaring the start state
  // in CSS (not Dart) means the server-rendered HTML is already correct and
  // there is no flash of positioned content on hydration.
  const RawRule('''
[data-reveal] {
  opacity: 0;
  transform: translateY(${AppMotion.revealOffset});
  transition: ${AppMotion.transitionReveal};
}
[data-reveal][data-revealed] {
  opacity: 1;
  transform: none;
  transition: ${AppMotion.transitionRevealIn};
}
'''),

  // ------------------------------------------------------------- keyframes
  const RawRule('''
@keyframes caretBlink {
  0%, 49%   { opacity: 1; }
  50%, 100% { opacity: 0; }
}
'''),

  // -------------------------------------------------- reduced motion
  // One block here saves branching in every component. Anything driven from
  // Dart (the typing effect, the sync delay) must ALSO check the media query
  // at runtime — CSS cannot stop a Timer.
  const RawRule('''
@media (prefers-reduced-motion: reduce) {
  html { scroll-behavior: auto; }
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
  [data-reveal] { opacity: 1; transform: none; }
}
'''),

  // ------------------------------------------------------------------ print
  const RawRule('''
@media print {
  body { background: #fff; color: #000; }
  [data-reveal] { opacity: 1; transform: none; }
  nav, .demo-overlay { display: none; }
}
'''),
];
