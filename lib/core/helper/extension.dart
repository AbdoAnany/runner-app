import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {

//-> Navigation extension  Like [context.pop() , context.pushNamed(routes.login)]



  Future<dynamic> pushScreen(Widget child) {
    return Navigator.of(this).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: Duration(seconds: 1),
        reverseTransitionDuration: Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Start position
          const end = Offset.zero; // End position
          const curve = Curves.easeInOut; // Animation curve

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }
  void pop() => Navigator.canPop(this) ? Navigator.of(this).pop() : debugPrint('no pop');

//-> Size
  double get width => MediaQuery.of(this).size.width ;
  double get height => MediaQuery.of(this).size.height ;

}