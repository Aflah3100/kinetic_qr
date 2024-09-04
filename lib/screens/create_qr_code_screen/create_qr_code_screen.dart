import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kinetic_qr/providers/create_qr_code_screen_provider.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/widgets/contacts_qr_code_container.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/widgets/qr_code_options_button.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/widgets/text_qr_code_container.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/widgets/website_qr_code_container.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/widgets/wifi_qr_code_container.dart';
import 'package:provider/provider.dart';

class CreateQrCodeScreen extends StatelessWidget {
  CreateQrCodeScreen({super.key});

  // Text-QrCode-Controllers
  final textQrCodeController = TextEditingController();

  // Website-Qrcode-Controllers
  final webisteQrCodeController = TextEditingController();

  // Contacts-Qrcode-Controllers
  final nameController = TextEditingController();
  final phoneNumbercontroller = TextEditingController();
  final emailController = TextEditingController();
  final companyNamecontroller = TextEditingController();
  final jobTitleController = TextEditingController();
  final addresController = TextEditingController();

  // Wifi-QrCode-Controller
  final wifiNetworkNameController = TextEditingController();
  final wifiNetworkPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final screenProvider =
        Provider.of<CreateQrCodeScreenProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 229),
      appBar: AppBar(
        title: const Text(
          'Create QR Code',
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          // Create-button
          InkWell(
            onTap: () {},
            child: Container(
              width: 90,
              height: 100,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
              child: const Center(
                child: Text(
                  'CREATE ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Text-QrCode-Container
                    if (screenProvider.getScreenIndex() == 0)
                      TextQrCodeContainer(
                        height: height,
                        textController: textQrCodeController,
                      ),

                    // Website-Qrcode-Container
                    if (screenProvider.getScreenIndex() == 1)
                      WebisteQrCodeContainer(
                        height: height,
                        websiteTextController: webisteQrCodeController,
                      ),

                    // Contacts-qr-code-container
                    if (screenProvider.getScreenIndex() == 2)
                      ContacrsQrCodeContainer(
                          nameController: nameController,
                          phoneNumbercontroller: phoneNumbercontroller,
                          emailController: emailController,
                          companyNameController: companyNamecontroller,
                          jobTitleController: jobTitleController,
                          addressController: addresController),

                    // wifi-QrCode-container
                    if (screenProvider.getScreenIndex() == 3)
                      WifiQrCodeContainer(
                          networkNameController: wifiNetworkNameController,
                          networkPasswordController:
                              wifiNetworkPasswordController),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  QrCodeOptionButton(
                    icon: FontAwesomeIcons.t,
                    label: 'Text',
                    isClicked: screenProvider.getScreenIndex() == 0,
                    onTap: () {
                      screenProvider.setScreenIndex(0);
                    },
                  ),
                  QrCodeOptionButton(
                    icon: FontAwesomeIcons.link,
                    label: 'Website',
                    isClicked: screenProvider.getScreenIndex() == 1,
                    onTap: () {
                      screenProvider.setScreenIndex(1);
                    },
                  ),
                  QrCodeOptionButton(
                    icon: FontAwesomeIcons.addressCard,
                    label: 'Contacts',
                    isClicked: screenProvider.getScreenIndex() == 2,
                    onTap: () {
                      screenProvider.setScreenIndex(2);
                    },
                  ),
                  QrCodeOptionButton(
                    icon: FontAwesomeIcons.wifi,
                    label: 'Wifi',
                    isClicked: screenProvider.getScreenIndex() == 3,
                    onTap: () {
                      screenProvider.setScreenIndex(3);
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
