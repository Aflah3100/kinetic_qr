import 'package:flutter/material.dart';

class ScanQrCodeScreen extends StatelessWidget {
  const ScanQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Scaffold(
        body: Center(
          child: Text('Scan qr code'),
        ),
      ),
    );
  }
}
