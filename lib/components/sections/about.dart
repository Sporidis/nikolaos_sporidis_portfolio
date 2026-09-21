import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/components/portrait_card.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';
import 'package:nikolaos_sporidis_portfolio/models/about_block.dart';

class AboutSection extends StatelessComponent {
  final String id;
  const AboutSection({required this.id, super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: id,
      attributes: {'data-reveal': ''},
      classes: 'about-section',
      [
        p(classes: 'eyebrow', [.text('About')]),

        div(classes: 'about-grid', [
          PortraitCard(),

          div(classes: 'about-content', [
            h2([.text('Junior developer, not a junior thinker.')]),
            p([
              .text(
                'I finished my Software Engineering degree this year and spent most of it deep in Flutter — rebuilding layouts until the state model was clean, and learning that the hard part of mobile is rarely the UI code. During my internship I shipped a production Flutter app used by real field staff.',
              ),
            ]),
            p([
              .text(
                "Now I'm looking for a team where I can keep learning from senior engineers and own features end to end — Flutter front end, Dart or Serverpod behind it.",
              ),
            ]),

            div(classes: 'about-facts', [
              for (var block in aboutSectionContentList)
                div(classes: 'about-fact', [
                  p(classes: 'about-fact-label', [.text(block.title)]),
                  p(classes: 'about-fact-value', [.text(block.content)]),
                ]),
            ]),
          ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.eyebrow').styles(
      color: AppColors.amber,
      fontFamily: AppFonts.mono,
      fontSize: AppType.label,
      raw: {'margin': '0 0 ${AppSpacing.s16.value} 0', 'letter-spacing': AppType.monoTracking.value},
    ),
    css('.about-grid').styles(
      display: .grid,
      alignItems: .center,
      gridTemplate: GridTemplate(
        columns: GridTracks([
          GridTrack.repeat(.autoFit, [GridTrack(.minmax(TrackSize(AppSpacing.gridMin), .fr(1)))]),
        ]),
      ),
      gap: .all(AppSpacing.columnGap),
    ),
    css('.about-content', [
      css('&').styles(
        display: .flex,
        flexDirection: .column,
        gap: .all(AppSpacing.s16),
        raw: {'grid-column': 'span 2', 'min-width': '0'},
      ),
      css('h2').styles(raw: {'font-size': AppType.sectionSize, 'margin-bottom': AppSpacing.s4.value}),
      css('p').styles(
        color: AppColors.inkMuted,
        fontSize: AppType.body,
        raw: {'max-width': AppType.measure},
      ),
    ]),
    css('.about-facts').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([
          GridTrack.repeat(.autoFit, [GridTrack(.minmax(TrackSize(190.px), .fr(1)))]),
        ]),
      ),
      gap: .all(AppSpacing.s16),
      raw: {'margin-top': AppSpacing.s16.value},
    ),
    css('.about-fact', [
      css('&').styles(
        padding: .all(AppSpacing.card),
        border: .all(color: AppColors.hairlineMid, width: 1.px),
        radius: .all(Radius.circular(AppRadii.card)),
        backgroundColor: AppColors.cardTint,
      ),
      css('.about-fact-label').styles(
        color: AppColors.amber,
        fontFamily: AppFonts.mono,
        fontSize: AppType.label,
        raw: {'margin': '0 0 ${AppSpacing.s8.value} 0', 'text-transform': 'lowercase'},
      ),
      css('.about-fact-value').styles(
        color: AppColors.ink,
        fontSize: AppType.bodySmall,
        fontWeight: FontWeight.w500,
        raw: {'margin': '0', 'line-height': '1.5'},
      ),
    ]),
  ];
}
