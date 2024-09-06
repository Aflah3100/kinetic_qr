import 'package:flutter/material.dart';
import 'package:kinetic_qr/utils/assets.dart';

class QrCodeOptionButton extends StatelessWidget {
  const QrCodeOptionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isClicked,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool isClicked;
  final void Function() onTap;
  

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: width *0.2,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: (isClicked)
                ? Border.all(color: Assets.loadingScreenBlueColor, width: 2)
                : null),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: (isClicked) ? Assets.loadingScreenBlueColor : Colors.black,
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
