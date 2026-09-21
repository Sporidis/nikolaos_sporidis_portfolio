import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:universal_web/js_interop.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';
import 'package:universal_web/web.dart' as web;

class NavBar extends StatefulComponent {
  const NavBar({super.key});

  @override
  State createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  static const _navOffset = 96; // sticky nav height + a bit of buffer — tune to taste

  static const _navItems = {
    'about': 'About',
    'experience': 'Experience',
    'projects': 'Projects',
    'skills': 'Skills',
    'hire-me': 'Hire me',
  };
  static final _scrollSpyIds = _navItems.keys.where((id) => id != 'hire-me').toList();

  String _activeId = 'about';
  web.IntersectionObserver? _observer;
  bool _suppressScrollSpy = false;
  JSFunction? _scrollEndListener;

  final Map<String, GlobalNodeKey<web.HTMLElement>> _linkKeys = {
    for (final id in _navItems.keys) id: GlobalNodeKey(),
  };
  double _indicatorLeft = 0;
  double _indicatorWidth = 0;

  void _activate(String id) {
    final el = _linkKeys[id]?.currentNode;
    setState(() {
      _activeId = id;
      if (el != null) {
        _indicatorLeft = el.offsetLeft.toDouble();
        _indicatorWidth = el.offsetWidth.toDouble();
      }
    });
  }

  void _handleIntersect(
    JSArray<web.IntersectionObserverEntry> entries,
    web.IntersectionObserver observer,
  ) {
    if (_suppressScrollSpy) return;
    _updateActiveSection();
  }

  void _handleScrollEnd(web.Event event) {
    _suppressScrollSpy = false;
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _observer = web.IntersectionObserver(_handleIntersect.toJS);
      for (final id in _scrollSpyIds) {
        final element = web.document.getElementById(id);
        if (element != null) _observer!.observe(element);
      }
      _scrollEndListener = _handleScrollEnd.toJS;
      web.window.addEventListener('scrollend', _scrollEndListener);
    }
  }

  void _updateActiveSection() {
    String? candidate;
    for (final id in _scrollSpyIds) {
      final el = web.document.getElementById(id);
      if (el == null) continue;
      if (el.getBoundingClientRect().top <= _navOffset) {
        candidate = id;
      }
    }
    if (candidate != null && candidate != _activeId) {
      _activate(candidate);
    }
  }

  @override
  void dispose() {
    _observer?.disconnect();
    if (kIsWeb && _scrollEndListener != null) {
      web.window.removeEventListener('scrollend', _scrollEndListener);
    }
    super.dispose();
  }

  Component _navLink(String id, String label) {
    if (id == 'hire-me') {
      return a(href: '#$id', classes: 'navbar-cta', [.text(label)]);
    }
    return a(
      key: _linkKeys[id],
      href: '#$id',
      classes: _activeId == id ? 'active' : null,
      events: {
        'click': (web.Event event) {
          _suppressScrollSpy = true;
          _activate(id);
        },
      },
      [.text(label)],
    );
  }

  @override
  Component build(BuildContext context) {
    return nav(classes: 'navbar', [
      // left part
      div(classes: 'navbar-brand', [
        a(classes: 'navbar-brand-prefix', href: '#', [
          .text(
            'nikolaos',
          ),
        ]),
        a(href: '#', classes: 'navbar-brand-suffix', [.text('.dev')]),
      ]),

      //right part
      div(classes: 'navbar-links', [
        div(
          classes: 'navbar-indicator',
          styles: Styles(
            width: _indicatorWidth.px,
            transform: .translate(x: _indicatorLeft.px),
          ),
          [],
        ),
        for (final entry in _navItems.entries) _navLink(entry.key, entry.value),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.navbar', [
      css('&').styles(
        display: .flex,
        position: .sticky(top: .zero),
        zIndex: ZIndex(1000),
        width: 100.percent,
        padding: .symmetric(horizontal: AppSpacing.gutter, vertical: AppSpacing.s16),
        border: .only(
          bottom: BorderSide.solid(color: AppColors.hairline, width: 1.px),
        ),
        justifyContent: .spaceBetween,
        alignItems: .center,
        backgroundColor: AppColors.headerVeil,
        raw: {'backdrop-filter': 'blur(14px)'},
      ),
      css('.navbar-brand-prefix').styles(
        color: AppColors.ink,
        fontFamily: AppFonts.mono,
        fontSize: 13.px,
      ),
      css('.navbar-brand-suffix').styles(
        color: AppColors.amber,
        fontFamily: AppFonts.mono,
        fontSize: 13.px,
      ),
      css('.navbar-links').styles(
        display: .flex,
        position: .relative(),
        alignItems: .center,
        gap: .all(AppSpacing.inline),
      ),
      css('.navbar-indicator').styles(
        position: .absolute(top: .zero, left: .zero),
        height: 100.percent,
        radius: .all(Radius.circular(AppRadii.chip)),
        transition: Transition.combine([
          Transition('transform', duration: 300.ms, curve: .easeOut),
          Transition('width', duration: 300.ms, curve: .easeOut),
        ]),
        backgroundColor: AppColors.amber.withOpacity(0.1),
      ),
      css('.navbar-links a').styles(
        position: .relative(),
        padding: .symmetric(horizontal: AppSpacing.s8, vertical: AppSpacing.s4),
        color: AppColors.ink,
        fontFamily: AppFonts.mono,
        fontSize: 13.px,
      ),
      css('.navbar-links a.active').styles(
        color: AppColors.amber,
      ),
      css('.navbar-links a.navbar-cta', [
        css('&').styles(
          display: .inlineBlock,
          padding: .symmetric(vertical: AppSpacing.s8, horizontal: AppSpacing.s16),
          radius: .all(Radius.circular(AppRadii.pill)),
          color: AppColors.onAmber,
          fontFamily: AppFonts.mono,
          fontSize: AppType.chip,
          fontWeight: FontWeight.w500,
          backgroundColor: AppColors.amber,
          raw: {'transition': 'box-shadow .25s ease'},
        ),
        css('&:hover').styles(
          shadow: BoxShadow(
            offsetX: .zero,
            offsetY: .zero,
            blur: 14.px,
            spread: 6.px,
            color: Color('rgba(245,166,35,0.16)'),
          ),
          color: AppColors.onAmber,
        ),
      ]),
    ]),
  ];
}
