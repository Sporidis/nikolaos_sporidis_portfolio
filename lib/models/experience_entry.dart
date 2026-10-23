class ExperienceEntry {
  final String title;
  final String meta;
  final String? project;
  final String description;
  final String? impact;
  final String? learned;
  final List<String>? stack;
  final bool active;
  const ExperienceEntry({
    required this.title,
    required this.meta,
    this.project,
    required this.description,
    this.impact,
    this.learned,
    this.stack,
    required this.active,
  });
}
