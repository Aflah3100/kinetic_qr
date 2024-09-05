import 'package:flutter/material.dart';
import 'package:kinetic_qr/utils/assets.dart';

class QrCodeResultOptionButton extends StatelessWidget {
  const QrCodeResultOptionButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap,
      this.iconWidth});
  final IconData icon;
  final String label;
  final double? iconWidth;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        width: (iconWidth == null) ? width * 0.2 : iconWidth,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Assets.loadingScreenBlueColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}