import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kinetic_qr/screens/qr_code_result_screen/qr_code_result_display_screen.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:torch_light/torch_light.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({super.key});

  @override
  _ScanQrCodeScreenState createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  final MobileScannerController scannerController = MobileScannerController();
  bool isProcessing = false;
  bool isTorchOn = false;
  File? pickedImage;

  void _toggleTorch() async {
    try {
      if (isTorchOn) {
        scannerController.toggleTorch();
      } else {
        scannerController.toggleTorch();
      }

      setState(() {
        isTorchOn = !isTorchOn;
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Could not toggle torch: $e',
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  Future<void> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      await Permission.mediaLibrary.request();
    } else if (Platform.isIOS) {
      await Permission.photos.request();
    } else {
      await Permission.storage.request();
    }
  }

  Future<File?> _pickImage() async {
    await _requestStoragePermission();
    PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.mediaLibrary.status;
    } else if (Platform.isIOS) {
      status = await Permission.photos.status;
    } else {
      status = await Permission.storage.status;
    }

    if (status.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    }

    Fluttertoast.showToast(
      msg: 'Permission denied to access gallery',
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    return null;
  }

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
          child: Stack(
            children: [
              Column(
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
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: const Color.fromARGB(128, 57, 56, 56),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            _toggleTorch();
                          },
                          child: Icon(
                            isTorchOn ? Icons.flash_off : Icons.flash_on,
                            size: 23,
                            color: Colors.white,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: VerticalDivider(),
                        ),
                        InkWell(
                          onTap: () async {
                            File? pickedImage = await _pickImage();
                            print("Image: $pickedImage");
                            if (pickedImage != null) {
                              //scn-qr-code
                            }
                          },
                          child: const Icon(
                            size: 23,
                            Icons.photo,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
