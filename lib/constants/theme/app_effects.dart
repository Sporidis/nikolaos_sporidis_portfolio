/// Shadows, glows and the background mesh.
///
/// These are raw CSS strings: they layer multiple values and read better as
/// text than as nested Dart objects. Apply with
/// `Styles(raw: {'box-shadow': AppEffects.cardShadow})`.
abstract final class AppEffects {
  // -------------------------------------------------------------- elevation
  /// Card at rest.
  static const cardShadow =
      '0 18px 50px rgba(0,0,0,0.40), '
      '0 0 0 1px rgba(var(--accent-rgb),0), '
      '0 0 70px rgba(var(--accent-rgb),0)';

  /// Feature card on hover — lift plus amber glow ring.
  static const cardShadowHover =
      '0 24px 60px rgba(0,0,0,0.45), '
      '0 0 0 1px rgba(var(--accent-rgb),0.12), '
      '0 0 70px rgba(var(--accent-rgb),0.10)';

  /// Code panel, phone mock.
  static const panelShadow = '0 26px 64px rgba(0,0,0,0.55)';

  /// Modal.
  static const modalShadow = '0 40px 120px rgba(0,0,0,0.60)';

  // ------------------------------------------------------------------ glows
  /// Primary CTA hover.
  static const ctaGlow = '0 10px 40px rgba(var(--accent-rgb),0.30)';

  /// Large CTA (contact) hover.
  static const ctaGlowLarge = '0 12px 44px rgba(var(--accent-rgb),0.32)';

  /// Halo ring on small controls (hover and focus both use this shape).
  static const halo = '0 0 0 6px rgba(var(--accent-rgb),0.16)';

  /// Status dot / timeline node.
  static const nodeRing = '0 0 0 5px rgba(var(--accent-rgb),0.12)';

  /// Status dot glow.
  static const dotGlow = '0 0 0 3px rgba(var(--accent-rgb),0.16)';

  /// Ambient glow behind the IDE code panel. Pair with a blur filter on an
  /// absolutely-positioned, negative-inset layer behind the panel.
  static const ideGlow = 'radial-gradient(400px 260px at 70% 20%, rgba(var(--accent-rgb),0.09), transparent 70%)';

  // ------------------------------------------------------------- background
  /// Fixed gradient mesh. Render as a `position: fixed; inset: 0` div behind
  /// everything with `pointer-events: none`, NOT as a body background — you
  /// need it to stay put while the page scrolls.
  static const mesh =
      'radial-gradient(900px 600px at 78% -5%, rgba(var(--accent-rgb),0.10), transparent 60%), '
      'radial-gradient(760px 520px at 8% 18%, rgba(84,72,190,0.16), transparent 62%), '
      'radial-gradient(700px 700px at 60% 105%, rgba(var(--accent-rgb),0.06), transparent 60%)';

  /// Film grain. Second fixed layer above the mesh:
  /// `opacity: 0.16; mix-blend-mode: overlay`.
  static const grain =
      "url(\"data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' "
      "width='160' height='160'><filter id='n'><feTurbulence type='fractalNoise' "
      "baseFrequency='0.85' numOctaves='3'/></filter><rect width='160' height='160' "
      "filter='url(%23n)' opacity='0.6'/></svg>\")";

  /// Diagonal stripes for image placeholders / empty wells.
  static const stripes = 'repeating-linear-gradient(135deg, rgba(242,240,235,0.05) 0 2px, transparent 2px 11px)';

  /// Standard card fill (subtle top-down tint).
  static const cardFill = 'linear-gradient(180deg, rgba(242,240,235,0.035), rgba(242,240,235,0.012))';

  /// Solid panel fill (code panel, feature card, modal).
  static const panelFill = 'linear-gradient(180deg, #14141F 0%, #101019 100%)';

  /// Contact block glow.
  static const contactFill =
      'radial-gradient(700px 300px at 50% 0%, rgba(var(--accent-rgb),0.12), rgba(242,240,235,0.02) 70%)';
}
