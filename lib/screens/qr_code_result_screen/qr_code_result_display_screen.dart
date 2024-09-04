// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kinetic_qr/router/route_constants.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeResultDisplayScreen extends StatelessWidget {
  static const routeName = RouteConstants.qrCodeResultDisplayScreen;
  const QrCodeResultDisplayScreen(
      {super.key,
      required this.barcodeList,
      required this.barCodeType,
      required this.capturedTime});
  final List<Barcode> barcodeList;
  final String barCodeType;
  final String capturedTime;

  @override
  Widget build(BuildContext context) {
    print("type $barCodeType");
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'QR Code Scan Result',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
          child: Container(
        width: width,
        padding: const EdgeInsets.all(10),
        child: Container(
          width: width,
          height: height * 0.4,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(7)),
          child: Column(
            children: [
              if (barCodeType == 'Text')
                Expanded(
                  child: TextDisplayContainer(
                      capturedTime: capturedTime,
                      qrCodeResult: barcodeList[0].rawValue ?? ''),
                ),
              if (barCodeType == 'Website Url')
                Expanded(
                    child: WebsiteDisplayContainer(
                        capturedTime: capturedTime,
                        qrCodeResult: barcodeList[0].rawValue ?? '')),
              if (barCodeType == 'Contact Info')
                Expanded(
                    child: ContactInfoDisplaycontainer(
                        capturedTime: capturedTime, qrCodeResult: barcodeList))
            ],
          ),
        ),
      )),
    );
  }
}

class TextDisplayContainer extends StatelessWidget {
  const TextDisplayContainer({
    super.key,
    required this.capturedTime,
    required this.qrCodeResult,
  });
  final String qrCodeResult;
  final String capturedTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.t,
                color: Assets.loadingScreenBlueColor,
                size: 35,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Text',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    capturedTime,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Text(
            qrCodeResult,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )))
        ],
      ),
    );
  }
}

class WebsiteDisplayContainer extends StatelessWidget {
  const WebsiteDisplayContainer({
    super.key,
    required this.capturedTime,
    required this.qrCodeResult,
  });
  final String qrCodeResult;
  final String capturedTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.link,
                color: Assets.loadingScreenBlueColor,
                size: 35,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Website',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    capturedTime,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Text(
            qrCodeResult,
            style: const TextStyle(fontSize: 20),
          )))
        ],
      ),
    );
  }
}

class ContactInfoDisplaycontainer extends StatelessWidget {
  const ContactInfoDisplaycontainer({
    super.key,
    required this.capturedTime,
    required this.qrCodeResult,
  });
  final List<Barcode> qrCodeResult;
  final String capturedTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.addressCard,
                color: Assets.loadingScreenBlueColor,
                size: 35,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Contact',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    capturedTime,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    return Text(
                      qrCodeResult[index].rawValue ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 17),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: qrCodeResult.length))
        ],
      ),
    );
  }
}
