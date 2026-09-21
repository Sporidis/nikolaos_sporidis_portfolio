/// Durations and easing. Four speeds, one curve — resist adding a fifth.
///
/// Every animation in the design has a static fallback under
/// `prefers-reduced-motion: reduce`. The global stylesheet zeroes out
/// transitions; anything driven from Dart must check [prefersReducedMotion].
abstract final class AppMotion {
  /// Colour-only changes: chips, nav, links.
  static const fast = Duration(milliseconds: 250);

  /// Hover transforms, glows, card tilt.
  static const base = Duration(milliseconds: 350);

  /// Disclosure: the "why I built it" line, phone separation, sync delay.
  static const slow = Duration(milliseconds: 500);

  /// Scroll reveal — hide direction only (scrolling a section back out of
  /// view). Kept snappy so sections don't linger while scrolling past.
  static const reveal = Duration(milliseconds: 700);

  /// Scroll reveal — show direction only. Slower than [reveal] so content
  /// settles in rather than snapping into place; applied via the higher-
  /// specificity `[data-reveal][data-revealed]` rule, see [transitionRevealIn].
  static const revealIn = Duration(milliseconds: 1100);

  /// The one curve. Everything decelerating uses it.
  static const easeOut = 'cubic-bezier(.2,.7,.3,1)';

  /// Stagger offsets for revealed children, in ms. Read off the element's
  /// `data-delay` attribute rather than hard-coding per component.
  static const stagger = [60, 80, 140, 160, 220, 260];

  /// Slide-up distance for a scroll reveal.
  static const revealOffset = '22px';

  /// Simulated network delay in the FreshCart demo.
  static const syncDelay = Duration(milliseconds: 520);

  /// How long a freshly-synced row stays highlighted.
  static const freshHighlight = Duration(milliseconds: 1100);

  /// Shorthand transitions for `Styles(raw: {'transition': ...})`.
  static const transitionFast = 'color .25s ease, background .25s ease, border-color .25s ease';
  static const transitionBase = 'transform .35s $easeOut, box-shadow .35s ease, border-color .35s ease';
  static const transitionReveal = 'opacity .7s $easeOut, transform .7s $easeOut';
  static const transitionRevealIn = 'opacity 1.1s $easeOut, transform 1.1s $easeOut';
}
