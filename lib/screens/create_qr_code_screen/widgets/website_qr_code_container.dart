// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:kinetic_qr/providers/create_qr_code_screen_provider.dart';
import 'package:provider/provider.dart';

class WebisteQrCodeContainer extends StatefulWidget {
  const WebisteQrCodeContainer({
    super.key,
    required this.height,
    required this.websiteTextController,
  });

  final double height;
  final TextEditingController websiteTextController;

  @override
  State<WebisteQrCodeContainer> createState() => _WebisteQrCodeContainerState();
}

class _WebisteQrCodeContainerState extends State<WebisteQrCodeContainer> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (widget.websiteTextController.text.isEmpty)
          ? context
              .read<CreateQrCodeScreenProvider>()
              .setCreateButtonStatus(false)
          : context
              .read<CreateQrCodeScreenProvider>()
              .setCreateButtonStatus(true);
    });

    return SizedBox(
      width: double.maxFinite,
      child: Container(
        width: double.maxFinite,
        height: widget.height * 0.23,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              controller: widget.websiteTextController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context
                      .read<CreateQrCodeScreenProvider>()
                      .setCreateButtonStatus(true);
                } else {
                  context
                      .read<CreateQrCodeScreenProvider>()
                      .setCreateButtonStatus(false);
                }
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter website address to generate QR Code',
                  hintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400)),
              minLines: 1,
              maxLines: null,
            ),
            //Address-buttons
            SizedBox(
              height: 35,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WebsiteOptionButton(
                        label: 'http://',
                        onTap: () {
                          setState(() {
                            widget.websiteTextController.text = 'http://';
                          });
                        }),
                    const SizedBox(
                      width: 15,
                    ),
                    WebsiteOptionButton(
                        label: 'https://',
                        onTap: () {
                          setState(() {
                            widget.websiteTextController.text = 'https://';
                          });
                        }),
                    const SizedBox(
                      width: 15,
                    ),
                    WebsiteOptionButton(
                        label: 'www.',
                        onTap: () {
                          setState(() {
                            widget.websiteTextController.text = 'www.';
                          });
                        }),
                    const SizedBox(
                      width: 15,
                    ),
                    WebsiteOptionButton(
                        label: '.com',
                        onTap: () {
                          setState(() {
                            widget.websiteTextController.text = '.com';
                          });
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector WebsiteOptionButton(
      {required String label, required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 35,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(6)),
        child: Center(
            child: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
