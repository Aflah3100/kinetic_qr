import 'package:flutter/material.dart';
import 'package:kinetic_qr/providers/create_qr_code_screen_provider.dart';
import 'package:provider/provider.dart';

class TextQrCodeContainer extends StatelessWidget {
  const TextQrCodeContainer({
    super.key,
    required this.height,
    required this.textController,
  });

  final double height;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (textController.text.isEmpty)
          ? context
              .read<CreateQrCodeScreenProvider>()
              .setCreateButtonStatus(false)
          : context
              .read<CreateQrCodeScreenProvider>()
              .setCreateButtonStatus(true);
    });

    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          //Text-QrCode-FormField
          Container(
            width: double.maxFinite,
            height: height * 0.23,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(7)),
            child: TextFormField(
              controller: textController,
              onChanged: (value) {
                if (value.isEmpty) {
                  context
                      .read<CreateQrCodeScreenProvider>()
                      .setCreateButtonStatus(false);
                } else {
                  context
                      .read<CreateQrCodeScreenProvider>()
                      .setCreateButtonStatus(true);
                }
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter  text to generate QR Code',
                  hintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400)),
              minLines: 1,
              maxLines: null,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //Warning-text
          const Text(
            '* Qr Code generated will be difficult to recognise if content exceeds more than 150 characters.',
            style: TextStyle(fontSize: 13, color: Colors.black45),
          )
        ],
      ),
    );
  }
}
