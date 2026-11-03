import 'package:jaspr/jaspr.dart';
import 'package:nikolaos_sporidis_portfolio/models/about_block.dart';
import 'package:nikolaos_sporidis_portfolio/models/demo_content.dart';
import 'package:nikolaos_sporidis_portfolio/models/experience_entry.dart';
import 'package:nikolaos_sporidis_portfolio/models/nav_item.dart';
import 'package:nikolaos_sporidis_portfolio/models/skill.dart';

/// The languages the portfolio ships in. Each one is its own pre-rendered page
/// (see `App`), so the language never changes while a page is open.
enum AppLocale {
  en(path: '/', label: 'EN'),
  nl(path: '/nl', label: 'NL');

  const AppLocale({required this.path, required this.label});

  /// The route this language is served at.
  final String path;

  /// Short label for the language switch in the nav.
  final String label;

  /// BCP 47 code, for `<html lang>`, `hreflang` and the FreshCart demo.
  String get code => name;
}

/// Every piece of copy on the site, once per language.
///
/// An abstract class instead of a `Map<String, String>`: forget a translation
/// and the subclass stops compiling, instead of the live page showing a blank.
/// Getters that aren't language-specific (anchor ids, colours, the demo
/// personas) are implemented here once, so translations only supply text.
abstract class AppStrings {
  const AppStrings();

  AppLocale get locale;

  // ------------------------------------------------------------------ page
  String get pageTitle;
  String get pageDescription;

  // ------------------------------------------------------------------- nav
  String get navAbout;
  String get navExperience;
  String get navProjects;
  String get navSkills;
  String get navHireMe;
  String get navToggleMenu;
  String get navCloseColours;
  String get navChangeColour;
  String navSwitchAccent(String accent);
  String get navLanguage;

  List<NavItem> get navItems => [
    NavItem(key: 'about', label: navAbout),
    NavItem(key: 'experience', label: navExperience),
    NavItem(key: 'projects', label: navProjects),
    NavItem(key: 'skills', label: navSkills),
    NavItem(key: navHireMeId, label: navHireMe),
  ];

  // ----------------------------------------------------------------- intro
  String get introStatus;
  String get introRole;
  String get introDescription;
  String get introCtaProjects;
  String get introCtaContact;

  // ----------------------------------------------------------------- about
  String get aboutEyebrow;
  String get aboutHeading;
  String get aboutParagraph1;
  String get aboutParagraph2;
  List<AboutBlock> get aboutFacts;
  String get portraitCaption;
  String get portraitLive;

  // ------------------------------------------------------------ experience
  String get experienceEyebrow;
  String get experienceHeading;
  String get experienceImpact;
  String get experienceLearned;
  List<ExperienceEntry> get experienceTimeline;

  // -------------------------------------------------------------- projects
  String get projectsEyebrow;
  String get projectsHeading;
  String get projectsDescription;
  String get projectSyncPill;
  String get projectFeatured;
  String get projectMeta;
  String get projectBody;
  String get projectWhy;
  String get projectSource;
  String get projectTryDemo;
  List<String> get projectTags;

  // ---------------------------------------------------------------- skills
  String get skillsEyebrow;
  String get skillsHeading;
  List<Skill> get skills;

  // ---------------------------------------------------------------- footer
  String get footerEyebrow;
  String get footerHeading;
  String get footerLede;
  String get footerCv;
  String get footerFineprint;

  // ------------------------------------------------------------------ demo
  String get demoEyebrow;
  String get demoHeading;
  String get demoDescription;
  String get demoClose;
  String get demoSynced;
  String get demoFootnote;
  String get demoMobileCaption;
  String get demoMobileAlt;
  String get demoPhoneOwnerA;
  String get demoPhoneOwnerB;
  List<DemoNote> get demoNotes;

  List<DemoPhone> get demoPhones => [
    DemoPhone(name: demoPhoneOwnerA, initial: 'N', color: '#D99A3D', persona: 'a'),
    DemoPhone(name: demoPhoneOwnerB, initial: 'A', color: '#7E9CDB', persona: 'b'),
  ];
}

/// Makes the current page's [AppStrings] available to every component below
/// it, the same way `Theme.of(context)` works in Flutter.
class Strings extends InheritedComponent {
  const Strings({required this.strings, required super.child, super.key});

  final AppStrings strings;

  static AppStrings of(BuildContext context) {
    final scope = context.dependOnInheritedComponentOfExactType<Strings>();
    assert(scope != null, 'No Strings above this component. Wrap the page in Strings(...).');
    return scope!.strings;
  }

  @override
  bool updateShouldNotify(Strings oldComponent) => oldComponent.strings.locale != strings.locale;
}
