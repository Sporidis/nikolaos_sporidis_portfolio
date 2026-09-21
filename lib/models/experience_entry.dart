class ExperienceEntry {
  final String title;
  final String meta;
  final String? project;
  final String description;
  final String? impact;
  final String? learned;
  final List<String>? stack;
  final bool active;
  ExperienceEntry({
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

final experienceTimeline = [
  ExperienceEntry(
    title: 'Flutter Developer Intern',
    meta: '[Company] · 2025 — 2026',
    project: 'project: DimonaGuard',
    description:
        'A compliance app for tracking Dimona declarations of on-site workers: check-in/check-out flows, offline-tolerant local state, and a synced dashboard for supervisors.',
    impact: 'Replaced a paper check-in process for field teams.',
    learned: 'Designing state for unreliable networks beats designing for the happy path.',
    stack: const ['Flutter', 'Riverpod', 'REST'],
    active: true,
  ),
  ExperienceEntry(
    title: 'BSc Software Engineering',
    meta: 'graduated 2026',
    description:
        'Thesis and final-year work centred on cross-platform mobile architecture. Most of my electives went to databases, distributed systems and UX.',
    active: false,
  ),
];
