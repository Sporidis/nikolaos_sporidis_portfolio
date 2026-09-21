import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/components/footer.dart';
import 'package:nikolaos_sporidis_portfolio/components/sections/about.dart';
import 'package:nikolaos_sporidis_portfolio/components/sections/experience.dart';
import 'package:nikolaos_sporidis_portfolio/components/sections/intro.dart';
import 'package:nikolaos_sporidis_portfolio/components/sections/projects.dart';
import 'package:nikolaos_sporidis_portfolio/components/sections/skills.dart';

class Portfolio extends StatelessComponent {
  const Portfolio({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        IntroSection(id: 'intro'),
        AboutSection(id: 'about'),
        ExperienceSection(id: 'experience'),
        ProjectsSection(id: 'projects'),
        SkillsSection(id: 'skills'),
        Footer(id: 'hire-me'),
      ],
    );
  }
}
