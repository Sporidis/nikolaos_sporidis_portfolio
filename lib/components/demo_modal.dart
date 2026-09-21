import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_effects.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';

class DemoModal extends StatelessComponent {
  final VoidCallback onClose;
  const DemoModal({required this.onClose, super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'demo-overlay', [
      div(
        classes: 'demo-backdrop',
        events: events(onClick: onClose),
        [],
      ),
      div(classes: 'demo-box', [
        div(classes: 'demo-header', [
          div(classes: 'demo-header-text', [
            p(classes: 'demo-eyebrow', [.text('live demo · freshcart')]),
            h3([.text('Two phones, one list.')]),
            p(classes: 'demo-description', [
              .text(
                'Two FreshCart clients side by side, joined to the same list. Adding or ticking on one shows up on the other — the demo drops into these two frames.',
              ),
            ]),
          ]),
          button(
            events: events(onClick: onClose),
            classes: 'demo-close',
            attributes: {'aria-label': 'Close demo'},
            [.text('✕')],
          ),
        ]),
        div(classes: 'demo-sync', [
          span(classes: 'demo-sync-dot', []),
          .text('both devices up to date'),
        ]),
        div(classes: 'demo-phones', [
          for (var phone in demoPhones)
            div(classes: 'demo-phone', [
              div(classes: 'demo-phone-header', [
                span(classes: 'demo-phone-avatar', styles: Styles(raw: {'background-color': phone.color}), [
                  .text(phone.initial),
                ]),
                span(classes: 'demo-phone-name', [.text(phone.name)]),
              ]),
              div(classes: 'demo-phone-device', [
                span(classes: 'demo-phone-btn demo-phone-btn-1', []),
                span(classes: 'demo-phone-btn demo-phone-btn-2', []),
                span(classes: 'demo-phone-btn demo-phone-btn-3', []),
                div(classes: 'demo-phone-screen', [
                  div(classes: 'demo-phone-notch', []),
                  div(classes: 'demo-phone-statusbar', [
                    span([.text('9:41')]),
                    span(classes: 'demo-phone-status-icons', [
                      span(classes: 'demo-phone-signal', [
                        span([]),
                        span([]),
                        span([]),
                        span([]),
                      ]),
                      span(classes: 'demo-phone-battery', [span([])]),
                    ]),
                  ]),
                  div(classes: 'demo-phone-content', [
                    p(classes: 'demo-phone-slot', [.text(phone.slot)]),
                  ]),
                  div(classes: 'demo-phone-home-row', [
                    span(classes: 'demo-phone-home-bar', []),
                  ]),
                ]),
              ]),
            ]),
        ]),
        div(classes: 'demo-notes', [
          for (var note in demoNotes)
            div(classes: 'demo-note', [
              p(classes: 'demo-note-title', [.text(note.title)]),
              p(classes: 'demo-note-body', [.text(note.body)]),
            ]),
        ]),
        p(classes: 'demo-footnote', [.text('demo content to be wired in · esc to close')]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.demo-overlay').styles(
      display: .flex,
      position: .fixed(top: .zero, left: .zero, right: .zero, bottom: .zero),
      zIndex: ZIndex(2000),
      justifyContent: .center,
      alignItems: .start,
      raw: {'padding': '32px 20px', 'overflow-y': 'auto'},
    ),
    css('.demo-backdrop').styles(
      position: .fixed(top: .zero, left: .zero, right: .zero, bottom: .zero),

      backgroundColor: AppColors.scrim,
      raw: {'backdrop-filter': 'blur(10px)'},
    ),

    css('.demo-box', [
      css('&').styles(
        position: .relative(),
        width: 100.percent,
        padding: .only(top: AppSpacing.s28, right: AppSpacing.s28, bottom: 34.px, left: AppSpacing.s28),
        border: .all(color: AppColors.hairlineMid, width: 1.px),
        radius: .all(Radius.circular(AppRadii.feature)),
        raw: {
          'max-width': '940px',
          'margin': 'auto',
          'background-image': AppEffects.panelFill,
          'box-shadow': AppEffects.modalShadow,
        },
      ),
      css('.demo-header').styles(
        display: .flex,
        justifyContent: .spaceBetween,
        alignItems: .start,
        gap: .all(AppSpacing.s20),
      ),
      css('.demo-eyebrow').styles(
        color: AppColors.amber,
        fontFamily: AppFonts.mono,
        fontSize: AppType.label,
        raw: {'margin': '0 0 ${AppSpacing.s8.value} 0'},
      ),
      css('.demo-header-text h3').styles(
        color: AppColors.ink,
        fontFamily: AppFonts.display,
        fontWeight: FontWeight.w700,
        raw: {'font-size': AppType.modalSize, 'letter-spacing': '-0.025em', 'margin': '0 0 ${AppSpacing.s8.value} 0'},
      ),
      css('.demo-description').styles(
        color: AppColors.inkMuted,
        fontSize: AppType.bodySmall,
        raw: {'line-height': '1.6', 'max-width': '54ch', 'margin': '0', 'text-wrap': 'pretty'},
      ),
      css('.demo-close').styles(
        width: 38.px,
        height: 38.px,
        border: .all(color: AppColors.hairlineMid, width: 1.px),
        radius: .all(Radius.circular(AppRadii.control)),
        color: AppColors.inkMuted,
        fontFamily: AppFonts.mono,
        raw: {'flex': 'none', 'font-size': '17px'},
      ),
      css('.demo-sync').styles(
        display: .flex,
        width: .fitContent,
        padding: .symmetric(vertical: AppSpacing.chipY, horizontal: AppSpacing.s16),
        border: .all(color: AppColors.hairlineMid, width: 1.px),
        radius: .all(Radius.circular(AppRadii.pill)),
        alignItems: .center,
        gap: .all(AppSpacing.s8),
        color: AppColors.inkMuted,
        fontFamily: AppFonts.mono,
        fontSize: AppType.label,
        backgroundColor: AppColors.cardTint,
        raw: {'margin': '${AppSpacing.s24.value} 0'},
      ),
      css('.demo-sync-dot').styles(
        width: 7.px,
        height: 7.px,
        radius: .all(Radius.circular(999.px)),
        backgroundColor: AppColors.inkMuted,
      ),
      css('.demo-phones').styles(
        display: .grid,
        gridTemplate: GridTemplate(
          columns: GridTracks([
            GridTrack.repeat(.autoFit, [GridTrack(.minmax(TrackSize(262.px), .fr(1)))]),
          ]),
        ),
        gap: .all(AppSpacing.s20),
      ),
      css('.demo-phone-header').styles(
        display: .flex,
        alignItems: .center,
        gap: .all(AppSpacing.s8),
        raw: {'margin-bottom': AppSpacing.s12.value},
      ),
      css('.demo-phone-avatar').styles(
        display: .flex,
        width: 22.px,
        height: 22.px,
        radius: .all(Radius.circular(999.px)),
        justifyContent: .center,
        alignItems: .center,
        fontFamily: AppFonts.mono,
        fontSize: AppType.micro,
        backgroundColor: AppColors.amber,
      ),
      css('.demo-phone-name').styles(
        color: AppColors.inkMuted,
        fontFamily: AppFonts.mono,
        fontSize: AppType.label,
      ),
      css('.demo-phone-device').styles(
        position: .relative(),
        padding: .all(9.px),
        border: .all(color: AppColors.hairlineStrong, width: 1.px),
        radius: .all(Radius.circular(AppRadii.device)),
        raw: {
          'max-width': '268px',
          'margin': '0 auto',
          'background': 'linear-gradient(160deg, ${AppColors.surfaceRaised.value} 0%, #101019 45%, #1A1A26 100%)',
          'box-shadow': '0 28px 70px rgba(0,0,0,0.55), inset 0 0 0 1px rgba(0,0,0,0.6)',
        },
      ),
      css('.demo-phone-btn').styles(
        position: .absolute(),
        width: 2.px,
        backgroundColor: AppColors.chrome,
      ),
      css(
        '.demo-phone-btn-1',
      ).styles(raw: {'left': '-2px', 'top': '104px', 'height': '30px', 'border-radius': '2px 0 0 2px'}),
      css(
        '.demo-phone-btn-2',
      ).styles(raw: {'left': '-2px', 'top': '146px', 'height': '48px', 'border-radius': '2px 0 0 2px'}),
      css(
        '.demo-phone-btn-3',
      ).styles(raw: {'right': '-2px', 'top': '130px', 'height': '62px', 'border-radius': '0 2px 2px 0'}),
      css('.demo-phone-screen', [
        css('&').styles(
          display: .flex,
          position: .relative(),
          radius: .all(Radius.circular(AppRadii.screen)),
          overflow: .hidden,
          flexDirection: .column,
          backgroundColor: AppColors.background,
          raw: {'aspect-ratio': '9 / 19.5'},
        ),
        css('.demo-phone-notch').styles(
          position: Position.absolute(top: 9.px, left: 50.percent),
          zIndex: ZIndex(2),
          width: 76.px,
          height: 21.px,
          radius: .all(Radius.circular(999.px)),
          transform: .translate(x: (-50).percent),
          raw: {'background': '#05050A'},
        ),
        css('.demo-phone-statusbar').styles(
          display: .flex,
          zIndex: ZIndex(1),
          padding: .only(top: 14.px, right: 18.px, bottom: 8.px, left: 18.px),
          justifyContent: .spaceBetween,
          alignItems: .center,
          color: AppColors.inkMuted,
          fontFamily: AppFonts.mono,
          fontSize: 10.px,
        ),
        css('.demo-phone-status-icons').styles(display: .flex, alignItems: .center, gap: .all(5.px)),
        css('.demo-phone-signal').styles(
          display: .flex,
          alignItems: .end,
          gap: .all(1.5.px),
          raw: {'height': '8px'},
        ),
        css('.demo-phone-signal span').styles(
          width: 2.px,
          radius: .all(Radius.circular(1.px)),
          backgroundColor: AppColors.inkMuted,
        ),
        css('.demo-phone-signal span:nth-child(1)').styles(height: 3.px),
        css('.demo-phone-signal span:nth-child(2)').styles(height: 5.px),
        css('.demo-phone-signal span:nth-child(3)').styles(height: 7.px),
        css('.demo-phone-signal span:nth-child(4)').styles(height: 8.px),
        css('.demo-phone-battery').styles(
          display: .block,
          width: 18.px,
          height: 9.px,
          padding: .all(1.5.px),
          border: .all(color: AppColors.inkMuted, width: 1.px),
          radius: .all(Radius.circular(3.px)),
        ),
        css('.demo-phone-battery span').styles(
          display: .block,
          width: 70.percent,
          height: 100.percent,
          radius: .all(Radius.circular(1.px)),
          backgroundColor: AppColors.amber,
        ),
        css('.demo-phone-content').styles(
          display: .flex,
          padding: .all(AppSpacing.s16),
          radius: .all(Radius.circular(AppRadii.card)),
          alignItems: .end,
          raw: {
            'flex': '1',
            'margin': '6px 10px 0',
            'background-color': '#101019',
            'background-image': AppEffects.stripes,
          },
        ),
        css('.demo-phone-home-row').styles(
          display: .flex,
          padding: .symmetric(vertical: AppSpacing.s12, horizontal: .zero),
          justifyContent: .center,
        ),
        css('.demo-phone-home-bar').styles(
          width: 96.px,
          height: 4.px,
          radius: .all(Radius.circular(999.px)),
          raw: {'background': 'rgba(242,240,235,0.25)'},
        ),
      ]),
      css('.demo-phone-slot').styles(
        color: AppColors.inkFaint,
        fontFamily: AppFonts.mono,
        fontSize: AppType.micro,
        raw: {'line-height': '1.6', 'margin': '0'},
      ),
      css('.demo-notes').styles(
        display: .grid,
        padding: .only(top: AppSpacing.s20),
        border: .only(
          top: BorderSide.solid(color: AppColors.hairline, width: 1.px),
        ),
        gridTemplate: GridTemplate(
          columns: GridTracks([
            GridTrack.repeat(.autoFit, [GridTrack(.minmax(TrackSize(230.px), .fr(1)))]),
          ]),
        ),
        gap: .all(AppSpacing.s16),
        raw: {'margin-top': AppSpacing.s24.value},
      ),
      css('.demo-note', [
        css('&').styles(
          padding: .only(left: AppSpacing.s12),
          border: .only(
            left: BorderSide.solid(color: AppColors.amberBorder, width: 1.px),
          ),
        ),
        css('.demo-note-title').styles(
          color: AppColors.amber,
          fontFamily: AppFonts.mono,
          fontSize: AppType.micro,
          raw: {'margin': '0 0 ${AppSpacing.s8.value} 0'},
        ),
        css('.demo-note-body').styles(
          color: AppColors.inkMuted,
          fontSize: AppType.bodySmall,
          raw: {'line-height': '1.55', 'margin': '0'},
        ),
      ]),
      css('.demo-footnote').styles(
        color: AppColors.inkGhost,
        fontFamily: AppFonts.mono,
        fontSize: AppType.micro,
        raw: {'margin': '${AppSpacing.s20.value} 0 0 0'},
      ),
    ]),
  ];
}

class DemoPhone {
  final String name;
  final String initial;
  final String slot;
  final String color;

  const DemoPhone({required this.name, required this.initial, required this.slot, required this.color});
}

final demoPhones = [
  DemoPhone(
    name: "Nikolaos' phone",
    initial: 'N',
    color: '#D99A3D',
    slot: '[ live FreshCart client A — embed or recording goes here ]',
  ),
  DemoPhone(
    name: "Flatmate's phone",
    initial: 'A',
    color: '#7E9CDB',
    slot: '[ live FreshCart client B — same list, second device ]',
  ),
];

class DemoNote {
  final String title;
  final String body;

  const DemoNote({required this.title, required this.body});
}

final demoNotes = [
  DemoNote(
    title: 'what is real',
    body:
        'The interaction, timing and conflict behavior of the shipped app — replayed locally so the page has no backend.',
  ),
  DemoNote(
    title: 'under the hood',
    body:
        'In FreshCart each change is a typed Serverpod endpoint call; the other clients receive it on an open stream, not a poll.',
  ),
  DemoNote(
    title: 'the tricky bit',
    body:
        'Two people ticking the same item a second apart: last write wins per field, so the list never flickers back.',
  ),
];
