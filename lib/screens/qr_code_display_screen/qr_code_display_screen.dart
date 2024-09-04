import 'package:flutter/material.dart';
import 'package:kinetic_qr/router/route_constants.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeDisplayScreen extends StatelessWidget {
  static const routeName = RouteConstants.qrCodeDisplayScreen;
  const QrCodeDisplayScreen({super.key, required this.qrCodeData});
  final String qrCodeData;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          ' QR Code',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            //Qr-code-display-container
            Container(
              width: width,
              height: height * 0.45,
              child: Center(
                child: Container(
                  width: width * 0.7,
                  color: Colors.white,
                  child: QrImageView(
                    data: qrCodeData,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.white),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OptionsButton(
                        width: width,
                        label: 'Save ',
                        onTap: () {},
                        buttonColor: Assets.loadingScreenBlueColor,
                        icon: const Icon(
                          Icons.save_outlined,
                          color: Colors.white,
                        )),
                    OptionsButton(
                        width: width,
                        label: 'Cancel',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonColor: const Color(0xffEC4533))
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  InkWell OptionsButton(
      {required double width,
      required String label,
      required void Function() onTap,
      required Color buttonColor,
      Icon? icon}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width * 0.25,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(7)),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
            icon ?? const SizedBox(),
          ],
        )),
      ),
    );
  }
}
