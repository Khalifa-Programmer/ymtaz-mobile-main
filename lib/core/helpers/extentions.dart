import 'package:flutter/material.dart';

extension Navigate on BuildContext {
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  //context.

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension CountryCode on String {
  String get flagEmoji => toUpperCase()
      .split('')
      .map((c) => c.codeUnitAt(0) + 127397)
      .map(String.fromCharCode)
      .join();
}
