import 'package:flutter/material.dart';
import 'package:kinetic_qr/utils/assets.dart';

class QrCodeDisplayScreen extends StatelessWidget {
  const QrCodeDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
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
              color: Colors.green,
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
                        label: 'Save QR Code',
                        onTap: () {},
                        buttonColor: Assets.loadingScreenBlueColor),
                    OptionsButton(
                        width: width,
                        label: 'Cancel',
                        onTap: () {},
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
      required Color buttonColor}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width * 0.25,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(7)),
        child: Center(
            child: Text(
          label,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
