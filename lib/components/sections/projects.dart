import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/components/project_card.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';

class ProjectsSection extends StatelessComponent {
  final String id;
  const ProjectsSection({required this.id, super.key});

  @override
  Component build(BuildContext context) {
    return section(id: id, classes: 'projects-section', [
      p(classes: 'eyebrow', [.text('Projects')]),
      h2([.text('One project, built properly.')]),
      p(classes: 'projects-description', [
        .text('I\'d rather show one app I can defend line by line than five tutorials.'),
      ]),
      const ProjectCard(),
    ]);
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
