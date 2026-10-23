class NavItem {
  final String key;
  final String label;

  NavItem({required this.key, required this.label});

  @override
  String toString() => label;
}

/// Anchor ids of the sections the nav scroll-spies, in page order. These are
/// the same in every language; only the labels are translated (see
/// `AppStrings.navItems`).
const navSectionIds = ['about', 'experience', 'projects', 'skills'];
const navHireMeId = 'hire-me';
