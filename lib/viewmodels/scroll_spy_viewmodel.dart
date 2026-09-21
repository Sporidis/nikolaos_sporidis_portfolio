import 'package:nikolaos_sporidis_portfolio/models/nav_item.dart';
import 'package:universal_web/web.dart' as web;

/// Unlike [ScrollRevealController], this doesn't own its own
/// `IntersectionObserver` — changing `activeId` has to trigger a `setState`
/// on the nav bar so the indicator pill moves, and only the `State` can call
/// that. So `NavBarState` owns the observer and calls [updateActiveSection]
/// from its callback; this class only holds the resulting data.
class ScrollSpyViewModel {
  ScrollSpyViewModel();

  static const _navOffset = 96; // sticky nav height + a bit of buffer — tune to taste

  String activeId = 'about';
  bool suppressScrollSpy = false;

  bool updateActiveSection() {
    if (suppressScrollSpy) return false;
    String? candidate;
    // No early exit: sections are in page order, and every section above the
    // current scroll position has already crossed the offset line, not just
    // the one being read. Walking the whole list and keeping the last match
    // is what makes `candidate` end up as the lowest (most recently passed)
    // section — i.e. the one actually in view.
    for (final item in navItems) {
      if (item.key == 'hire-me') continue;
      final el = web.document.getElementById(item.key);
      if (el == null) continue;
      if (el.getBoundingClientRect().top <= _navOffset) candidate = item.key;
    }
    if (candidate != null && candidate != activeId) {
      activeId = candidate;
      return true; // caller knows to re-sync the indicator + repaint
    }
    return false;
  }
}
