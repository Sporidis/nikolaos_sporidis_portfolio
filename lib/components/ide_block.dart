import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_effects.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';

class IdeBlock extends StatefulComponent {
  const IdeBlock({super.key});

  @override
  State createState() => IdeBlockState();
}

class _CodeToken {
  const _CodeToken(this.text, this.cssClass);

  final String text;
  final String cssClass;
}

class IdeBlockState extends State<IdeBlock> {
  static const List<_CodeToken> _tokens = [
    _CodeToken('class', 'kw'),
    _CodeToken(' ', 'plain'),
    _CodeToken('Nikolaos', 'type'),
    _CodeToken(' ', 'plain'),
    _CodeToken('extends', 'kw'),
    _CodeToken(' ', 'plain'),
    _CodeToken('StatelessWidget', 'type'),
    _CodeToken(' {\n  ', 'plain'),
    _CodeToken('@override', 'kw'),
    _CodeToken('\n  ', 'plain'),
    _CodeToken('Widget', 'type'),
    _CodeToken(' ', 'plain'),
    _CodeToken('build', 'method'),
    _CodeToken('(', 'plain'),
    _CodeToken('BuildContext', 'type'),
    _CodeToken(' ', 'plain'),
    _CodeToken('context', 'param'),
    _CodeToken(') {\n    ', 'plain'),
    _CodeToken('return', 'kw'),
    _CodeToken(' ', 'plain'),
    _CodeToken('Developer', 'type'),
    _CodeToken('(\n      ', 'plain'),
    _CodeToken('stack', 'param'),
    _CodeToken(': ', 'plain'),
    _CodeToken('const', 'kw'),
    _CodeToken(' [', 'plain'),
    _CodeToken("'Flutter'", 'string'),
    _CodeToken(', ', 'plain'),
    _CodeToken("'Dart'", 'string'),
    _CodeToken(', ', 'plain'),
    _CodeToken("'Serverpod'", 'string'),
    _CodeToken('],\n      ', 'plain'),
    _CodeToken('graduated', 'param'),
    _CodeToken(': ', 'plain'),
    _CodeToken('2026', 'number'),
    _CodeToken(',\n      ', 'plain'),
    _CodeToken('status', 'param'),
    _CodeToken(': ', 'plain'),
    _CodeToken('OpenToWork', 'type'),
    _CodeToken('(),\n    );\n  }\n}', 'plain'),
  ];
  static final int _codeLength = _tokens.fold(0, (sum, token) => sum + token.text.length);

  int _charsShown = 0;
  final int _timeInMilliseconds = 3000;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      final interval = Duration(milliseconds: (_timeInMilliseconds / _codeLength).round());
      _typingTimer = Timer.periodic(interval, (timer) {
        setState(() => _charsShown++);
        if (_charsShown >= _codeLength) {
          timer.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  List<Component> _visibleTokenSpans() {
    final spans = <Component>[];
    var remaining = _charsShown;

    for (final token in _tokens) {
      if (remaining <= 0) break;

      final visibleText = remaining >= token.text.length ? token.text : token.text.substring(0, remaining);
      remaining -= visibleText.length;

      spans.add(
        token.cssClass == 'plain' ? .text(visibleText) : span(classes: 'code-${token.cssClass}', [.text(visibleText)]),
      );
    }

    return spans;
  }

  @override
  Component build(BuildContext context) {
    return div(classes: 'ide-block-wrapper', [
      div(classes: 'ide-block-glow', []),
      div(classes: 'ide-block', [
        div(classes: 'ide-block-top', [
          span(classes: 'ide-block-options', [
            for (int i = 0; i < 3; i++) span(classes: 'ide-block-option', [div(classes: 'dot', [])]),
          ]),
          span(classes: 'ide-block-title', [.text('nikolaos.dart')]),
        ]),
        div(classes: 'ide-block-body', [
          ..._visibleTokenSpans(),
          span(classes: 'caret', []),
        ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.ide-block-wrapper', [
      css('&').styles(
        position: .relative(),
        alignSelf: .center,
      ),
      css('.ide-block-glow').styles(
        position: .absolute(top: (-16).px, left: (-16).px, right: (-16).px, bottom: (-16).px),
        filter: .blur(32.px),
        pointerEvents: .none,
        raw: {'background-image': AppEffects.ideGlow},
      ),
    ]),
    css('.ide-block', [
      css('&').styles(
        border: .all(color: AppColors.hairlineMid, width: 1.px),
        radius: .all(Radius.circular(AppRadii.card)),
        overflow: .hidden,
        raw: {
          'background-image': AppEffects.panelFill,
          'box-shadow': AppEffects.panelShadow,
        },
      ),
      css('.ide-block-top', [
        css('&').styles(
          display: .flex,
          padding: .symmetric(vertical: AppSpacing.s12, horizontal: AppSpacing.s16),
          border: .only(
            bottom: BorderSide.solid(color: AppColors.hairline, width: 1.px),
          ),
          alignItems: .center,
          gap: .all(AppSpacing.s8),
        ),
        css('.ide-block-options').styles(
          display: .flex,
          alignItems: .center,
          gap: .all(AppSpacing.s8),
        ),
        css('.dot').styles(
          width: 10.px,
          height: 10.px,
          radius: .all(Radius.circular(999.px)),
          backgroundColor: AppColors.chrome,
        ),
        css('.ide-block-title').styles(
          color: AppColors.inkFaint,
          fontFamily: AppFonts.mono,
          fontSize: AppType.micro,
        ),
      ]),
      css('.ide-block-body', [
        css('&').styles(
          minHeight: 232.px,
          padding: .only(top: AppSpacing.s20, right: AppSpacing.s24, bottom: AppSpacing.s24, left: AppSpacing.s24),
          color: AppColors.codeText,
          fontFamily: AppFonts.mono,
          fontSize: AppType.mono,
          raw: {'line-height': AppType.monoLeading, 'white-space': 'pre-wrap'},
        ),
        css('.caret').styles(
          display: .inlineBlock,
          width: AppSpacing.s8,
          height: AppSpacing.s16,
          backgroundColor: AppColors.amber,
          raw: {
            'vertical-align': '-2px',
            'animation': 'caretBlink 1s step-end infinite',
          },
        ),
        css('.code-kw').styles(color: AppColors.codeKeyword),
        css('.code-type').styles(color: AppColors.codeType),
        css('.code-method').styles(color: AppColors.codeMethod),
        css('.code-param').styles(color: AppColors.codeParam),
        css('.code-string').styles(color: AppColors.codeString),
        css('.code-number').styles(color: AppColors.codeNumber),
      ]),
    ]),
  ];
}
