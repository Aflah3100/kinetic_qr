import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kinetic_qr/utils/assets.dart';

class QrCodeResultDisplaycontainer extends StatelessWidget {
  const QrCodeResultDisplaycontainer({
    super.key,
    required this.capturedTime,
    required this.qrCodeResult,
    required this.barcodeType,
  });

  final BarCodeType barcodeType;
  final String qrCodeResult;
  final String capturedTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (barcodeType == BarCodeType.text)
                const Icon(
                  FontAwesomeIcons.t,
                  color: Assets.loadingScreenBlueColor,
                  size: 35,
                ),
              if (barcodeType == BarCodeType.website)
                const Icon(
                  FontAwesomeIcons.link,
                  color: Assets.loadingScreenBlueColor,
                  size: 35,
                ),
              if (barcodeType == BarCodeType.contact)
                const Icon(
                  FontAwesomeIcons.addressCard,
                  color: Assets.loadingScreenBlueColor,
                  size: 35,
                ),
              if (barcodeType == BarCodeType.wifi)
                const Icon(
                  FontAwesomeIcons.wifi,
                  color: Assets.loadingScreenBlueColor,
                  size: 35,
                ),
              if (barcodeType == BarCodeType.unknown)
                const Icon(
                  FontAwesomeIcons.qrcode,
                  color: Assets.loadingScreenBlueColor,
                  size: 35,
                ),
              const SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (barcodeType == BarCodeType.text)
                    const Text(
                      'Text',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  if (barcodeType == BarCodeType.website)
                    const Text(
                      'Website',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  if (barcodeType == BarCodeType.contact)
                    const Text(
                      'Contact',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  if (barcodeType == BarCodeType.wifi)
                    const Text(
                      'Wifi',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  if (barcodeType == BarCodeType.unknown)
                    const Text(
                      'Unknown',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  Text(
                    capturedTime,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
              child: Text(
            qrCodeResult,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ))
        ],
      ),
    );
  }
}
