import 'package:jaspr/dom.dart';

/// Three fonts, three jobs.
///
/// * [display] — headings only. Never body copy.
/// * [body]    — sentences. Never labels.
/// * [mono]    — labels, chips, buttons, dates, code. Always lowercase.
abstract final class AppFonts {
  static const display = FontFamily.list([
    FontFamily('Space Grotesk'),
    FontFamilies.sansSerif,
  ]);

  static const body = FontFamily.list([
    FontFamily('IBM Plex Sans'),
    FontFamilies.sansSerif,
  ]);

  static const mono = FontFamily.list([
    FontFamily('JetBrains Mono'),
    FontFamilies.monospace,
  ]);
}

/// The type scale.
///
/// Sizes are plain [Unit]s — that is what `Styles(fontSize:)` takes.
/// Line heights and fluid `clamp()` sizes are raw strings, because unit-less
/// line-height and two-unit clamps have no typed equivalent. Apply those with
/// `Styles(raw: {'line-height': AppType.bodyLeading})`.
abstract final class AppType {
  // ------------------------------------------------------------ fluid (raw)
  /// Hero name. 44 → 82px.
  static const heroSize = 'clamp(44px, 7vw, 82px)';

  /// Section h2. 30 → 42px.
  static const sectionSize = 'clamp(30px, 4vw, 42px)';

  /// Contact / closing h2. 32 → 52px.
  static const displaySize = 'clamp(32px, 5vw, 52px)';

  /// Modal h3. 22 → 30px.
  static const modalSize = 'clamp(22px, 3.2vw, 30px)';

  // ------------------------------------------------------------ fixed sizes
  /// Feature card title.
  static const cardTitle = Unit.pixels(27);

  /// Timeline entry title.
  static const entryTitle = Unit.pixels(23);

  /// Skill group title.
  static const groupTitle = Unit.pixels(19);

  /// Hero pitch.
  static const lead = Unit.pixels(18);

  /// Body copy — the default.
  static const body = Unit.pixels(16.5);

  /// Secondary body, fact cards.
  static const bodySmall = Unit.pixels(15);

  /// Mono buttons and the code panel.
  static const mono = Unit.pixels(13.5);

  /// Mono chips and nav.
  static const chip = Unit.pixels(12);

  /// Mono section markers and captions.
  static const label = Unit.pixels(11.5);

  /// Device status bars, fine print.
  static const micro = Unit.pixels(10.5);

  // ------------------------------------------------------- leading (raw)
  static const heroLeading = '0.98';
  static const headingLeading = '1.1';
  static const bodyLeading = '1.7';
  static const leadLeading = '1.65';
  static const monoLeading = '1.75';

  // ------------------------------------------------------- tracking (typed)
  /// Headings: tight, negative.
  static const displayTracking = Unit.em(-0.03);

  /// Mono labels: very slightly open.
  static const monoTracking = Unit.em(0.02);

  // --------------------------------------------------------------- measure
  // Apply as `Styles(raw: {'max-width': AppType.measure})`.
  static const measure = '62ch';
  static const measureWide = '68ch';
  static const measureNarrow = '46ch';
}
