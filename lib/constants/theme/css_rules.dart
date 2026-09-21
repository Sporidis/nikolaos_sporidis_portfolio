import 'package:jaspr/dom.dart';

/// Escape hatch for CSS that Jaspr's typed builders don't model: at-rules,
/// keyframes, media queries. Emits the string verbatim.
///
/// Keep this small. If a rule *can* be written with `css(...)`, write it that
/// way — you get the type checking.
class RawRule implements StyleRule {
  final String css;
  const RawRule(this.css);

  @override
  String toCss([String indent = '']) {
    return '${css
        .trim()
        .split('\n')
        .map((cssLine) => '$indent$cssLine')
        .join('\n')
        .replaceFirst(RegExp(r'^'), '')}\n';
  }
}

/// A single `@font-face` block.
///
/// One file per weight — do not point 400 and 700 at the same woff2 or the
/// browser will synthesis the bold and Space Grotesk will look smeared.
/// `font-display: swap` is mandatory: without it headings are invisible while
/// the font loads.
class FontFace implements StyleRule {
  final String family;
  final String url;
  final int weight;
  final String style;
  final String display;

  const FontFace(
    this.family,
    this.url, {
    this.weight = 400,
    this.style = 'normal',
    this.display = 'swap',
  });

  @override
  String toCss([String indent = '']) => '''
$indent@font-face {
$indent  font-family: '$family';
$indent  src: url('$url') format('woff2');
$indent  font-weight: $weight;
$indent  font-style: $style;
$indent  font-display: $display;
$indent}
''';
}
