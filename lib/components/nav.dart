import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';

class NavBar extends StatelessComponent {
  const NavBar({super.key});

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
        a(classes: 'active', href: '#about', [.text('About')]),
        a(href: '#experience', [.text('Experience')]),
        a(href: '#projects', [.text('Projects')]),
        a(href: '#skills', [.text('Skills')]),
        a(href: '#hire-me', [.text('Hire me')]),
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
      css('.navbar-brand-prefix').styles(color: AppColors.ink),
      css('.navbar-brand-suffix').styles(color: AppColors.amber),
      css('.navbar-links').styles(
        display: .flex,
        gap: .all(AppSpacing.inline),
      ),
      css('.navbar-links a').styles(
        padding: .symmetric(horizontal: AppSpacing.s8, vertical: AppSpacing.s4),
        color: AppColors.ink,
      ),
      css('.navbar-links a.active').styles(
        radius: .all(Radius.circular(AppRadii.chip)),
        color: AppColors.amber,
        backgroundColor: AppColors.amber.withOpacity(0.1),
      ),
    ]),
  ];
}
