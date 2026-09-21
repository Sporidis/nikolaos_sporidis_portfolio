import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_effects.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';
import 'package:nikolaos_sporidis_portfolio/pages/portfolio.dart';
import 'package:nikolaos_sporidis_portfolio/components/nav.dart';
import 'package:universal_web/web.dart' as web;
import 'package:universal_web/js_interop.dart';

// The main component of your application.
//
// By using the @client annotation this component will be automatically compiled to javascript and mounted
// on the client. Therefore:
// - this file and any imported file must be compilable for both server and client environments.
// - this component and any child components will be built once on the server during pre-rendering and then
//   again on the client during normal rendering.
@client
class App extends StatefulComponent {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  web.IntersectionObserver? _observer;

  @override
  void initState() {
    super.initState();
    // Run code depending on the rendering environment.
    if (kIsWeb) {
      print("Hello client");
      // When using @client components there is no default `main()` function on the client where you would normally
      // run any client-side initialization logic. Instead you can put it here, considering this component is only
      // mounted once at the root of your client-side component tree.
      _initReveal();
    } else {
      print("Hello server");
    }
  }

  void _initReveal() {
    _observer = web.IntersectionObserver(
      ((JSArray<web.IntersectionObserverEntry> entries, web.IntersectionObserver obs) {
        for (final entry in entries.toDart) {
          if (entry.isIntersecting) {
            entry.target.setAttribute('data-revealed', '');
          } else {
            entry.target.removeAttribute('data-revealed');
          }
        }
      }).toJS,
      web.IntersectionObserverInit(threshold: 0.15.toJS, rootMargin: '0px 0px -20% 0px'),
    );

    final nodes = web.document.querySelectorAll('[data-reveal]');
    for (var i = 0; i < nodes.length; i++) {
      _observer!.observe(nodes.item(i) as web.Element);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _observer?.disconnect();
  }

  @override
  Component build(BuildContext context) {
    return .fragment([
      div(
        classes: 'mesh',
        styles: Styles(
          position: .fixed(top: .zero, left: .zero, right: .zero, bottom: .zero),
          zIndex: ZIndex(-1),
          pointerEvents: .none,
          raw: {
            'background-image': AppEffects.mesh,
            'will-change': 'opacity',
            'isolation': 'isolate',
          },
        ),
        [],
      ),
      div(classes: 'main', [
        NavBar(),
        const Portfolio(),
      ]),
    ]);
  }

  // Defines the CSS styles for this component.
  //
  // By using the @css annotation, these will be rendered automatically to CSS and included in your page.
  // Must be a variable or getter of type [List<StyleRule>].
  @css
  static List<StyleRule> get styles => [
    css('.main', [
      // The '&' refers to the parent selector of a nested style rules.
      css('&').styles(
        display: .flex,
        minHeight: 100.vh,
        flexDirection: .column,
      ),
      css('section').styles(
        display: .flex,
        maxWidth: AppSpacing.contentMax,
        padding: .symmetric(vertical: AppSpacing.sectionY, horizontal: AppSpacing.gutter),
        margin: .symmetric(horizontal: .auto, vertical: .zero),
        border: .only(
          bottom: BorderSide.solid(color: AppColors.hairline, width: 1.px),
        ),
        flexDirection: .column,
      ),
    ]),
  ];
}
