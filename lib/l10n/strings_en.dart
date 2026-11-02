import 'package:nikolaos_sporidis_portfolio/l10n/app_strings.dart';
import 'package:nikolaos_sporidis_portfolio/models/about_block.dart';
import 'package:nikolaos_sporidis_portfolio/models/demo_content.dart';
import 'package:nikolaos_sporidis_portfolio/models/experience_entry.dart';
import 'package:nikolaos_sporidis_portfolio/models/skill.dart';

class EnStrings extends AppStrings {
  const EnStrings();

  @override
  AppLocale get locale => AppLocale.en;

  // ------------------------------------------------------------------ page
  @override
  String get pageTitle => 'Nikolaos Sporidis · Flutter developer';
  @override
  String get pageDescription =>
      'Portfolio of Nikolaos Sporidis, a Flutter & mobile developer from Belgium. Featuring FreshCart, a real-time shared shopping list built with Flutter and Serverpod.';

  // ------------------------------------------------------------------- nav
  @override
  String get navAbout => 'About';
  @override
  String get navExperience => 'Experience';
  @override
  String get navProjects => 'Projects';
  @override
  String get navSkills => 'Skills';
  @override
  String get navHireMe => 'Hire Me';
  @override
  String get navToggleMenu => 'Toggle menu';
  @override
  String get navCloseColours => 'Close colours';
  @override
  String get navChangeColour => 'Change colour';
  @override
  String navSwitchAccent(String accent) => 'Switch to $accent accent';
  @override
  String get navLanguage => 'Language';

  // ----------------------------------------------------------------- intro
  @override
  String get introStatus => 'open to Flutter / mobile roles';
  @override
  String get introRole => 'Flutter & mobile developer · Bachelor in Applied Computer Science';
  @override
  String get introDescription =>
      'I build mobile apps end to end, mostly in Flutter and Dart. I care about the parts users notice without knowing why: smooth motion, clear loading and error states, and screens that only rebuild what they need to.';
  @override
  String get introCtaProjects => 'View projects →';
  @override
  String get introCtaContact => 'Get in touch';

  // ----------------------------------------------------------------- about
  @override
  String get aboutEyebrow => 'About';
  @override
  String get aboutHeading => 'I build the whole app, and want to get better at it.';
  @override
  String get aboutParagraph1 =>
      'I graduated in Applied Computer Science at Howest this year, and Flutter is where I spend most of my time. During my internship at HRMS I built DimonaGuard on my own: a working prototype of a tablet check-in app, with the Flutter front end, a .NET API and the database behind it. It taught me as much about when not to over-engineer as it did about Flutter itself.';
  @override
  String get aboutParagraph2 =>
      "I can take an app from idea to a working build on my own. What I'm looking for now is a team: people who catch what I miss and show me what I don't know yet. Ideally Flutter and Dart, but I'm happy to work across the stack.";
  @override
  List<AboutBlock> get aboutFacts => const [
    AboutBlock(title: 'Education', content: 'Applied Computer Science, Howest 2026'),
    AboutBlock(title: 'Focus', content: 'Flutter · Dart · Serverpod'),
    AboutBlock(title: 'Looking for', content: 'Junior Flutter role, on site, hybrid or remote'),
  ];
  @override
  String get portraitCaption => 'Nikolaos, 2026';
  @override
  String get portraitLive => 'in colour';

  // ------------------------------------------------------------ experience
  @override
  String get experienceEyebrow => 'Experience';
  @override
  String get experienceHeading => "Where I've built so far.";
  @override
  String get experienceImpact => 'Impact';
  @override
  String get experienceLearned => 'Learned';
  @override
  List<ExperienceEntry> get experienceTimeline => const [
    ExperienceEntry(
      title: 'Flutter Developer Intern',
      meta: 'HRMS BV, Bredene · Feb — May 2026',
      project: 'project: DimonaGuard',
      description:
          "A tablet check-in kiosk prototype: employees check in with their national register number, and the app verifies their Dimona declaration in real time, creating or correcting it when needed. Built solo, end to end: the Flutter app, a .NET 10 REST API, and an extended copy of the company's MS SQL database.",
      impact:
          'Delivered as a working prototype, handed over as a repo with a usage guide, for HRMS to demo to management and potential clients. I also went through their existing Flutter apps for unnecessary rebuilds, and made values that never change build once instead of on every rebuild.',
      learned:
          "Strict Clean Architecture was more than a solo prototype needed: a use case that only forwards to a repository is just an extra file, and early on I lost time deciding what belonged in which layer. Once the first flow stood, the rest went faster, but next time I'd go MVVM with repositories and skip the pass-through use cases.",
      stack: ['Flutter', 'Riverpod', '.NET 10', 'MS SQL'],
      active: true,
    ),
    ExperienceEntry(
      title: 'Bachelor in Applied Computer Science',
      meta: 'Howest · graduated 2026',
      description:
          "My bachelor's thesis asked whether Clean Architecture plus Riverpod makes a Flutter app more maintainable and stable, and tested it against the DimonaGuard prototype from my internship.",
      active: false,
    ),
  ];

  // -------------------------------------------------------------- projects
  @override
  String get projectsEyebrow => 'Projects';
  @override
  String get projectsHeading => 'One project, built properly.';
  @override
  String get projectsDescription => "I'd rather show one app I can defend line by line than five tutorials.";
  @override
  String get projectSyncPill => 'both phones in sync';
  @override
  String get projectFeatured => 'featured';
  @override
  String get projectMeta => 'shared shopping cart · Flutter + Serverpod';
  @override
  String get projectBody =>
      'A shopping list two or more phones can hold at once: join a cart with a code, and every add, tick and edit lands on the other devices in real time. Flutter on each client, a Serverpod backend over Postgres keeping one source of truth, with streaming updates instead of pull-to-refresh. The hard part was conflict handling — what happens when two people tick the same item a second apart.';
  @override
  String get projectWhy =>
      'why I built it → my household kept shopping from two out-of-date lists, and I wanted to learn real-time state across devices on a problem I actually had.';
  @override
  String get projectSource => 'Source ↗';
  @override
  String get projectTryDemo => 'Try the live demo';
  @override
  List<String> get projectTags => const [
    'Flutter',
    'Dart',
    'Serverpod',
    'Postgres',
    'Riverpod',
    'Realtime streams',
    'Multi-device sync',
  ];

  // ---------------------------------------------------------------- skills
  @override
  String get skillsEyebrow => 'Skills';
  @override
  String get skillsHeading => 'The toolbox.';
  @override
  List<Skill> get skills => const [
    Skill(name: 'Mobile', tags: ['Flutter', 'Dart', 'Riverpod', 'Material 3', 'Animations', 'Responsive layout']),
    Skill(
      name: 'Backend & data',
      tags: ['Serverpod', 'REST', 'PostgreSQL', 'GraphQL', 'Firebase', 'SQLite', 'Auth flows'],
    ),
    Skill(
      name: 'Tooling',
      tags: ['Git', 'Github Actions', 'Figma', 'VS Code', 'Android Studio', 'Jaspr', 'CI/CD', 'Docker'],
    ),
  ];

  // ---------------------------------------------------------------- footer
  @override
  String get footerEyebrow => 'Contact';
  @override
  String get footerHeading => 'Looking for a junior Flutter dev?';
  @override
  String get footerLede =>
      "I'm available on short notice, based in Belgium, and happy to walk you through any of my code.";
  @override
  String get footerCv => 'cv (pdf)';
  @override
  String get footerFineprint => 'built with Jaspr · Dart all the way down · © 2026 Nikolaos Sporidis';

  // ------------------------------------------------------------------ demo
  @override
  String get demoEyebrow => 'live demo · freshcart';
  @override
  String get demoHeading => 'Two phones, one list.';
  @override
  String get demoDescription =>
      'Two FreshCart clients side by side, joined to the same list. Adding or ticking on one shows up on the other. Try it.';
  @override
  String get demoClose => 'Close demo';
  @override
  String get demoSynced => 'both devices up to date';
  @override
  String get demoFootnote => 'runs entirely in your browser · esc to close';
  @override
  String get demoPhoneOwnerA => "Nikolaos' phone";
  @override
  String get demoPhoneOwnerB => "Flatmate's phone";
  @override
  List<DemoNote> get demoNotes => const [
    DemoNote(
      title: 'what is real',
      body:
          'The actual FreshCart Flutter app, compiled to the web: its UI, Riverpod state, domain logic and the join-code flow. Both phones run from one Flutter engine.',
    ),
    DemoNote(
      title: 'what is simulated',
      body:
          'Serverpod, sign-in, push and offline sync. An in-memory backend in your browser stands in for them, so nothing you type leaves this page.',
    ),
    DemoNote(
      title: 'the tricky bit',
      body:
          'In the real app, two people ticking the same item a second apart is resolved last-write-wins per field, so the list never flickers back.',
    ),
  ];
}
