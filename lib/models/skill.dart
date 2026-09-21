class Skill {
  final String name;
  List<String> tags;

  Skill({required this.name, required this.tags});
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
