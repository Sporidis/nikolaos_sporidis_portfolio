import 'package:universal_web/web.dart' as web;

class NavAccentViewModel {
  static const _themes = {
    'amber': (accent: '#F5A623', lift: '#FFC163', rgb: '245,166,35'),
    'violet': (accent: '#A78BFA', lift: '#C7B6FF', rgb: '167,139,250'),
    'cyan': (accent: '#22D3EE', lift: '#7DE9F7', rgb: '34,211,238'),
    'lime': (accent: '#A3E635', lift: '#C6F26E', rgb: '163,230,53'),
    'coral': (accent: '#FF6B5A', lift: '#FF9A8D', rgb: '255,107,90'),
  };

  String theme = 'amber';
  bool themeRailOpen = false;

  Map<String, ({String accent, String lift, String rgb})> get themes => _themes;

  void applyTheme(String key) {
    final t = themes[key]!;

    final root = web.document.documentElement as web.HTMLElement?;
    root?.style.setProperty('--accent', t.accent);
    root?.style.setProperty('--accent-lift', t.lift);
    root?.style.setProperty('--accent-rgb', t.rgb);

    try {
      web.window.localStorage.setItem('portfolio-accent', key);
    } catch (_) {
      // Ignore errors
    }
  }

  void selectTheme(String key) {
    if (key == theme) {
      themeRailOpen = !themeRailOpen;
      return;
    }
    applyTheme(key);
    theme = key;
    themeRailOpen = false;
  }
}
