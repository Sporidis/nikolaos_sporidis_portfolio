import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/l10n/app_strings.dart';
import 'package:nikolaos_sporidis_portfolio/components/project_card.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';

class ProjectsSection extends StatelessComponent {
  final String id;
  const ProjectsSection({required this.id, super.key});

  @override
  Component build(BuildContext context) {
    final s = Strings.of(context);
    return section(
      id: id,
      attributes: {'data-reveal': ''},
      classes: 'projects-section',
      [
        p(classes: 'eyebrow', [.text(s.projectsEyebrow)]),
        h2([.text(s.projectsHeading)]),
        p(classes: 'projects-description', [
          .text(s.projectsDescription),
        ]),
        const ProjectCard(),
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
    css('.projects-description').styles(
      maxWidth: .fitContent,
      color: AppColors.inkFaint,
      fontSize: AppType.lead,
      raw: {'margin': '0 0 ${AppSpacing.s44.value} 0'},
    ),
  ];
}
