import 'dart:ui';

class Assets {
  static const qrCodeAnimation =
      'assets/animations/qr_code_loading_animation.json';
  static const rightArrowAnimation =
      'assets/animations/right_arrow_animation.json';
  static const qrCodeScanningAnimation =
      'assets/animations/qr_code_scanning_animation.json';
  static const loadingScreenBlueColor = Color.fromARGB(255, 10, 156, 185);
}

enum BarCodeType { text, website, contact, wifi,unknown }
