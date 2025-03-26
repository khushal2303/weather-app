import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void push(Widget page,
      [PageTransitionsEnum pageTransitions = PageTransitionsEnum.rightToLeft]) {
    Navigator.of(this).push(_createRoute(page, pageTransitions));
  }

  Future<dynamic> pushWithResult(Widget page,
      [PageTransitionsEnum pageTransitions =
          PageTransitionsEnum.rightToLeft]) async {
    return await Navigator.of(this).push(_createRoute(page, pageTransitions));
  }

  void pushAndRemoveUntil(Widget page, {bool router = false}) {
    Navigator.pushAndRemoveUntil(
      this,
      _createRoute(page),
      (route) => router,
    );
  }

  void pop([dynamic value]) {
    Navigator.pop(this, value);
  }

  // Helper method to create the right-to-left page route
  PageRouteBuilder _createRoute(Widget page,
      [PageTransitionsEnum pageTransitions = PageTransitionsEnum.rightToLeft]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = pageTransitions.offSet;
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

enum PageTransitionsEnum {
  leftToRight(),
  rightToLeft(),
  topToBottom(),
  bottomToTop();

  const PageTransitionsEnum();

  bool get isLeftToRight => this == leftToRight;
  bool get isRightToLeft => this == rightToLeft;
  bool get isTopToBottom => this == topToBottom;
  bool get isBottomToTop => this == bottomToTop;

  Offset get offSet {
    switch (this) {
      case leftToRight:
        return const Offset(-1.0, 0.0);
      case rightToLeft:
        return const Offset(1.0, 0.0);
      case topToBottom:
        return const Offset(1.0, 0.0);
      case bottomToTop:
        return const Offset(0.0, 1.0);
    }
  }
}
