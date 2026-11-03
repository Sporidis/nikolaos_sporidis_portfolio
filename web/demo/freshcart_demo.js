// Mounts the real FreshCart Flutter app into the demo modal's phone frames.
//
// The Jaspr components never call JavaScript: DemoModal renders empty
// `[data-freshcart-phone="a"|"b"]` elements, and this script watches the DOM.
// When they appear it starts Flutter (once per page load) and adds one view per
// element; when they leave the page it removes those views again.
//
// Contract with FreshCart: docs/freshcart-demo/embed-plan.md, reference host
// page: FreshCart's freshcart_flutter/tool/demo/demo.html.
(() => {
  const BASE = "/demo/freshcart/";
  // Below this the modal shows a recording instead of the phones, so Flutter
  // (several MB) isn't wanted. Keep in step with the media query in DemoModal.
  const SMALL_SCREEN = matchMedia("(max-width: 720px)");

  /** @type {Map<Element, number>} host element -> Flutter view id */
  const mounted = new Map();
  let appPromise = null;
  let queue = Promise.resolve();

  // Loads and starts the engine at most once; resolves with the Flutter app.
  function startFlutter() {
    if (appPromise) return appPromise;
    appPromise = new Promise((resolve, reject) => {
      // Must exist before flutter_bootstrap.js runs, so it takes the demo branch.
      window.freshcartDemo = {
        boot(flutter) {
          flutter.loader.load({
            // entrypointBaseUrl only works here, assetBase only in initializeEngine.
            // canvasKitBaseUrl self-hosts CanvasKit (default: Google's CDN). It
            // must be absolute: the loader's local fallback, "canvaskit", is
            // resolved against the page, not entrypointBaseUrl.
            config: {
              entrypointBaseUrl: BASE,
              canvasKitBaseUrl: `${BASE}canvaskit/`,
            },
            onEntrypointLoaded: async (engineInitializer) => {
              try {
                const engine = await engineInitializer.initializeEngine({
                  multiViewEnabled: true,
                  assetBase: BASE,
                });
                resolve(await engine.runApp());
              } catch (e) {
                reject(e);
              }
            },
          });
        },
      };

      const script = document.createElement("script");
      script.src = `${BASE}flutter_bootstrap.js`;
      script.async = true;
      script.onerror = () =>
        reject(new Error(`FreshCart demo: failed to load ${script.src}`));
      document.head.appendChild(script);
    });
    // Let a later open retry if loading failed (e.g. offline).
    appPromise.catch(() => {
      appPromise = null;
    });
    return appPromise;
  }

  // Flutter gets its own element inside the Jaspr-rendered slot, never the slot
  // itself: on every rebuild Jaspr strips attributes it didn't set from elements
  // it renders (Flutter sets flt-embedding, flt-renderer, spellcheck, lang, ...),
  // but it leaves nodes it didn't create alone. Styles are the host contract:
  // explicit size, positioning context, overflow hidden, no inherited text-align.
  function createHost(slot) {
    const host = document.createElement("div");
    host.style.cssText =
      "position:relative;width:100%;height:100%;overflow:hidden;text-align:left";
    slot.appendChild(host);
    return host;
  }

  async function syncViews() {
    const hosts = [...document.querySelectorAll("[data-freshcart-phone]")];
    if (!hosts.length && !mounted.size) return;

    // Small screen: the modal shows a recording, so never start Flutter for
    // it. Phones still running from before a resize are hidden now, so remove
    // them; widening the window again adds fresh ones.
    if (SMALL_SCREEN.matches) {
      if (mounted.size) {
        const app = await appPromise; // set: views only exist once it resolved
        for (const [el, viewId] of mounted) {
          app.removeView(viewId);
          // removeView leaves our host div behind. A new host added next to it
          // on widening would be pushed out of sight, so empty the slot.
          el.replaceChildren();
        }
        mounted.clear();
      }
      return;
    }

    const app = await startFlutter();

    for (const [el, viewId] of mounted) {
      if (!el.isConnected) {
        app.removeView(viewId);
        mounted.delete(el);
      }
    }
    for (const el of hosts) {
      if (mounted.has(el)) continue;
      const viewId = app.addView({
        hostElement: createHost(el),
        // locale: 'en' | 'nl', the language of the portfolio page. FreshCart
        // falls back to English when it's missing (older host pages).
        initialData: {
          persona: el.dataset.freshcartPhone,
          locale: el.dataset.freshcartLocale,
        },
      });
      mounted.set(el, viewId);
    }
  }

  // Serialised, so a burst of mutations can't add the same view twice. The
  // catch keeps one failure from poisoning every later sync.
  function scheduleSync() {
    queue = queue.then(syncViews).catch((e) => console.error(e));
  }

  new MutationObserver(scheduleSync).observe(document.body, {
    childList: true,
    subtree: true,
  });
  SMALL_SCREEN.addEventListener("change", scheduleSync);
  scheduleSync();
})();
