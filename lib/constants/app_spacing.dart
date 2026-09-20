import 'package:jaspr/dom.dart';

/// 8px base unit — every value on the page is a multiple of it.
///
/// Prefer the role-named getters at the bottom over the raw steps: you will
/// pick the right one faster than remembering that 44 is the heading gap.
abstract final class AppSpacing {
  static const s4 = Unit.pixels(4);
  static const s8 = Unit.pixels(8);
  static const s12 = Unit.pixels(12);
  static const s16 = Unit.pixels(16);
  static const s20 = Unit.pixels(20);
  static const s24 = Unit.pixels(24);
  static const s28 = Unit.pixels(28);
  static const s32 = Unit.pixels(32);
  static const s44 = Unit.pixels(44);
  static const s56 = Unit.pixels(56);
  static const s72 = Unit.pixels(72);
  static const s96 = Unit.pixels(96);
  static const s120 = Unit.pixels(120);

  // ----------------------------------------------------------------- roles
  /// Chip / small control padding.
  static const chipY = s8;
  static const chipX = s12;

  /// Inline gaps between sibling controls.
  static const inline = s16;

  /// Card interior padding.
  static const card = s24;

  /// Feature card interior padding (larger).
  static const cardLarge = Unit.pixels(36);

  /// Heading → content.
  static const headingGap = s44;

  /// Hero grid column gap.
  static const columnGap = s56;

  /// Vertical padding on every <section>.
  static const sectionY = s96;

  /// Hero breathing room (bottom).
  static const heroY = s120;

  // ---------------------------------------------------------------- layout
  /// Content column cap.
  static const contentMax = Unit.pixels(1120);

  /// Horizontal gutter either side of the content column.
  static const gutter = s28;

  /// Minimum track width for auto-fit grids — below this they wrap to one
  /// column. The page has no media queries; this is what replaces them.
  static const gridMin = Unit.pixels(260);
  static const gridMinWide = Unit.pixels(320);
}

/// Corner radii. Plain [Unit]s — wrap in `BorderRadius.circular(...)` at the
/// call site.
abstract final class AppRadii {
  /// Chips, small buttons.
  static const chip = Unit.pixels(8);

  /// Buttons, inputs.
  static const control = Unit.pixels(10);

  /// Standard cards.
  static const card = Unit.pixels(14);

  /// Feature card, modal.
  static const feature = Unit.pixels(20);

  /// Phone mock screen.
  static const screen = Unit.pixels(30);

  /// Phone mock bezel.
  static const device = Unit.pixels(38);

  /// Pills and dots.
  static const pill = Unit.pixels(999);
}
