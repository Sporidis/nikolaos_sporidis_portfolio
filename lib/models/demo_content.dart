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
