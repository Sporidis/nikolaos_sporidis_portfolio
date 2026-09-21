import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/components/demo_modal.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_effects.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';
import 'package:universal_web/web.dart' as web;

class ProjectCard extends StatefulComponent {
  const ProjectCard({super.key});

  @override
  State<ProjectCard> createState() => ProjectCardState();
}

class ProjectCardState extends State<ProjectCard> {
  bool _demoOpen = false;
  bool _hover = false;
  double _rx = 0;
  double _ry = 0;
  StreamSubscription<web.KeyboardEvent>? _escSub;
  bool get _reduceMotion => kIsWeb && web.window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _escSub = web.EventStreamProviders.keyDownEvent.forTarget(web.document).listen((event) {
        if (event.key == 'Escape') _closeDemo();
      });
    }
  }

  @override
  void dispose() {
    _escSub?.cancel();
    super.dispose();
  }

  void _openDemo() => setState(() {
    _demoOpen = true;
    _hover = false;
    _rx = 0;
    _ry = 0;
  });

  void _closeDemo() => setState(() => _demoOpen = false);

  @override
  Component build(BuildContext context) {
    return .fragment([
      div(
        events: {
          'mouseenter': (_) => setState(() => _hover = true),
          'mouseleave': (_) => setState(() {
            _hover = false;
            _rx = 0;
            _ry = 0;
          }),
          'mousemove': (event) {
            final e = event as web.MouseEvent;
            final target = event.currentTarget as web.Element;
            final rect = target.getBoundingClientRect();
            final px = (e.clientX - rect.x) / rect.width - 0.5;
            final py = (e.clientY - rect.y) / rect.height - 0.5;
            setState(() {
              _ry = px * 5;
              _rx = -py * 4;
            });
          },
        },
        classes: 'projects-grid',
        styles: Styles(
          raw: {
            'transform': _hover && !_reduceMotion
                ? 'perspective(1100px) rotateX(${_rx.toStringAsFixed(2)}deg) rotateY(${_ry.toStringAsFixed(2)}deg) translateY(-6px)'
                : 'none',
            'transition': 'transform .35s cubic-bezier(.2,.7,.3,1), box-shadow .35s ease',
            'box-shadow': _hover ? AppEffects.cardShadowHover : AppEffects.cardShadow,
          },
        ),
        [
          div(classes: 'project-portrait', [
            div(classes: 'phone-well', [
              div(
                classes: 'phone-phone-b',
                styles: Styles(
                  raw: {
                    'transform':
                        'translateX(${_hover && !_reduceMotion ? -16 : 0}px) translateY(10px) rotate(-5deg)',
                    'transition': 'transform .5s cubic-bezier(.2,.7,.3,1)',
                  },
                ),
                [],
              ),
              div(
                classes: 'phone-phone-a',
                styles: Styles(
                  raw: {
                    'transform':
                        'translateX(${_hover && !_reduceMotion ? 16 : 0}px) translateY(-10px) rotate(3deg)',
                    'transition': 'transform .5s cubic-bezier(.2,.7,.3,1)',
                  },
                ),
                [],
              ),
            ]),
            span(
              classes: 'phone-sync-pill',
              styles: Styles(
                opacity: _hover || _reduceMotion ? 1 : 0,
                raw: {'transition': 'opacity .4s ease'},
              ),
              [
                span(classes: 'phone-sync-pill-dot', []),
                .text('both phones in sync'),
              ],
            ),
          ]),
          div(classes: 'project-desc', [
            div(classes: 'project-desc-header', [
              h3([.text('FreshCart')]),
              div(classes: 'project-desc-header-pill', [
                p(classes: 'project-desc-header-pill-txt', [.text('featured')]),
              ]),
            ]),
            p(classes: 'project-desc-meta', [
              .text('shared shopping cart · Flutter + Serverpod'),
            ]),

            p(classes: 'project-desc-body', [
              .text(
                'A shopping list two or more phones can hold at once: join a cart with a code, and every add, tick and edit lands on the other devices in real time. Flutter on each client, a Serverpod backend over Postgres keeping one source of truth, with streaming updates instead of pull-to-refresh. The hard part was conflict handling — what happens when two people tick the same item a second apart.',
              ),
            ]),
            div(classes: 'project-desc-tags', [
              for (var tag in tags) span(classes: 'project-desc-tag', [.text(tag)]),
            ]),
            div(
              classes: 'project-desc-why',
              styles: Styles(
                raw: {
                  'max-height': _hover ? '120px' : '0px',
                  'opacity': _hover ? '1' : '0',
                  'transition': 'max-height .45s cubic-bezier(.2,.7,.3,1), opacity .35s ease',
                },
              ),
              [
                p(classes: 'project-desc-why-text', [
                  .text(
                    'why I built it → my household kept shopping from two out-of-date lists, and I wanted to learn real-time state across devices on a problem I actually had.',
                  ),
                ]),
              ],
            ),
            div(classes: 'project-desc-btns', [
              a(href: 'https://github.com/', classes: 'project-desc-btn-source', [.text('Source ↗')]),
              button(
                events: events(onClick: _openDemo),
                classes: 'project-desc-btn-demo',
                [span(classes: 'status-dot', []), .text('Try the live demo')],
              ),
            ]),
          ]),
        ],
      ),
      if (_demoOpen) DemoModal(onClose: _closeDemo),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.status-dot').styles(
      width: 7.px,
      height: 7.px,
      radius: .all(Radius.circular(999.px)),
      backgroundColor: AppColors.amber,
      raw: {'box-shadow': AppEffects.dotGlow},
    ),

    css('.projects-grid', [
      css('&').styles(
        display: .grid,
        border: .all(color: AppColors.hairlineMid, width: 1.px),
        radius: .all(Radius.circular(AppRadii.feature)),
        overflow: .hidden,
        gridTemplate: GridTemplate(
          columns: GridTracks([
            GridTrack.repeat(.autoFit, [GridTrack(.minmax(TrackSize(AppSpacing.gridMin), .fr(1)))]),
          ]),
        ),
        raw: {'background-image': AppEffects.panelFill, 'box-shadow': AppEffects.cardShadow},
      ),

      css('.project-portrait').styles(
        display: .flex,
        padding: .symmetric(vertical: AppSpacing.s44, horizontal: AppSpacing.gutter),
        border: .only(
          right: BorderSide.solid(color: AppColors.hairline, width: 1.px),
        ),
        overflow: .hidden,
        flexDirection: .column,
        justifyContent: .center,
        alignItems: .center,
        gap: .all(AppSpacing.s20),
        backgroundColor: AppColors.surfaceDeep,
        raw: {'background-image': AppEffects.stripes, 'min-height': '440px'},
      ),

      css('.phone-well', [
        css('&').styles(display: .flex, position: .relative(), justifyContent: .center, alignItems: .center),
        css('.phone-phone-b').styles(
          position: .relative(),
          zIndex: ZIndex(1),
          border: .all(color: AppColors.hairlineMid, width: 1.px),
          backgroundColor: AppColors.surfaceDeep,
          raw: {
            'width': 'clamp(96px, 30vw, 158px)',
            'aspect-ratio': '9 / 19.5',
            'border-radius': '22px',
            'box-shadow': '0 18px 44px rgba(0,0,0,0.5)',
          },
        ),
        css('.phone-phone-a').styles(
          position: .relative(),
          zIndex: ZIndex(3),
          border: .all(color: AppColors.hairlineStrong, width: 1.px),
          backgroundColor: AppColors.surface,
          raw: {
            'width': 'clamp(112px, 34vw, 186px)',
            'aspect-ratio': '9 / 19.5',
            'border-radius': '26px',
            'margin-left': '-46px',
            'box-shadow': AppEffects.panelShadow,
          },
        ),
      ]),

      css('.phone-sync-pill').styles(
        display: .inlineFlex,
        padding: .symmetric(vertical: AppSpacing.chipY, horizontal: AppSpacing.s12),
        radius: .all(Radius.circular(AppRadii.pill)),
        opacity: 0,
        alignItems: .center,
        gap: .all(7.px),
        color: AppColors.onAmber,
        fontFamily: AppFonts.mono,
        fontSize: AppType.micro,
        backgroundColor: AppColors.amber,
        raw: {'white-space': 'nowrap', 'box-shadow': AppEffects.halo},
      ),
      css('.phone-sync-pill-dot').styles(
        width: 6.px,
        height: 6.px,
        radius: .all(Radius.circular(999.px)),
        backgroundColor: AppColors.onAmber,
      ),

      css('.project-desc', [
        css('&').styles(
          padding: .symmetric(vertical: AppSpacing.cardLarge, horizontal: AppSpacing.cardLarge),
          raw: {'min-width': '0'},
        ),
        css('.project-desc-header').styles(
          display: .flex,
          justifyContent: .spaceBetween,
          alignItems: .center,
          gap: .all(AppSpacing.s16),
        ),
        css('.project-desc-header h3').styles(
          color: AppColors.ink,
          fontFamily: AppFonts.display,
          fontSize: AppType.cardTitle,
          fontWeight: FontWeight.w700,
          raw: {'margin': '0', 'letter-spacing': '-0.02em'},
        ),
        css('.project-desc-header-pill').styles(
          padding: .symmetric(vertical: 5.px, horizontal: 11.px),
          border: .all(color: AppColors.amberBorder, width: 1.px),
          radius: .all(Radius.circular(AppRadii.pill)),
        ),
        css('.project-desc-header-pill-txt').styles(
          color: AppColors.amber,
          fontFamily: AppFonts.mono,
          fontSize: AppType.label,
          raw: {'margin': '0'},
        ),
        css('.project-desc-meta').styles(
          color: AppColors.inkFaint,
          fontFamily: AppFonts.mono,
          fontSize: AppType.chip,
          raw: {'margin': '${AppSpacing.s12.value} 0 0 0'},
        ),
        css('.project-desc-body').styles(
          color: AppColors.inkMuted,
          fontSize: AppType.body,
          raw: {'line-height': AppType.bodyLeading, 'margin': '${AppSpacing.s16.value} 0 0 0', 'text-wrap': 'pretty'},
        ),
        css('.project-desc-tags').styles(
          display: .flex,
          flexWrap: .wrap,
          gap: .all(AppSpacing.s8),
          raw: {'margin-top': AppSpacing.s24.value},
        ),
        css('.project-desc-why', [
          css('&').styles(overflow: .hidden, raw: {'margin-top': AppSpacing.s20.value}),
          css('.project-desc-why-text').styles(
            padding: .only(left: AppSpacing.s16),
            border: .only(
              left: BorderSide.solid(color: AppColors.amberBorder, width: 1.px),
            ),
            color: AppColors.amber,
            fontFamily: AppFonts.mono,
            fontSize: AppType.label,
            raw: {'line-height': '1.7', 'margin': '0'},
          ),
        ]),
        css('.project-desc-tag').styles(
          padding: .symmetric(vertical: AppSpacing.s8, horizontal: 11.px),
          border: .all(color: AppColors.amberBorder, width: 1.px),
          radius: .all(Radius.circular(AppRadii.chip)),
          color: AppColors.amberLift,
          fontFamily: AppFonts.mono,
          fontSize: AppType.label,
          backgroundColor: AppColors.amberFill,
        ),
        css('.project-desc-btns').styles(
          display: .flex,
          flexWrap: .wrap,
          gap: .all(AppSpacing.s12),
          raw: {'margin-top': AppSpacing.s32.value},
        ),
        css('.project-desc-btn-source').styles(
          padding: .symmetric(vertical: AppSpacing.s12, horizontal: AppSpacing.s20),
          border: .all(color: AppColors.hairlineStrong, width: 1.px),
          radius: .all(Radius.circular(AppRadii.control)),
          color: AppColors.ink,
          fontFamily: AppFonts.mono,
          fontSize: AppType.mono,
        ),
        css('.project-desc-btn-demo').styles(
          display: .inlineFlex,
          padding: .symmetric(vertical: AppSpacing.s12, horizontal: AppSpacing.s20),
          border: .all(color: AppColors.amberBorder, width: 1.px),
          radius: .all(Radius.circular(AppRadii.control)),
          alignItems: .center,
          gap: .all(AppSpacing.s8),
          color: AppColors.amber,
          fontFamily: AppFonts.mono,
          fontSize: AppType.mono,
          backgroundColor: AppColors.amberFillSoft,
        ),
      ]),
    ]),
  ];
}

final List<String> tags = [
  'Flutter',
  'Dart',
  'Serverpod',
  'Postgres',
  'Riverpod',
  'Realtime streams',
  'Multi-device sync',
];
