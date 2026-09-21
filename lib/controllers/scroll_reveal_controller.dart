import 'package:universal_web/js_interop.dart';

import 'package:universal_web/web.dart' as web;

class ScrollRevealController {
  web.IntersectionObserver? observer;

  void attach() {
    observer = web.IntersectionObserver(
      ((JSArray<web.IntersectionObserverEntry> entries, web.IntersectionObserver obs) {
        for (final entry in entries.toDart) {
          if (entry.isIntersecting) {
            entry.target.setAttribute('data-revealed', '');
          } else {
            entry.target.removeAttribute('data-revealed');
          }
        }
      }).toJS,
      web.IntersectionObserverInit(threshold: 0.15.toJS, rootMargin: '0px 0px -25% 0px'),
    );

    final nodes = web.document.querySelectorAll('[data-reveal]');
    for (var i = 0; i < nodes.length; i++) {
      observer!.observe(nodes.item(i) as web.Element);
    }
  }

  void detach() {
    observer?.disconnect();
    observer = null;
  }
}
