// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:nikolaos_sporidis_portfolio/components/sections/about.dart'
    as _about;
import 'package:nikolaos_sporidis_portfolio/components/sections/experience.dart'
    as _experience;
import 'package:nikolaos_sporidis_portfolio/components/sections/intro.dart'
    as _intro;
import 'package:nikolaos_sporidis_portfolio/components/sections/projects.dart'
    as _projects;
import 'package:nikolaos_sporidis_portfolio/components/sections/skills.dart'
    as _skills;
import 'package:nikolaos_sporidis_portfolio/components/demo_modal.dart'
    as _demo_modal;
import 'package:nikolaos_sporidis_portfolio/components/footer.dart' as _footer;
import 'package:nikolaos_sporidis_portfolio/components/ide_block.dart'
    as _ide_block;
import 'package:nikolaos_sporidis_portfolio/components/nav.dart' as _nav;
import 'package:nikolaos_sporidis_portfolio/components/portrait_card.dart'
    as _portrait_card;
import 'package:nikolaos_sporidis_portfolio/components/project_card.dart'
    as _project_card;
import 'package:nikolaos_sporidis_portfolio/constants/theme/theme.dart'
    as _theme;
import 'package:nikolaos_sporidis_portfolio/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {_app.App: ClientTarget<_app.App>('app')},
  styles: () => [
    ..._theme.styles,
    ..._app.AppState.styles,
    ..._demo_modal.DemoModal.styles,
    ..._footer.Footer.styles,
    ..._ide_block.IdeBlockState.styles,
    ..._nav.NavBarState.styles,
    ..._portrait_card.PortraitCardState.styles,
    ..._project_card.ProjectCardState.styles,
    ..._about.AboutSection.styles,
    ..._experience.ExperienceSection.styles,
    ..._intro.IntroSection.styles,
    ..._projects.ProjectsSection.styles,
    ..._skills.SkillsSection.styles,
  ],
);
