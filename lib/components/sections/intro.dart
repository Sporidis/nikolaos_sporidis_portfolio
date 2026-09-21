import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/components/ide_block.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_effects.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';

class IntroSection extends StatelessComponent {
  final String id;
  const IntroSection({required this.id, super.key});

  @override
  Component build(BuildContext context) {
    return section(id: id, classes: 'intro-section', [
      div(classes: 'intro-hero', [
        div(classes: 'status-pill', [
          span(classes: 'status-dot', []),
          .text('open to Flutter / mobile roles'),
        ]),

        div(classes: 'intro-content', [
          h1(classes: 'name', [.text('Nikolaos Sporidis')]),
          span(classes: 'role', [.text('Flutter & mobile developer  ·  BSc Software Engineering')]),
          span(classes: 'description', [
            .text(
              'I build mobile apps end to end — Flutter on the front, Dart on the back — and I care about the details users feel: motion, state, and the millisecond after a tap.',
            ),
          ]),
        ]),

        div(classes: 'intro-buttons', [
          a(classes: 'button-primary', href: '#', [.text('View projects →')]),
          a(classes: 'button-secondary', href: '#', [.text('Get in touch')]),
        ]),
      ]),

      IdeBlock(),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.main .intro-section', [
      css('&').styles(
        display: .grid,
        padding: .only(top: AppSpacing.s44),
        alignItems: .center,
        gridTemplate: GridTemplate(
          columns: GridTracks([
            GridTrack.repeat(.autoFit, [GridTrack(.minmax(TrackSize(AppSpacing.gridMin), .fr(1)))]),
          ]),
        ),
        gap: .all(AppSpacing.columnGap),
      ),
    ]),
    css('.intro-hero', [
      css('&').styles(
        display: .flex,
        flexDirection: .column,
        gap: .all(AppSpacing.s24),
      ),
    ]),
    css('.status-pill', [
      css('&').styles(
        display: .inlineFlex,
        width: .fitContent,
        padding: .symmetric(vertical: AppSpacing.chipY, horizontal: AppSpacing.chipX),
        border: .all(color: AppColors.amberBorder, width: 1.px),
        radius: .all(Radius.circular(AppRadii.pill)),
        alignItems: .center,
        gap: .all(AppSpacing.s8),
        color: AppColors.amber,
        fontFamily: AppFonts.mono,
        fontSize: AppType.chip,
        backgroundColor: AppColors.amberFill,
      ),
      css('.status-dot').styles(
        width: 7.px,
        height: 7.px,
        radius: .all(Radius.circular(999.px)),
        backgroundColor: AppColors.amber,
        raw: {'box-shadow': AppEffects.dotGlow}, // add this constant first
      ),
    ]),
    css('.intro-content', [
      css('&').styles(
        display: .flex,
        flexDirection: .column,
        gap: .all(AppSpacing.s20),
      ),
      // h1 already gets color/font-family/font-weight/letter-spacing from the
      // global heading rule in theme.dart — only the hero-specific size and
      // tighter line-height need overriding here.
      css('.name').styles(
        raw: {'font-size': AppType.heroSize, 'line-height': AppType.heroLeading},
      ),
      css('.role').styles(
        color: AppColors.amber,
        fontFamily: AppFonts.mono,
        fontSize: 14.px,
        letterSpacing: AppType.monoTracking,
      ),
      css('.description').styles(
        color: AppColors.inkMuted,
        fontSize: AppType.lead,
        raw: {
          'line-height': AppType.leadLeading,
          'max-width': AppType.measureNarrow,
          'text-wrap': 'pretty',
        },
      ),
    ]),
    css('.intro-buttons', [
      css('&').styles(
        display: .flex,
        flexWrap: .wrap,
        gap: .all(AppSpacing.s16),
      ),
      css('&', [
        css('a').styles(
          padding: .symmetric(vertical: AppSpacing.s12, horizontal: AppSpacing.s24),
          radius: .all(Radius.circular(AppRadii.control)),
          fontFamily: AppFonts.mono,
          fontSize: AppType.mono,
          fontWeight: FontWeight.w500,
        ),
      ]),
      css('.button-primary', [
        css('&').styles(
          color: AppColors.onAmber,
          backgroundColor: AppColors.amber,
        ),
        css('&:hover').styles(raw: {'box-shadow': AppEffects.ctaGlow}),
      ]),
      css('.button-secondary', [
        css('&').styles(
          border: .all(color: AppColors.hairlineStrong, width: 1.px),
          color: AppColors.ink,
        ),
        css('&:hover').styles(
          border: .all(color: AppColors.amberBorderStrong, width: 1.px),
          backgroundColor: AppColors.amberFill,
        ),
      ]),
    ]),
  ];
}
