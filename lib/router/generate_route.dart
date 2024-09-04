import 'package:flutter/material.dart';
import 'package:kinetic_qr/screens/home_screen/home_screen.dart';
import 'package:kinetic_qr/screens/qr_code_display_screen/qr_code_display_screen.dart';
import 'package:kinetic_qr/screens/qr_code_result_screen/qr_code_result_display_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case QrCodeDisplayScreen.routeName:
      final data = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => QrCodeDisplayScreen(qrCodeData: data));
    case QrCodeResultDisplayScreen.routeName:
      final args = routeSettings.arguments as List;
      final barcodeList = args[0] as List<Barcode>;
      final barCodeType = args[1] as String;
      final capturedTime=args[2] as String;
      return MaterialPageRoute(
          builder: (_) => QrCodeResultDisplayScreen(
                barcodeList: barcodeList,
                barCodeType: barCodeType,
                capturedTime: capturedTime,
              ));

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
