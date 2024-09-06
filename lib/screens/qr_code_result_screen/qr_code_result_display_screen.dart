// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kinetic_qr/router/route_constants.dart';
import 'package:kinetic_qr/screens/qr_code_result_screen/widgets/result_display_container.dart';
import 'package:kinetic_qr/screens/qr_code_result_screen/widgets/result_options_button.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeResultDisplayScreen extends StatelessWidget {
  static const routeName = RouteConstants.qrCodeResultDisplayScreen;
  const QrCodeResultDisplayScreen(
      {super.key,
      required this.barcodeList,
      required this.barCodeType,
      required this.capturedTime});
  final List<Barcode> barcodeList;
  final BarCodeType barCodeType;
  final String capturedTime;

  //Utility-Functions

  String _formatWifiQrCode(String qrCode) {
    final components = qrCode.split(';');

    String ssid = 'SSID not available';
    String security = 'None';
    String password = 'None';

    for (var component in components) {
      component = component.trim();
      if (component.startsWith('S:')) {
        ssid = component.substring(2).trim();
      } else if (component.startsWith('T:')) {
        security = component.substring(2).trim();
        if (security.isEmpty) {
          security = 'None';
        }
      } else if (component.startsWith('P:')) {
        password = component.substring(2).trim();
      }
    }

    return 'SSID: $ssid\nSecurity: $security\nPassword: $password';
  }

  String _removeWifiPrefix(String qrCode) {
    if (qrCode.startsWith('WIFI:')) {
      return qrCode.substring(5);
    }
    return qrCode;
  }

  String _extractWifiPassword(String qrCode) {
    final components = qrCode.split(';');

    String password = 'None';

    for (var component in components) {
      component = component.trim();
      if (component.startsWith('P:')) {
        password = component.substring(2).trim();
        if (password.isEmpty) {
          password = 'None';
        }
      }
    }

    return password;
  }

  Future<void> _launchWebSearch(String query) async {
    final Uri searchUrl = Uri.parse('https://www.google.com/search?q=$query');

    if (await canLaunchUrl(searchUrl)) {
      await launchUrl(searchUrl, mode: LaunchMode.externalApplication);
    } else {
      //Error-toast
      Fluttertoast.showToast(
          msg: 'Coulld not luanch $searchUrl',
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  Future<void> _launchWebPage(String url) async {
    String trimmedUrl = url.trim();

    if (trimmedUrl.startsWith('http://')) {
      trimmedUrl = trimmedUrl.replaceFirst('http://', '');
    } else if (trimmedUrl.startsWith('https://')) {
      trimmedUrl = trimmedUrl.replaceFirst('https://', '');
    }

    final Uri searchUrl = Uri.parse('https://$trimmedUrl');

    if (await canLaunchUrl(searchUrl)) {
      await launchUrl(searchUrl, mode: LaunchMode.externalApplication);
    } else {
      // Error-toast
      Fluttertoast.showToast(
          msg: 'Could not launch $searchUrl',
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'QR Code Scan Result',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: width,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: height * 0.3,
                    maxHeight: height * 0.4,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: (barCodeType != BarCodeType.wifi)
                        ? QrCodeResultDisplaycontainer(
                            capturedTime: capturedTime,
                            qrCodeResult: barcodeList[0].rawValue ?? '',
                            barcodeType: barCodeType,
                          )
                        : QrCodeResultDisplaycontainer(
                            capturedTime: capturedTime,
                            qrCodeResult: _formatWifiQrCode(_removeWifiPrefix(
                                barcodeList[0].rawValue ?? '')),
                            barcodeType: barCodeType,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: [
                    QrCodeResultOptionButton(
                      icon: FontAwesomeIcons.share,
                      label: 'Share',
                      onTap: () {
                        Share.share((barCodeType != BarCodeType.wifi)
                            ? barcodeList[0].rawValue ?? ''
                            : _formatWifiQrCode(_removeWifiPrefix(
                                barcodeList[0].rawValue ?? '')));
                      },
                    ),
                    QrCodeResultOptionButton(
                      icon: FontAwesomeIcons.copy,
                      label: 'Copy',
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(
                            text: (barCodeType != BarCodeType.wifi)
                                ? barcodeList[0].rawValue ?? ''
                                : _formatWifiQrCode(_removeWifiPrefix(
                                    barcodeList[0].rawValue ?? ''))));
                        Fluttertoast.showToast(
                            msg: 'Copied to clipboard',
                            backgroundColor: Colors.black45,
                            textColor: Colors.white);
                      },
                    ),
                    if (barCodeType == BarCodeType.text ||
                        barCodeType == BarCodeType.unknown)
                      QrCodeResultOptionButton(
                        icon: FontAwesomeIcons.globe,
                        label: 'Web search',
                        onTap: () {
                          _launchWebSearch(barcodeList[0].rawValue ?? '');
                        },
                      ),
                    if (barCodeType == BarCodeType.website)
                      QrCodeResultOptionButton(
                        icon: Icons.link,
                        label: 'Open',
                        onTap: () {
                          _launchWebPage(barcodeList[0].rawValue ?? '');
                        },
                      ),
                    if (barCodeType == BarCodeType.wifi)
                      QrCodeResultOptionButton(
                        icon: Icons.lock,
                        label: 'Copy Password',
                        iconWidth: width * 0.3,
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(
                              text: _extractWifiPassword(
                                  barcodeList[0].rawValue ?? '')));
                          Fluttertoast.showToast(
                              msg: 'Password copied to clipboard',
                              backgroundColor: Colors.black45,
                              textColor: Colors.white);
                        },
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
