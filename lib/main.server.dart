/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

// Server-specific Jaspr import.
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

// Imports the [App] component.
import 'app.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

void main() {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  // Starts the app.
  //
  // [Document] renders the root document structure (<html>, <head> and <body>)
  // with the provided parameters and components.
  runApp(
    Document(
      title: 'nikolaos_sporidis_portfolio',
      // No <base href="/"> (Jaspr's default). With it, `href="#about"` on /nl
      // resolves to `/#about` and every in-page link jumps to the English page.
      // Asset URLs are absolute instead (`/images/...`, `/fonts/...`).
      base: null,
      head: [
        // Mounts the FreshCart Flutter demo into the modal's phone frames.
        // Loads nothing else until the modal opens (docs/freshcart-demo/embed-plan.md).
        script(src: '/demo/freshcart_demo.js', defer: true),
      ],
      body: App(),
    ),
  );
}
