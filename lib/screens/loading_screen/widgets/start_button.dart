import 'package:flutter/material.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:lottie/lottie.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Assets.loadingScreenBlueColor,
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Center(
                child: Text(
                  'START',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                child: Lottie.asset(Assets.rightArrowAnimation, height: 44),
              ),
            ],
          )),
    );
  }
}
