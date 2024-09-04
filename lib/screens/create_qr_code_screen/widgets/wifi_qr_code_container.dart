import 'package:flutter/material.dart';

class WifiQrCodeContainer extends StatelessWidget {
  const WifiQrCodeContainer({
    super.key,
    required this.networkNameController,
    required this.networkPasswordController,
  });

  final TextEditingController networkNameController;
  final TextEditingController networkPasswordController;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '* Network Name (SSID) :',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              child: TextFormField(
                controller: networkNameController,
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '* Password: ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextFormField(
              controller: networkPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
          ],
        ));
  }
}
