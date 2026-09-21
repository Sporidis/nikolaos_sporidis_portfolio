import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:universal_web/js_interop.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_effects.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';
import 'package:universal_web/web.dart' as web;

class NavBar extends StatefulComponent {
  const NavBar({super.key});

  @override
  State createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  bool _mobileMenuOpen = false;
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
          _mobileMenuOpen = false;
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
      div(classes: 'navbar-right', [
        div(classes: _mobileMenuOpen ? 'navbar-links open' : 'navbar-links', [
          div(
            classes: 'navbar-indicator',
            styles: Styles(
              width: _indicatorWidth.px,
              transform: .translate(x: _indicatorLeft.px),
            ),
            [],
          ),
          for (final id in _scrollSpyIds) _navLink(id, _navItems[id]!),
        ]),
        _navLink('hire-me', _navItems['hire-me']!),
        button(
          classes: 'navbar-burger',
          attributes: {'aria-expanded': '$_mobileMenuOpen', 'aria-label': 'Toggle menu'},
          events: events(onClick: () => setState(() => _mobileMenuOpen = !_mobileMenuOpen)),
          [
            span(classes: 'navbar-burger-bar', []),
            span(classes: 'navbar-burger-bar', []),
            span(classes: 'navbar-burger-bar', []),
          ],
        ),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css.keyframes('navLinksCollapse', {
      '0%': Styles(opacity: 1, transform: .translate(x: .zero)),
      '100%': Styles(opacity: 0, transform: .translate(x: (-28).px)),
    }),
    css.keyframes('navBurgerSpawn', {
      '0%': Styles(opacity: 0, transform: .scale(0.4)),
      '100%': Styles(opacity: 1, transform: .scale(1)),
    }),
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
      css('.navbar-burger', [
        css('&').styles(
          display: .none,
          flexDirection: .column,
          justifyContent: .center,
          alignItems: .center,
          gap: .all(4.px),
          raw: {'background': 'none', 'border': 'none', 'padding': '4px', 'cursor': 'pointer'},
        ),
        css('.navbar-burger-bar').styles(
          width: 18.px,
          height: 2.px,
          radius: .all(Radius.circular(999.px)),
          backgroundColor: AppColors.ink,
        ),
      ]),
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
      css('.navbar-right').styles(
        display: .flex,
        alignItems: .center,
        gap: .all(AppSpacing.inline),
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
      css('a.navbar-cta', [
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
    css.media(MediaQuery.screen(maxWidth: 700.px), [
      // Nested under `.navbar` to match the specificity of the base rules
      // (`.navbar .navbar-burger` etc, from the nesting above) — a bare
      // `.navbar-burger` selector here has LOWER specificity than that base
      // rule and loses even when this media query matches.
      css('.navbar', [
        // Plays once, exactly when the media query starts matching (i.e.
        // when the window is dragged narrower than 700px) — CSS media
        // queries are on/off, not interpolated against the live width, so
        // this is a one-shot flourish at the crossing point, not something
        // that tracks the drag continuously. Loading directly at a narrow
        // width skips straight to the end state; there's no "crossing" to
        // play. Delayed so it visibly follows the links leaving.
        css('.navbar-burger').styles(
          display: .flex,
          animation: Animation(name: 'navBurgerSpawn', duration: 260.ms, delay: 160.ms, curve: .easeOut, fillMode: .backwards),
        ),
        // Always `display: flex` on mobile — closed vs. open is driven by
        // opacity/transform/visibility instead, because `display` itself
        // can't be transitioned (it jumps, it doesn't animate). The
        // `visibility` transition is delayed on close (but not on open) so
        // the panel stays hit-testable/focusable through the whole fade-out
        // and becomes so immediately on fade-in.
        css('.navbar-links', [
          css('&').styles(
            display: .flex,
            position: .absolute(top: 100.percent, left: .zero, right: .zero),
            padding: .all(AppSpacing.s16),
            border: .only(
              top: BorderSide.solid(color: AppColors.hairline, width: 1.px),
            ),
            opacity: 0,
            visibility: .hidden,
            pointerEvents: .none,
            animation: Animation(name: 'navLinksCollapse', duration: 320.ms, curve: .easeOut),
            transition: Transition.combine([
              Transition('opacity', duration: 250.ms, curve: .easeOut),
              Transition('transform', duration: 250.ms, curve: .easeOut),
              Transition('visibility', duration: Duration.zero, delay: 250.ms),
            ]),
            transform: .translate(y: (-8).px),
            flexDirection: .column,
            alignItems: .start,
            gap: .all(AppSpacing.s8),
            backgroundColor: AppColors.surface,
            raw: {'box-shadow': AppEffects.panelShadow},
          ),
          css('&.open').styles(
            opacity: 1,
            visibility: .visible,
            pointerEvents: .auto,
            transition: Transition.combine([
              Transition('opacity', duration: 250.ms, curve: .easeOut),
              Transition('transform', duration: 250.ms, curve: .easeOut),
              Transition('visibility', duration: Duration.zero),
            ]),
            transform: .none,
          ),
        ]),
        css('.navbar-indicator').styles(display: .none), // sliding underline doesn't apply to a stacked menu
      ]),
    ]),
  ];
}
