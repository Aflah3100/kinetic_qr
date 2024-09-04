import 'package:flutter/material.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:lottie/lottie.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Scan QR code/Barcode',
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
          Lottie.asset(
            Assets.qrCodeScanningAnimation,
            width: 300,
          )
        ],
      ),
    );
  }
}
