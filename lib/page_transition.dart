library page_transition;
import 'package:flutter/material.dart';

class PageTransition<T> extends PageRouteBuilder<T> {
  final Widget child;
  final String type;
  final Curve curve;
  final Alignment alignment;

  PageTransition(
      {Key key,
        @required this.child,
        @required this.type,
        this.curve = Curves.linear,
        this.aligment})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    switch (type) {
      case 'fade':
        return FadeTransition(opacity: animation, child: child);
        break;
      case 'rightToLeft':
        return SlideTransition(
          transformHitTests: true,
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
        break;
      case 'leftToRight':
        return SlideTransition(
          transformHitTests: true,
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
        break;
      case 'upToDown':
        return SlideTransition(
          transformHitTests: true,
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, -1.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
        break;
      case 'DownToUp':
        return SlideTransition(
          transformHitTests: true,
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, 1.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
        break;
      case 'scale':
        return ScaleTransition(
          alignment: alignment,
          scale: CurvedAnimation(
            parent: animation,
            curve: Interval(
              0.00,
              0.50,
              curve: curve,
            ),
          ),
          child: child,
        );
        break;
      case 'rotateRightToLeft':
        return new RotationTransition(
          alignment: Alignment.bottomRight,
          turns: animation,
          child: new ScaleTransition(
            alignment: Alignment.bottomLeft,
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
        break;
      case 'rotateLeftToRight':
        return new RotationTransition(
          alignment: Alignment.bottomLeft,
          turns: animation,
          child: new ScaleTransition(
            alignment: Alignment.bottomRight,
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
        break;
      case 'size':
        return Align(
          child: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
            child: child,
          ),
        );
        break;
      default:
        return FadeTransition(opacity: animation, child: child);
    }
  });
}
