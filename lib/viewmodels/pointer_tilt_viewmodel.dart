import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

class PointerTiltViewModel {
  final GlobalNodeKey<web.HTMLElement> cardKey = GlobalNodeKey();

  bool hover = false;

  double rotX = 0;
  double rotY = 0;
  double translateX = 0;
  double translateY = 0;
  double lightX = 50;
  double lightY = 30;

  void enter() {
    hover = true;
  }

  void leave() {
    hover = false;
    rotX = 0;
    rotY = 0;
    translateX = 0;
    translateY = 0;
    lightX = 50;
    lightY = 30;
  }

  void move(double nx, double ny) {
    final el = cardKey.currentNode;
    if (el == null) return;

    rotX = (ny - 0.5) * 30;
    rotY = (nx - 0.5) * -30;
    translateX = (nx - 0.5) * 20;
    translateY = (ny - 0.5) * 20;
    lightX = nx * 100;
    lightY = ny * 100;
  }
}
