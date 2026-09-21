import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/theme.dart';

class Footer extends StatelessComponent {
  final String id;

  Footer({required this.id});

  @override
  Component build(BuildContext context) {
    return footer(id: id, classes: 'footer', [
      div(classes: 'footer-inner', [
        p(classes: 'eyebrow', [.text('Contact')]),
        h2([.text('Looking for a junior Flutter dev?')]),
        p(classes: 'footer-lede', [
          .text('I\'m available now, based in Belgium, and happy to walk you through any of my code.'),
        ]),
        a(href: 'mailto:nikolaos.sporidis@example.com', classes: 'footer-cta', [.text('hello@nikolaos.dev')]),
        div(classes: 'footer-links', [
          a(href: 'https://github.com/nikolaos-sporidis', [.text('GitHub')]),
          a(href: 'https://www.linkedin.com/in/nikolaos-sporidis', [.text('LinkedIn')]),
          a(href: 'https://nikolaos.dev/cv.pdf', [.text('cv (pdf)')]),
        ]),
      ]),
      p(classes: 'footer-fineprint', [.text('built with Jaspr · Dart all the way down · © 2026 Nikolaos Sporidis')]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.footer').styles(
      display: .flex,
      maxWidth: AppSpacing.contentMax,
      padding: .symmetric(vertical: AppSpacing.sectionY, horizontal: AppSpacing.gutter),
      margin: .symmetric(horizontal: .auto, vertical: .zero),
      flexDirection: .column,
    ),
    css('.eyebrow').styles(
      color: AppColors.amber,
      fontFamily: AppFonts.mono,
      fontSize: AppType.label,
      raw: {'margin': '0 0 ${AppSpacing.s16.value} 0', 'letter-spacing': AppType.monoTracking.value},
    ),
    css('.footer-inner', [
      css('&').styles(
        position: .relative(),
        padding: .symmetric(vertical: 58.px, horizontal: 44.px),
        border: .all(color: Color('rgba(245,166,35,0.22)'), width: 1.px),
        radius: .all(Radius.circular(AppRadii.feature)),
        textAlign: .center,
        raw: {'background-image': AppEffects.contactFill},
      ),
      css('h2').styles(raw: {'font-size': AppType.displaySize, 'margin-bottom': '18px'}),
    ]),
    css('.footer-lede').styles(
      color: AppColors.inkMuted,
      fontSize: 17.px,
      raw: {'line-height': '1.65', 'max-width': '46ch', 'margin': '0 auto 34px', 'text-wrap': 'pretty'},
    ),
    css('.footer-cta', [
      css('&').styles(
        display: .inlineBlock,
        padding: .symmetric(vertical: AppSpacing.s16, horizontal: 30.px),
        radius: .all(Radius.circular(11.px)),
        color: AppColors.onAmber,
        fontFamily: AppFonts.mono,
        fontSize: 14.px,
        fontWeight: FontWeight.w500,
        backgroundColor: AppColors.amber,
        raw: {'transition': 'box-shadow .3s ease, transform .3s ease'},
      ),
      css('&:hover').styles(
        color: AppColors.onAmber,
        raw: {'box-shadow': AppEffects.ctaGlowLarge, 'transform': 'translateY(-2px)'},
      ),
    ]),
    css('.footer-links', [
      css('&').styles(
        display: .flex,
        flexWrap: .wrap,
        justifyContent: .center,
        gap: .all(26.px),
        raw: {'margin-top': '34px'},
      ),
      css('a').styles(
        color: AppColors.inkMuted,
        fontFamily: AppFonts.mono,
        fontSize: 12.5.px,
      ),
      css('a:hover').styles(color: AppColors.amber),
    ]),
    css('.footer-fineprint').styles(
      color: Color('#4E4B5C'),
      textAlign: .center,
      fontFamily: AppFonts.mono,
      fontSize: AppType.label,
      raw: {'margin': '40px 0 0'},
    ),
  ];
}
