import 'package:nikolaos_sporidis_portfolio/l10n/app_strings.dart';
import 'package:nikolaos_sporidis_portfolio/models/about_block.dart';
import 'package:nikolaos_sporidis_portfolio/models/demo_content.dart';
import 'package:nikolaos_sporidis_portfolio/models/experience_entry.dart';
import 'package:nikolaos_sporidis_portfolio/models/skill.dart';

class NlStrings extends AppStrings {
  const NlStrings();

  @override
  AppLocale get locale => AppLocale.nl;

  // ------------------------------------------------------------------ page
  @override
  String get pageTitle => 'Nikolaos Sporidis · Flutter developer';
  @override
  String get pageDescription =>
      'Portfolio van Nikolaos Sporidis, Flutter- en mobile developer uit België. Met FreshCart, een gedeelde boodschappenlijst in realtime, gebouwd met Flutter en Serverpod.';

  // ------------------------------------------------------------------- nav
  @override
  String get navAbout => 'Over mij';
  @override
  String get navExperience => 'Ervaring';
  @override
  String get navProjects => 'Projecten';
  @override
  String get navSkills => 'Skills';
  @override
  String get navHireMe => 'Neem me aan';
  @override
  String get navToggleMenu => 'Menu openen of sluiten';
  @override
  String get navCloseColours => 'Kleuren sluiten';
  @override
  String get navChangeColour => 'Kleur wijzigen';
  @override
  String navSwitchAccent(String accent) => 'Wissel naar accent $accent';
  @override
  String get navLanguage => 'Taal';

  // ----------------------------------------------------------------- intro
  @override
  String get introStatus => 'open voor Flutter- / mobile-jobs';
  @override
  String get introRole => 'Flutter- en mobile developer · Bachelor Toegepaste Informatica';
  @override
  String get introDescription =>
      'Ik bouw mobiele apps van begin tot eind, vooral in Flutter en Dart. Ik geef om wat gebruikers merken zonder te weten waarom: vloeiende animaties, duidelijke laad- en foutmeldingen, en schermen die alleen opnieuw opbouwen wat nodig is.';
  @override
  String get introCtaProjects => 'Bekijk projecten →';
  @override
  String get introCtaContact => 'Neem contact op';

  // ----------------------------------------------------------------- about
  @override
  String get aboutEyebrow => 'Over mij';
  @override
  String get aboutHeading => 'Ik bouw de hele app, en wil daar steeds beter in worden.';
  @override
  String get aboutParagraph1 =>
      'Dit jaar studeerde ik af in Toegepaste Informatica aan Howest, en Flutter is waar ik het meeste van mijn tijd in steek. Tijdens mijn stage bij HRMS bouwde ik DimonaGuard op mijn eentje: een werkend prototype van een check-in-app voor tablets, met de Flutter-frontend, een .NET-API en de database erachter. Het leerde me evenveel over wanneer je níét moet over-engineeren als over Flutter zelf.';
  @override
  String get aboutParagraph2 =>
      'Ik kan zelfstandig een app van idee tot werkende build brengen. Wat ik nu zoek is een team: mensen die zien wat ik over het hoofd zie en me tonen wat ik nog niet weet. Liefst Flutter en Dart, maar ik werk graag over de hele stack.';
  @override
  List<AboutBlock> get aboutFacts => const [
    AboutBlock(title: 'Opleiding', content: 'Toegepaste Informatica, Howest 2026'),
    AboutBlock(title: 'Focus', content: 'Flutter · Dart · Serverpod'),
    AboutBlock(title: 'Op zoek naar', content: 'Junior Flutter-job, op kantoor, hybride of remote'),
  ];
  @override
  String get portraitCaption => 'Nikolaos, 2026';
  @override
  String get portraitLive => 'in kleur';

  // ------------------------------------------------------------ experience
  @override
  String get experienceEyebrow => 'Ervaring';
  @override
  String get experienceHeading => 'Waar ik tot nu toe heb gebouwd.';
  @override
  String get experienceImpact => 'Impact';
  @override
  String get experienceLearned => 'Geleerd';
  @override
  List<ExperienceEntry> get experienceTimeline => const [
    ExperienceEntry(
      title: 'Stagiair Flutter Developer',
      meta: 'HRMS BV, Bredene · feb — mei 2026',
      project: 'project: DimonaGuard',
      description:
          'Een prototype van een check-in-kiosk op tablet: werknemers checken in met hun rijksregisternummer, en de app controleert hun Dimona-aangifte in realtime en maakt of corrigeert die waar nodig. Alleen gebouwd, van begin tot eind: de Flutter-app, een .NET 10 REST-API en een uitgebreide kopie van de MS SQL-database van het bedrijf.',
      impact:
          'Opgeleverd als werkend prototype, overgedragen als repo met een gebruikshandleiding, zodat HRMS het kan demonstreren aan het management en potentiële klanten. Daarnaast ging ik in hun bestaande Flutter-apps na wat onnodig opnieuw opbouwde, en zorgde ik dat waarden die nooit veranderen maar één keer worden opgebouwd.',
      learned:
          'Strikte Clean Architecture was meer dan een prototype waar ik alleen aan werkte nodig had: een use case die enkel doorgeeft aan een repository is gewoon een extra bestand, en in het begin verloor ik tijd met beslissen wat in welke laag hoorde. Eens de eerste flow stond, ging de rest sneller, maar volgende keer kies ik MVVM met repositories, zonder doorgeef-use-cases.',
      stack: ['Flutter', 'Riverpod', '.NET 10', 'MS SQL'],
      active: true,
    ),
    ExperienceEntry(
      title: 'Bachelor Toegepaste Informatica',
      meta: 'Howest · afgestudeerd 2026',
      description:
          'Mijn bachelorproef onderzocht of Clean Architecture met Riverpod een Flutter-app beter onderhoudbaar en stabieler maakt, en toetste dat aan het DimonaGuard-prototype uit mijn stage.',
      active: false,
    ),
  ];

  // -------------------------------------------------------------- projects
  @override
  String get projectsEyebrow => 'Projecten';
  @override
  String get projectsHeading => 'Eén project, goed gebouwd.';
  @override
  String get projectsDescription => 'Ik toon liever één app die ik regel per regel kan verdedigen dan vijf tutorials.';
  @override
  String get projectSyncPill => 'beide gsm’s in sync';
  @override
  String get projectFeatured => 'uitgelicht';
  @override
  String get projectMeta => 'gedeelde boodschappenlijst · Flutter + Serverpod';
  @override
  String get projectBody =>
      'Een boodschappenlijst die twee of meer gsm’s tegelijk kunnen gebruiken: sluit je aan bij een lijst met een code, en elke toevoeging, elk vinkje en elke wijziging verschijnt in realtime op de andere gsm’s. Flutter op elke gsm, een Serverpod-backend op Postgres als enige bron van waarheid, met streaming updates in plaats van pull-to-refresh. Ook zonder bereik blijft het werken: lijsten staan in de cache op de gsm, en wijzigingen wachten lokaal in een wachtrij tot de verbinding terug is. Het moeilijkste waren conflicten: twee mensen die tegelijk hetzelfde item aanpassen, of een wijziging die offline wachtte terwijl iemand anders het item aanpaste.';
  @override
  String get projectWhy =>
      'waarom ik het bouwde → ik wilde één gedeelde lijst voor ons gezin: wie merkt dat iets op is, zet het er meteen op, en wie gaat winkelen ziet wat er nodig is. En ik wilde een echt eigen project om op verder te bouwen en uit te leren.';
  @override
  String get projectSource => 'Broncode ↗';
  @override
  String get projectTryDemo => 'Probeer de live demo';
  @override
  List<String> get projectTags => const [
    'Flutter',
    'Dart',
    'Serverpod',
    'Postgres',
    'Riverpod',
    'Realtime streams',
    'Multi-device sync',
    'Offline sync',
  ];

  // ---------------------------------------------------------------- skills
  @override
  String get skillsEyebrow => 'Skills';
  @override
  String get skillsHeading => 'De gereedschapskist.';
  @override
  List<Skill> get skills => const [
    Skill(name: 'Mobile', tags: ['Flutter', 'Dart', 'Riverpod', 'Material 3', 'Animaties', 'Responsive layout']),
    Skill(
      name: 'Backend & data',
      tags: ['Serverpod', 'REST', 'PostgreSQL', 'GraphQL', 'Firebase', 'SQLite', 'Auth flows'],
    ),
    Skill(
      name: 'Tooling',
      tags: ['Git', 'GitHub Actions', 'Figma', 'VS Code', 'Android Studio', 'Claude Code', 'Jaspr', 'CI/CD', 'Docker'],
    ),
  ];

  // ---------------------------------------------------------------- footer
  @override
  String get footerEyebrow => 'Contact';
  @override
  String get footerHeading => 'Op zoek naar een junior Flutter-dev?';
  @override
  String get footerLede =>
      'Ik ben snel beschikbaar, woon in België, en loop graag samen met jou door eender welk stuk van mijn code.';
  @override
  String get footerCv => 'cv (pdf)';
  @override
  String get footerFineprint => 'gebouwd met Jaspr · overal Dart · © 2026 Nikolaos Sporidis';

  // ------------------------------------------------------------------ demo
  @override
  String get demoEyebrow => 'live demo · freshcart';
  @override
  String get demoHeading => 'Twee gsm’s, één lijst.';
  @override
  String get demoDescription =>
      'Twee FreshCart-clients naast elkaar, verbonden met dezelfde lijst. Wat je op de ene toevoegt of afvinkt, verschijnt op de andere. Probeer maar.';
  @override
  String get demoClose => 'Demo sluiten';
  @override
  String get demoSynced => 'beide toestellen up-to-date';
  @override
  String get demoFootnote => 'draait volledig in je browser · esc om te sluiten';
  @override
  String get demoMobileCaption => 'Een opname van de echte app. Open deze pagina op een computer om beide gsm’s zelf te proberen.';
  @override
  String get demoMobileAlt =>
      'Twee FreshCart-gsm’s op dezelfde lijst: wat je op de ene toevoegt of afvinkt, verschijnt meteen op de andere.';
  @override
  String get demoPhoneOwnerA => 'Gsm van Nikolaos';
  @override
  String get demoPhoneOwnerB => 'Gsm van huisgenoot';
  @override
  List<DemoNote> get demoNotes => const [
    DemoNote(
      title: 'echt in deze demo',
      body:
          'De echte FreshCart Flutter-app, gecompileerd naar het web: de UI, Riverpod-state, domeinlogica en de flow met de deelcode. Beide gsm’s draaien op één Flutter-engine.',
    ),
    DemoNote(
      title: 'gesimuleerd in deze demo',
      body:
          'Alleen de backend. De geïnstalleerde app heeft een echte Serverpod-server, met inloggen, pushmeldingen en offline sync. Hier neemt een in-memory backend in je browser die plaats in, dus niets wat je typt verlaat deze pagina.',
    ),
    DemoNote(
      title: 'het lastige stuk',
      body:
          'In de geïnstalleerde app stuurt elke opslag mee op welke versie hij gebaseerd was. Heeft iemand anders het item intussen aangepast, dan weigert de server de opslag in plaats van die wijziging te overschrijven, en de app draait terug en leest het item opnieuw. Offline wijzigingen gaan bij het synchroniseren door dezelfde controle, en de app meldt hoeveel er geweigerd zijn.',
    ),
  ];
}
