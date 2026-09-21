import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/theme.dart';

class SkillsSection extends StatelessComponent {
  final String id;

  SkillsSection({required this.id});

  @override
  Component build(BuildContext context) {
    return section(
      id: id,
      attributes: {'data-reveal': ''},
      classes: 'skills-section',
      [
        p(classes: 'eyebrow', [.text('Skills')]),

        h2([.text('The toolbox.')]),

        div(classes: 'skills-list', [
          for (var (i, skill) in mySkills.indexed)
            div(classes: 'skill-item', [
              p(classes: 'skill-index', [.text((i + 1).toString().padLeft(2, '0'))]),
              h3([.text(skill.name)]),
              div(classes: 'skill-tags', [
                for (var tag in skill.tags) span(classes: 'skill-tag', [.text(tag)]),
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
    css('.skills-section h2').styles(
      raw: {'font-size': AppType.sectionSize, 'margin-bottom': AppSpacing.headingGap.value},
    ),
    css('.skills-list').styles(
      display: .grid,
      gridTemplate: GridTemplate(
        columns: GridTracks([
          GridTrack.repeat(.autoFit, [GridTrack(.minmax(TrackSize(AppSpacing.gridMin), .fr(1)))]),
        ]),
      ),
      gap: .all(AppSpacing.s20),
    ),
    css('.skill-item', [
      css('&').styles(
        padding: .only(top: 26.px, right: AppSpacing.card, bottom: 28.px, left: AppSpacing.card),
        border: .all(color: Color('rgba(242,240,235,0.09)'), width: 1.px),
        radius: .all(Radius.circular(AppRadii.card)),
        raw: {'background-image': AppEffects.cardFill},
      ),
      css('.skill-index').styles(
        color: AppColors.amber,
        fontFamily: AppFonts.mono,
        fontSize: AppType.label,
        raw: {'margin': '0 0 4px 0'},
      ),
      css('h3').styles(
        color: AppColors.ink,
        fontFamily: AppFonts.display,
        fontSize: AppType.groupTitle,
        fontWeight: FontWeight.w500,
        raw: {'margin': '0 0 ${AppSpacing.s20.value} 0'},
      ),
    ]),
    css('.skill-tags').styles(
      display: .flex,
      flexWrap: .wrap,
      gap: .all(AppSpacing.s8),
    ),
    css('.skill-tag', [
      css('&').styles(
        padding: .symmetric(vertical: AppSpacing.s8, horizontal: AppSpacing.s12),
        border: .all(color: AppColors.hairlineMid, width: 1.px),
        radius: .all(Radius.circular(AppRadii.chip)),
        color: AppColors.codeText,
        fontFamily: AppFonts.mono,
        fontSize: AppType.chip,
        backgroundColor: Color('rgba(11,11,20,0.5)'),
        raw: {'transition': AppMotion.transitionFast},
      ),
      css('&:hover').styles(
        border: .all(color: Color('rgba(245,166,35,0.45)'), width: 1.px),
        color: AppColors.amberLift,
        backgroundColor: AppColors.amberFill,
      ),
    ]),
  ];
}

final mySkills = [
  Skill(name: 'Mobile', tags: ['Flutter', 'Dart', 'Riverpod', 'Material 3', 'Animations', 'Response layout']),
  Skill(
    name: 'Backend & data',
    tags: ['Serverpod', 'REST', 'PostgreSQL', 'GraphQL', 'Firebase', 'SQLite', 'Auth flows'],
  ),
  Skill(
    name: 'Tooling',
    tags: ['Git', 'Github Actions', 'Figma', 'VS Code', 'Android Studio', 'Jaspr', 'CI/CD', 'Docker'],
  ),
];

class Skill {
  final String name;
  List<String> tags;

  Skill({required this.name, required this.tags});
}
