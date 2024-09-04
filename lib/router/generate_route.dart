import 'package:flutter/material.dart';
import 'package:kinetic_qr/screens/home_screen/home_screen.dart';
import 'package:kinetic_qr/screens/qr_code_display_screen/qr_code_display_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case QrCodeDisplayScreen.routeName:
      final data = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => QrCodeDisplayScreen(qrCodeData: data));

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text(
                    'Screen Does not exist!',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ),
              ));
  }
}
