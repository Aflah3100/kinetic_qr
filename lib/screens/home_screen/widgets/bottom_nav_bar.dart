
import 'package:flutter/material.dart';
import 'package:kinetic_qr/providers/screens_provider.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screensProvider = Provider.of<ScreensProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 70,
      // decoration: const BoxDecoration(color: Colors.grey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavigationButton(
            icon: Icon(
              Icons.qr_code,
              color: (screensProvider.getCurrentScreenIndex() == 0)
                  ? Assets.loadingScreenBlueColor
                  : Colors.black38,
              size: 28,
            ),
            label: 'Create',
            labelColor: (screensProvider.getCurrentScreenIndex() == 0)
                ? Assets.loadingScreenBlueColor
                : Colors.black38,
            isBold: screensProvider.getCurrentScreenIndex() == 0,
            onTap: () {
              screensProvider.setCurrentScreenIndex(0);
            },
          ),
          BottomNavigationButton(
            icon: Icon(
              Icons.qr_code_scanner,
              color: (screensProvider.getCurrentScreenIndex() == 1)
                  ? Assets.loadingScreenBlueColor
                  : Colors.black38,
              size: 28,
            ),
            label: 'Scan',
            labelColor: (screensProvider.getCurrentScreenIndex() == 1)
                ? Assets.loadingScreenBlueColor
                : Colors.black38,
            isBold: screensProvider.getCurrentScreenIndex() == 1,
            onTap: () {
              screensProvider.setCurrentScreenIndex(1);
            },
          ),
          BottomNavigationButton(
            icon: Icon(
              Icons.settings_outlined,
              color: (screensProvider.getCurrentScreenIndex() == 2)
                  ? Assets.loadingScreenBlueColor
                  : Colors.black38,
              size: 28,
            ),
            label: 'Settings',
            labelColor: (screensProvider.getCurrentScreenIndex() == 2)
                ? Assets.loadingScreenBlueColor
                : Colors.black38,
            isBold: (screensProvider.getCurrentScreenIndex() == 2),
            
            onTap: () {
              screensProvider.setCurrentScreenIndex(2);
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavigationButton extends StatelessWidget {
   BottomNavigationButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.labelColor,
    required this.isBold
  });

  final Icon icon;
  final String label;
  final Color labelColor;
  final void Function() onTap;
  bool isBold;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        // color: Colors.green,
        height: 70,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              label,
              style: TextStyle(
                  fontSize: 15,
                  color: labelColor,
                  fontWeight: (isBold) ? FontWeight.bold : FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
