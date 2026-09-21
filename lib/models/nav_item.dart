class NavItem {
  final String key;
  final String label;

  NavItem({required this.key, required this.label});

  @override
  String toString() => label;
}

final List<NavItem> navItems = [
  NavItem(key: 'about', label: 'About'),
  NavItem(key: 'experience', label: 'Experience'),
  NavItem(key: 'projects', label: 'Projects'),
  NavItem(key: 'skills', label: 'Skills'),
  NavItem(key: 'hire-me', label: 'Hire Me'),
];
