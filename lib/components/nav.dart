import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_effects.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';
import 'package:nikolaos_sporidis_portfolio/models/nav_item.dart';
import 'package:nikolaos_sporidis_portfolio/viewmodels/nav_accent_viewmodel.dart';
import 'package:nikolaos_sporidis_portfolio/viewmodels/scroll_spy_viewmodel.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

class NavBar extends StatefulComponent {
  const NavBar({super.key});

  @override
  State createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  final NavAccentViewModel _navAccentViewModel = NavAccentViewModel();
  final ScrollSpyViewModel _scrollSpyViewModel = ScrollSpyViewModel();
  web.IntersectionObserver? _observer;
  JSFunction? _scrollEndListener;

  static const _swatchSize = 20.0; // button hit target
  static const _swatchGap = 8.0; // mirrors AppSpacing.s8 — kept as a raw double, it's used in px arithmetic below
  static const _swatchStep = _swatchSize + _swatchGap; // center-to-center distance
  // Closed, the rail clips to just the selected dot — but the dot's glow
  // (box-shadow blur, up to 11px) paints outside its own box and gets
  // sliced flat by that clip unless the clip window is wider than the dot.
  static const _swatchGlowPad = 10.0;

  void _applyTheme(String key) {
    setState(() {
      _navAccentViewModel.applyTheme(key);
    });
  }

  void _selectTheme(String key) {
    setState(() {
      _navAccentViewModel.selectTheme(key);
    });
  }

  bool _mobileMenuOpen = false;

  static final _scrollSpySections = navItems.where((item) => item.key != 'hire-me').toList();
  static final _hireMeItem = navItems.firstWhere((item) => item.key == 'hire-me');

  final Map<String, GlobalNodeKey<web.HTMLElement>> _linkKeys = {
    for (final item in _scrollSpySections) item.key: GlobalNodeKey(),
  };
  double _indicatorLeft = 0;
  double _indicatorWidth = 0;

  void _activate(String id) {
    final el = _linkKeys[id]?.currentNode;
    setState(() {
      _scrollSpyViewModel.activeId = id;
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
    if (_scrollSpyViewModel.updateActiveSection()) {
      _syncIndicator();
    }
  }

  void _handleScrollEnd(web.Event event) {
    _scrollSpyViewModel.suppressScrollSpy = false;
  }

  void _syncIndicator() {
    final el = _linkKeys[_scrollSpyViewModel.activeId]?.currentNode;
    setState(() {
      if (el != null) {
        _indicatorLeft = el.offsetLeft.toDouble();
        _indicatorWidth = el.offsetWidth.toDouble();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      final saved = web.window.localStorage.getItem('portfolio-accent');
      if (saved != null && _navAccentViewModel.themes.containsKey(saved)) {
        _navAccentViewModel.theme = saved;
        _applyTheme(saved);
      }
      _observer = web.IntersectionObserver(_handleIntersect.toJS);
      for (final item in _scrollSpySections) {
        final element = web.document.getElementById(item.key);
        if (element != null) _observer!.observe(element);
      }
      _scrollEndListener = _handleScrollEnd.toJS;
      web.window.addEventListener('scrollend', _scrollEndListener);
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

  Component _navLink(NavItem item) {
    if (item.key == 'hire-me') {
      return a(href: '#${item.key}', classes: 'navbar-cta', [.text(item.label)]);
    }
    return a(
      key: _linkKeys[item.key],
      href: '#${item.key}',
      classes: _scrollSpyViewModel.activeId == item.key ? 'active' : null,
      events: {
        'click': (web.Event event) {
          _scrollSpyViewModel.suppressScrollSpy = true;
          _mobileMenuOpen = false;
          _activate(item.key);
        },
      },
      [.text(item.label)],
    );
  }

  // Closed: only the selected dot shows, at the rail's origin. Open: every
  // dot fans out to its natural flex position. Achieved with two transforms
  // — the track shifts by -(step * selectedIndex) to bring the selected
  // swatch to the origin, and each swatch individually shifts by
  // (selectedIndex - itsIndex) * step to converge on that same origin. The
  // two cancel out exactly, so closed always looks like a single dot no
  // matter which theme is selected; opening just resets both to zero.
  Component _themeSwatch(String key, int index, int selectedIndex) {
    final theme = _navAccentViewModel.themes[key]!;
    final isSelected = key == _navAccentViewModel.theme;
    final visible = _navAccentViewModel.themeRailOpen || isSelected;
    final label = isSelected
        ? (_navAccentViewModel.themeRailOpen ? 'Close colours' : 'Change colour')
        : 'Switch to $key accent';
    return button(
      classes: 'theme-swatch',
      styles: Styles(
        opacity: visible ? 1 : 0,
        pointerEvents: visible ? .auto : .none,
        transform: .translate(x: (visible ? 0.0 : (selectedIndex - index) * _swatchStep).px),
      ),
      attributes: {
        'aria-pressed': '$isSelected',
        'aria-label': label,
        'title': label,
        'tabindex': visible ? '0' : '-1',
      },
      events: events(onClick: () => _selectTheme(key)),
      [
        span(
          classes: isSelected ? 'theme-swatch-dot selected' : 'theme-swatch-dot',
          styles: Styles(
            backgroundColor: Color(theme.accent),
            raw: {'--dot-glow': theme.accent},
          ),
          [],
        ),
      ],
    );
  }

  Component _themeSwitcher() {
    final keys = _navAccentViewModel.themes.keys.toList();
    final selectedIndex = keys.indexOf(_navAccentViewModel.theme);
    final openWidth = keys.length * _swatchSize + (keys.length - 1) * _swatchGap;
    final closedWidth = _swatchSize + _swatchGlowPad * 2;

    return div(classes: 'theme-switcher', [
      div(
        classes: _navAccentViewModel.themeRailOpen ? 'theme-rail open' : 'theme-rail',
        styles: Styles(width: (_navAccentViewModel.themeRailOpen ? openWidth : closedWidth).px),
        [
          div(
            classes: 'theme-rail-track',
            // Fixed to its true natural width always — otherwise, as a
            // block-level flex container with no width of its own, it
            // stretches (or shrinks) to match `.theme-rail`'s current
            // clipped width instead of its children's actual size, and the
            // browser flex-shrinks all 5 swatches to fit. That silently
            // breaks every position this file calculates, since they all
            // assume the untouched `_swatchStep` spacing.
            styles: Styles(
              width: openWidth.px,
              transform: .translate(
                x: (_navAccentViewModel.themeRailOpen ? 0.0 : _swatchGlowPad - _swatchStep * selectedIndex).px,
              ),
            ),
            [for (var i = 0; i < keys.length; i++) _themeSwatch(keys[i], i, selectedIndex)],
          ),
        ],
      ),
    ]);
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
          for (final item in _scrollSpySections) _navLink(item),
        ]),
        _themeSwitcher(),
        _navLink(_hireMeItem),
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
        backgroundColor: AppColors.amberFillIndicator,
      ),
      css('.theme-switcher').styles(
        display: .flex,
        padding: .only(left: AppSpacing.s8),
        margin: .only(left: AppSpacing.s8),
        border: .only(
          left: BorderSide.solid(color: AppColors.hairlineMid, width: 1.px),
        ),
        alignItems: .center,
      ),
      css('.theme-rail').styles(
        padding: .symmetric(vertical: _swatchGlowPad.px),
        overflow: .hidden,
        transition: Transition('width', duration: 300.ms, curve: .easeOut),
      ),
      // Open, the row is wide enough that nothing needs clipping — and
      // leaving it clipped would slice the hover-glow off any dot sitting
      // near the rail's edge.
      css('.theme-rail.open').styles(overflow: .visible),
      css('.theme-rail-track').styles(
        display: .flex,
        transition: Transition('transform', duration: 300.ms, curve: .easeOut),
        alignItems: .center,
        gap: .all(_swatchGap.px),
      ),
      css('.theme-swatch', [
        css('&').styles(
          display: .flex,
          width: _swatchSize.px,
          height: _swatchSize.px,
          radius: .all(Radius.circular(AppRadii.pill)),
          transition: Transition.combine([
            Transition('opacity', duration: 200.ms, curve: .easeOut),
            Transition('transform', duration: 300.ms, curve: .easeOut),
          ]),
          justifyContent: .center,
          alignItems: .center,
          raw: {'background': 'none', 'border': 'none', 'padding': '0', 'cursor': 'pointer'},
        ),
        css('.theme-swatch-dot').styles(
          display: .block,
          width: 11.px,
          height: 11.px,
          radius: .all(Radius.circular(AppRadii.pill)),
          raw: {'box-shadow': 'none', 'transition': 'width .25s ease, height .25s ease, box-shadow .25s ease'},
        ),
        css('.theme-swatch-dot.selected').styles(
          width: 12.px,
          height: 12.px,
          raw: {'box-shadow': '0 0 9px var(--dot-glow)'},
        ),
        css('&:hover .theme-swatch-dot').styles(
          raw: {'box-shadow': '0 0 11px var(--dot-glow)'},
        ),
      ]),
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
            color: Color('rgba(var(--accent-rgb),0.16)'),
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
          animation: Animation(
            name: 'navBurgerSpawn',
            duration: 260.ms,
            delay: 160.ms,
            curve: .easeOut,
            fillMode: .backwards,
          ),
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
