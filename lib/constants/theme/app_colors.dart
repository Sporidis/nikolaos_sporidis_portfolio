import 'package:jaspr/dom.dart';

/// Every colour in the portfolio. Nothing outside this file may hard-code a hex.
///
/// Rule of the palette: amber is the ONLY saturated colour on the page.
/// If something is amber, it means "you can act on this".
abstract final class AppColors {
  // ---------------------------------------------------------------- surfaces
  /// Page background, nav pill inner.
  static const background = Color('#0B0B14');

  /// Cards, code panel, phone mock body.
  static const surface = Color('#14141F');

  /// Screenshot wells, striped placeholders, inputs.
  static const surfaceDeep = Color('#0E0E18');

  /// Device bezel / raised chrome.
  static const surfaceRaised = Color('#23232F');

  /// Code panel window-control dots.
  static const chrome = Color('#2C2C3C');

  /// Code panel body text.
  static const codeText = Color('#C9C6D6');

  // --------------------------------------------------------------------- ink
  /// Headings and primary text.
  static const ink = Color('#F2F0EB');

  /// Body copy.
  static const inkMuted = Color('#A6A3B4');

  /// Meta, dates, captions.
  static const inkFaint = Color('#6E6B7E');

  /// Disabled / placeholder text inside dark wells.
  static const inkGhost = Color('#55536A');

  // ------------------------------------------------------------------- amber
  /// CTA fill, section labels, active nav, glow.
  static const amber = Color('var(--accent)');

  /// Hover text, chips on the feature card.
  static const amberLift = Color('var(--accent-lift)');

  /// Text placed ON an amber fill.
  static const onAmber = Color('#0B0B14');

  // ---------------------------------------------------- translucent variants
  // Borders and fills are alpha, not solids — they sit on the gradient mesh
  // and must let it through. Never use these for text.

  /// Section dividers, card outlines. 7% ink.
  static const hairline = Color('rgba(242,240,235,0.07)');

  /// Interactive outlines at rest. 12% ink.
  static const hairlineMid = Color('rgba(242,240,235,0.12)');

  /// Emphasized outlines, device bezels. 16% ink.
  static const hairlineStrong = Color('rgba(242,240,235,0.16)');

  /// Card background tint. 2% ink.
  static const cardTint = Color('rgba(242,240,235,0.02)');

  /// Card background tint, upper stop of the gradient. 3.5% ink.
  static const cardTintStrong = Color('rgba(242,240,235,0.035)');

  /// Amber outline at rest (secondary buttons, featured pill).
  static const amberBorder = Color('rgba(var(--accent-rgb),0.30)');

  /// Amber outline on hover / active nav.
  static const amberBorderStrong = Color('rgba(var(--accent-rgb),0.50)');

  /// Amber fill behind chips and ghost buttons.
  static const amberFill = Color('rgba(var(--accent-rgb),0.07)');

  /// Amber fill behind the active nav pill.
  static const amberFillSoft = Color('rgba(var(--accent-rgb),0.09)');

  /// Amber fill on hover.
  static const amberFillStrong = Color('rgba(var(--accent-rgb),0.20)');

  /// Halo ring around focused / hovered controls.
  static const amberHalo = Color('rgba(var(--accent-rgb),0.12)');

  /// Amber fill behind the active nav indicator.
  static const amberFillIndicator = Color('rgba(var(--accent-rgb),0.1)');

  /// Timeline rail gradient, amber stop (fades into hairlineMid).
  static const amberBorderGradient = Color('rgba(var(--accent-rgb),0.6)');

  /// Modal scrim.
  static const scrim = Color('rgba(6,6,12,0.82)');

  /// Sticky header background (used with backdrop-filter: blur).
  static const headerVeil = Color('rgba(11,11,20,0.72)');

  // ---------------------------------------------------------- code syntax
  // Deliberate exception to the "amber is the only saturated colour" rule,
  // scoped to the IDE code block: these mirror VSCode's Dark+ theme so the
  // snippet reads as real syntax highlighting rather than themed text.

  /// Keywords: class, extends, return, const, @override.
  static const codeKeyword = Color('#C586C0');

  /// Class / type names: Nikolaos, StatelessWidget, BuildContext...
  static const codeType = Color('#4EC9B0');

  /// Method names: build.
  static const codeMethod = Color('#DCDCAA');

  /// Parameter / named-argument labels: context, stack, graduated, status.
  static const codeParam = Color('#9CDCFE');

  /// String literals.
  static const codeString = Color('#CE9178');

  /// Numeric literals.
  static const codeNumber = Color('#B5CEA8');
}
