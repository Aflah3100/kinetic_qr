import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kinetic_qr/screens/qr_code_result_screen/qr_code_result_display_screen.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodeScreen extends StatefulWidget {
  ScanQrCodeScreen({super.key});

  @override
  _ScanQrCodeScreenState createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  final MobileScannerController scannerController = MobileScannerController();
  bool isProcessing = false;

  String captureTime() {
    DateTime now = DateTime.now();

    String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    return formattedTime;
  }

  bool isContactInfo(String data) {
    return data.contains('Name:') &&
        data.contains('Phone:') &&
        data.contains('Email:') &&
        data.contains('Company:') &&
        data.contains('Job Title:') &&
        data.contains('Address:');
  }

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: scannerController,
      overlayBuilder: (context, constraints) {
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
              ),
            ],
          ),
        );
      },
      onDetect: (capturedBarcode) async {
        if (!isProcessing) {
          setState(() {
            isProcessing = true;
          });

          final List<Barcode> barcodeList = capturedBarcode.barcodes;
          final Barcode barcode = barcodeList.first;
          BarCodeType dataType = BarCodeType.unknown;

          if (barcode.type == BarcodeType.url) {
            dataType = BarCodeType.website;
          } else if (isContactInfo(barcode.rawValue ?? '')) {
            dataType = BarCodeType.contact;
          } else if (barcode.type == BarcodeType.text) {
            dataType = BarCodeType.text;
          } else if (barcode.type == BarcodeType.wifi) {
            dataType = BarCodeType.wifi;
          }

          // Navigate to the result screen
          Navigator.pushNamed(
            context,
            QrCodeResultDisplayScreen.routeName,
            arguments: [barcodeList, dataType, captureTime()],
          ).then((_) {
            setState(() {
              isProcessing = false;
            });
          });
        }
      },
    );
  }
}
