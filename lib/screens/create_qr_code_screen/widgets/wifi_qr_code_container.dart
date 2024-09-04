// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:kinetic_qr/providers/create_qr_code_screen_provider.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:provider/provider.dart';

class WifiQrCodeContainer extends StatelessWidget {
  const WifiQrCodeContainer({
    super.key,
    required this.networkNameController,
    required this.networkPasswordController,
  });

  final TextEditingController networkNameController;
  final TextEditingController networkPasswordController;

  bool validateWifiTextField() {
    return networkNameController.text.isEmpty ||
        networkPasswordController.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (networkNameController.text.isNotEmpty &&
              networkPasswordController.text.isNotEmpty)
          ? context
              .read<CreateQrCodeScreenProvider>()
              .setCreateButtonStatus(true)
          : context
              .read<CreateQrCodeScreenProvider>()
              .setCreateButtonStatus(false);
    });

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
                onChanged: (_) {
                  validateWifiTextField()
                      ? context
                          .read<CreateQrCodeScreenProvider>()
                          .setCreateButtonStatus(false)
                      : context
                          .read<CreateQrCodeScreenProvider>()
                          .setCreateButtonStatus(true);
                },
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
              onChanged: (_) {
                validateWifiTextField()
                    ? context
                        .read<CreateQrCodeScreenProvider>()
                        .setCreateButtonStatus(false)
                    : context
                        .read<CreateQrCodeScreenProvider>()
                        .setCreateButtonStatus(true);
              },
              controller: networkPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Security: ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Selector<CreateQrCodeScreenProvider, int>(
                selector: (context, notifier) => notifier.getWifiSecurityType(),
                builder: (context, index, _) {
                  final provider = context.read<CreateQrCodeScreenProvider>();
                  return Container(
                    width: double.maxFinite,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: WifiSecurityButton(
                              label: 'WPA/WPA2',
                              isSelected: (index == 0),
                              onTap: () {
                                provider.setWifiSecurityType(0);
                              }),
                        ),
                        Expanded(
                          child: WifiSecurityButton(
                              label: 'WEP',
                              isSelected: (index == 1),
                              onTap: () {
                                provider.setWifiSecurityType(1);
                              }),
                        ),
                        Expanded(
                          child: WifiSecurityButton(
                              label: 'None',
                              isSelected: (index == 2),
                              onTap: () {
                                provider.setWifiSecurityType(2);
                              }),
                        )
                      ],
                    ),
                  );
                })
          ],
        ));
  }

  GestureDetector WifiSecurityButton(
      {required String label,
      required bool isSelected,
      required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color:
              (isSelected) ? Assets.loadingScreenBlueColor : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: (isSelected) ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
