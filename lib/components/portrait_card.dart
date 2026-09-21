import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_effects.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';
import 'package:universal_web/web.dart' as web;

class PortraitCard extends StatefulComponent {
  const PortraitCard({super.key});

  @override
  State createState() => PortraitCardState();
}

class PortraitCardState extends State<PortraitCard> {
  final GlobalNodeKey<web.HTMLElement> _cardKey = GlobalNodeKey();

  bool _hover = false;
  double _rotX = 0;
  double _rotY = 0;
  double _translateX = 0;
  double _translateY = 0;
  double _lightX = 50;
  double _lightY = 30;

  void _handleEnter(web.Event event) {
    setState(() => _hover = true);
  }

  void _handleLeave(web.Event event) {
    setState(() {
      _hover = false;
      _rotX = 0;
      _rotY = 0;
      _translateX = 0;
      _translateY = 0;
      _lightX = 50;
      _lightY = 30;
    });
  }

  void _handleMove(web.Event event) {
    final el = _cardKey.currentNode;
    if (el == null) return;

    final mouse = event as web.MouseEvent;
    final rect = el.getBoundingClientRect();
    final nx = (mouse.clientX - rect.left) / rect.width;
    final ny = (mouse.clientY - rect.top) / rect.height;

    setState(() {
      _rotY = (nx - 0.5) * 7;
      _rotX = -(ny - 0.5) * 6;
      _translateX = -(nx - 0.5) * 10;
      _translateY = -(ny - 0.5) * 10;
      _lightX = nx * 100;
      _lightY = ny * 100;
    });
  }

  @override
  Component build(BuildContext context) {
    final tiltTransform = _hover
        ? Transform.combine([
            Transform.perspective(900.px),
            Transform.rotateAxis(x: _rotX.deg, y: _rotY.deg),
            Transform.translate(y: (-4).px),
          ])
        : Transform.none;

    final imageTransform = Transform.combine([
      Transform.scale(_hover ? 1.05 : 1),
      Transform.translate(x: _translateX.px, y: _translateY.px),
    ]);

    return div(
      key: _cardKey,
      classes: 'about-portrait',
      styles: Styles(transform: tiltTransform),
      events: {
        'mouseenter': _handleEnter,
        'mouseleave': _handleLeave,
        'mousemove': _handleMove,
      },
      [
        img(
          src: 'images/portrait.png',
          classes: 'portrait-base',
          alt: 'Nikolaos Sporidis',
          styles: Styles(transform: imageTransform),
        ),
        img(
          src: 'images/portrait-live.png',
          classes: 'portrait-live',
          alt: '',
          styles: Styles(transform: imageTransform),
        ),
        div(classes: 'portrait-scrim', []),
        div(
          classes: 'portrait-glow',
          styles: Styles(
            opacity: _hover ? 1 : 0,
            raw: {
              'background-image':
                  'radial-gradient(260px 260px at ${_lightX.toStringAsFixed(1)}% ${_lightY.toStringAsFixed(1)}%, rgba(245,166,35,0.22), transparent 70%)',
            },
          ),
          [],
        ),
        div(classes: 'portrait-caption', [
          span([.text('Nikolaos, 2025')]),
          span(classes: 'portrait-caption-live', [
            span(classes: 'portrait-caption-dot', []),
            .text('in colour'),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.about-portrait', [
      css('&').styles(
        position: .relative(),
        border: .all(color: AppColors.hairlineMid, width: 1.px),
        radius: .all(Radius.circular(AppRadii.card)),
        overflow: .hidden,
        backgroundColor: AppColors.surfaceDeep,
        raw: {
          'aspect-ratio': '4 / 5',
          'box-shadow': AppEffects.cardShadow,
          'transition': 'border-color .45s ease, box-shadow .45s ease',
        },
      ),
      css('&:hover').styles(
        border: .all(color: AppColors.amberBorder, width: 1.px),
        raw: {'box-shadow': AppEffects.cardShadowHover},
      ),
      css('&:hover .portrait-live').styles(opacity: 1),
      css('&:hover .portrait-scrim').styles(opacity: 1),
      css('&:hover .portrait-caption').styles(opacity: 1, transform: .translate(y: .zero)),
    ]),
    css('.portrait-base, .portrait-live', [
      css('&').styles(
        position: .absolute(top: .zero, left: .zero, right: .zero, bottom: .zero),
        width: 100.percent,
        height: 100.percent,
        raw: {'object-fit': 'cover', 'transition': 'transform .5s cubic-bezier(.2,.7,.3,1)'},
      ),
    ]),
    css('.portrait-live').styles(
      opacity: 0,
      raw: {'transition': 'opacity .5s ease, transform .5s cubic-bezier(.2,.7,.3,1)'},
    ),
    css('.portrait-scrim').styles(
      position: .absolute(top: .zero, left: .zero, right: .zero, bottom: .zero),
      opacity: 0.55,
      raw: {
        'background': 'linear-gradient(180deg, rgba(11,11,20,0) 45%, rgba(11,11,20,0.85) 100%)',
        'transition': 'opacity .45s ease',
      },
    ),
    css('.portrait-glow').styles(
      position: .absolute(top: .zero, left: .zero, right: .zero, bottom: .zero),
      pointerEvents: .none,
      raw: {'transition': 'opacity .45s ease'},
    ),
    css('.portrait-caption', [
      css('&').styles(
        display: .flex,
        position: .absolute(left: AppSpacing.s16, right: AppSpacing.s16, bottom: 14.px),
        opacity: 0,
        transform: .translate(y: 8.px),
        justifyContent: .spaceBetween,
        alignItems: .center,
        gap: .all(AppSpacing.s12),
        raw: {'transition': 'opacity .45s ease, transform .45s cubic-bezier(.2,.7,.3,1)'},
      ),
      css('span').styles(
        color: AppColors.ink,
        fontFamily: AppFonts.mono,
        fontSize: AppType.label,
      ),
      css('.portrait-caption-live', [
        css('&').styles(
          display: .flex,
          alignItems: .center,
          gap: .all(AppSpacing.s4),
          color: AppColors.amber,
          fontSize: AppType.micro,
        ),
        css('.portrait-caption-dot').styles(
          width: 5.px,
          height: 5.px,
          radius: .all(Radius.circular(AppRadii.pill)),
          backgroundColor: AppColors.amber,
          raw: {'box-shadow': '0 0 8px rgba(245,166,35,0.6)'},
        ),
      ]),
    ]),
  ];
}
