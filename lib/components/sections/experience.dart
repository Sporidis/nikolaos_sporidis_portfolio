import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_colors.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_effects.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_fonts.dart';
import 'package:nikolaos_sporidis_portfolio/constants/theme/app_spacing.dart';

class ExperienceSection extends StatelessComponent {
  final String id;
  const ExperienceSection({required this.id, super.key});

  @override
  Component build(BuildContext context) {
    return section(
      id: id,
      attributes: {'data-reveal': ''},
      classes: 'experience-section',
      [
        p(classes: 'eyebrow', [.text('Experience')]),

        h2([.text('Where I\'ve shipped.')]),
        div(classes: 'timeline', [
          div(classes: 'timeline-rail', []),

          for (var entry in experienceTimeline)
            div(classes: 'timeline-entry${entry.active ? ' timeline-entry-active' : ''}', [
              span(classes: 'timeline-dot', []),

              div(classes: 'timeline-heading', [
                h3([.text(entry.title)]),
                span(classes: 'timeline-meta', [
                  .text(entry.meta),
                ]),
              ]),

              if (entry.project != null) p(classes: 'timeline-project', [.text(entry.project!)]),
              p(classes: 'timeline-description', [.text(entry.description)]),

              if (entry.impact != null && entry.learned != null)
                div(classes: 'timeline-notes', [
                  if (entry.impact != null)
                    div(classes: 'timeline-note', [
                      p(classes: 'timeline-note-label', [.text('Impact')]),
                      p(classes: 'timeline-note-value', [.text(entry.impact!)]),
                    ]),
                  if (entry.learned != null)
                    div(classes: 'timeline-note', [
                      p(classes: 'timeline-note-label', [.text('Learned')]),
                      p(classes: 'timeline-note-value', [.text(entry.learned!)]),
                    ]),
                ]),
              if (entry.stack != null)
                div(classes: 'timeline-stack', [
                  for (var chip in entry.stack!) span(classes: 'timeline-chip', [.text(chip)]),
                ]),
            ]),
        ]),
      ],
    );
  }

  @css
  static List<StyleRule> get styles => [
    css('.eyebrow').styles(
      color: AppColors.amber,
      fontFamily: AppFonts.mono,
      fontSize: AppType.label,
      raw: {'margin': '0 0 ${AppSpacing.s16.value} 0'},
    ),

    css('.timeline', [
      css('&').styles(position: .relative(), raw: {'padding-left': '34px', 'margin-top': AppSpacing.s44.value}),
    ]),

    css('.timeline-rail').styles(
      position: .absolute(left: 7.px, top: 6.px, bottom: 6.px),
      width: 1.px,
      raw: {
        'background':
            'linear-gradient(180deg, ${AppColors.amber.withOpacity(0.6).value}, ${AppColors.hairlineMid.value})',
      },
    ),

    css('.timeline-entry', [
      css('&').styles(
        position: .relative(),
        raw: {'margin-bottom': AppSpacing.s44.value},
      ),
      css('.timeline-dot').styles(
        position: .absolute(left: (-34).px, top: 6.px),
        width: 15.px,
        height: 15.px,
        border: .all(color: AppColors.hairlineStrong, width: 2.px),
        radius: .all(Radius.circular(AppRadii.pill)),
        backgroundColor: AppColors.background,
      ),

      css('.timeline-heading').styles(
        display: .flex,
        flexWrap: .wrap,
        alignItems: .baseline,
        gap: .all(AppSpacing.s12),
      ),
      css('.timeline-heading h3').styles(
        color: AppColors.ink,
        fontFamily: AppFonts.display,
        fontSize: AppType.entryTitle,
        fontWeight: FontWeight.w500,
        raw: {'margin': '0'},
      ),
      css('.timeline-meta').styles(
        color: AppColors.inkFaint,
        fontFamily: AppFonts.mono,
        fontSize: AppType.label,
      ),
      css('.timeline-project').styles(
        color: AppColors.amber,
        fontFamily: AppFonts.mono,
        fontSize: AppType.label,
        raw: {'margin': '${AppSpacing.s12.value} 0 ${AppSpacing.s16.value} 0'},
      ),
      css('.timeline-description').styles(
        color: AppColors.inkMuted,
        fontSize: AppType.body,
        raw: {
          'line-height': AppType.bodyLeading,
          'max-width': AppType.measureWide,
          'margin': '0 0 ${AppSpacing.s16.value} 0',
        },
      ),
      css('.timeline-notes').styles(
        display: .grid,
        gridTemplate: GridTemplate(
          columns: GridTracks([
            GridTrack.repeat(.autoFit, [GridTrack(.minmax(TrackSize(220.px), .fr(1)))]),
          ]),
        ),
        gap: .all(AppSpacing.s16),
        raw: {'margin-bottom': AppSpacing.s16.value},
      ),
      css('.timeline-note', [
        css('&').styles(
          padding: .only(left: AppSpacing.s16),
          border: .only(
            left: BorderSide.solid(color: AppColors.amberBorder, width: 1.px),
          ),
        ),
        css('.timeline-note-label').styles(
          color: AppColors.inkFaint,
          fontFamily: AppFonts.mono,
          fontSize: AppType.micro,
          raw: {'margin': '0 0 ${AppSpacing.s8.value} 0'},
        ),
        css('.timeline-note-value').styles(
          color: AppColors.ink,
          fontSize: AppType.bodySmall,
          raw: {'margin': '0', 'line-height': '1.55'},
        ),
      ]),
      css('.timeline-stack').styles(
        display: .flex,
        flexWrap: .wrap,
        gap: .all(AppSpacing.s8),
      ),
      css('.timeline-chip').styles(
        padding: .symmetric(vertical: AppSpacing.s8, horizontal: AppSpacing.s12),
        border: .all(color: AppColors.hairlineMid, width: 1.px),
        radius: .all(Radius.circular(AppRadii.chip)),
        color: AppColors.codeText,
        fontFamily: AppFonts.mono,
        fontSize: AppType.label,
        backgroundColor: AppColors.cardTint,
      ),
    ]),

    css('.timeline-entry-active .timeline-dot').styles(
      border: .all(color: AppColors.amber, width: 2.px),
      raw: {'box-shadow': AppEffects.nodeRing},
    ),
  ];
}

final experienceTimeline = [
  ExperienceEntry(
    title: 'Flutter Developer Intern',
    meta: '[Company] · 2025 — 2026',
    project: 'project: DimonaGuard',
    description:
        'A compliance app for tracking Dimona declarations of on-site workers: check-in/check-out flows, offline-tolerant local state, and a synced dashboard for supervisors.',
    impact: 'Replaced a paper check-in process for field teams.',
    learned: 'Designing state for unreliable networks beats designing for the happy path.',
    stack: const ['Flutter', 'Riverpod', 'REST'],
    active: true,
  ),
  ExperienceEntry(
    title: 'BSc Software Engineering',
    meta: 'graduated 2026',
    description:
        'Thesis and final-year work centred on cross-platform mobile architecture. Most of my electives went to databases, distributed systems and UX.',
    active: false,
  ),
];

class ExperienceEntry {
  final String title;
  final String meta;
  final String? project;
  final String description;
  final String? impact;
  final String? learned;
  final List<String>? stack;
  final bool active;
  ExperienceEntry({
    required this.title,
    required this.meta,
    this.project,
    required this.description,
    this.impact,
    this.learned,
    this.stack,
    required this.active,
  });
}
