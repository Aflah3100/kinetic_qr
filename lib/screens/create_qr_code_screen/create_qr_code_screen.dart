import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kinetic_qr/models/contact_info_model.dart';
import 'package:kinetic_qr/providers/create_qr_code_screen_provider.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/widgets/contacts_qr_code_container.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/widgets/qr_code_options_button.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/widgets/text_qr_code_container.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/widgets/website_qr_code_container.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/widgets/wifi_qr_code_container.dart';
import 'package:kinetic_qr/screens/qr_code_display_screen/qr_code_display_screen.dart';
import 'package:kinetic_qr/utils/assets.dart';
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
    final screenProvider = context.read<CreateQrCodeScreenProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Create QR Code',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        actions: [
          // Create-button
          Selector<CreateQrCodeScreenProvider, bool>(
              selector: (context, provider) => provider.getCreateButtonStatus(),
              builder: (context, status, _) {
                return InkWell(
                  onTap: () {
                    int index = screenProvider.getScreenIndex();

                    //Text-Qr-Code-Generation
                    if (index == 0) {
                      if (textQrCodeController.text.isNotEmpty) {
                        Navigator.pushNamed(
                            context, QrCodeDisplayScreen.routeName,
                            arguments: textQrCodeController.text);
                        textQrCodeController.clear();
                      }
                    }
                    //Website-Qr-code-Generation
                    else if (index == 1) {
                      if (webisteQrCodeController.text.isNotEmpty) {
                        Navigator.pushNamed(
                            context, QrCodeDisplayScreen.routeName,
                            arguments: webisteQrCodeController.text.trim());
                        webisteQrCodeController.clear();
                      }
                    }
                    //Contacts-Qr-code-Generation
                    else if (index == 2) {
                      if (nameController.text.isNotEmpty &&
                          phoneNumbercontroller.text.isNotEmpty) {
                        final contactInfoModel = ContactInfoModel(
                            name: nameController.text,
                            phoneNumber: phoneNumbercontroller.text,
                            email: emailController.text,
                            companyName: companyNamecontroller.text,
                            jobTitle: jobTitleController.text,
                            address: addresController.text);
                        Navigator.pushNamed(
                            context, QrCodeDisplayScreen.routeName,
                            arguments: contactInfoModel.generateQrData());
                        nameController.clear();
                        phoneNumbercontroller.clear();
                        emailController.clear();
                        companyNamecontroller.clear();
                        jobTitleController.clear();
                        addresController.clear();
                      }
                    }
                    //Contacts-Qr-code-Generation
                    else if (index == 3) {
                      if (wifiNetworkNameController.text.isNotEmpty &&
                          wifiNetworkPasswordController.text.isNotEmpty) {
                        String encyptionType = '';
                        final wifiSecurityTypeIndex = context
                            .read<CreateQrCodeScreenProvider>()
                            .getWifiSecurityType();
                        if (wifiSecurityTypeIndex == 0) {
                          encyptionType = "WPA";
                        } else if (wifiSecurityTypeIndex == 1) {
                          encyptionType = 'WEP';
                        }
                        final wifiQrData =
                            'WIFI:S:${wifiNetworkNameController.text};'
                            'T:$encyptionType;'
                            'P:${wifiNetworkPasswordController.text};;';
                        Navigator.pushNamed(
                            context, QrCodeDisplayScreen.routeName,
                            arguments: wifiQrData);

                        wifiNetworkNameController.clear();
                        wifiNetworkPasswordController.clear();
                        context
                            .read<CreateQrCodeScreenProvider>()
                            .setWifiSecurityType(0);
                      }
                    }
                  },
                  child: Container(
                    width: 90,
                    height: 100,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: (status)
                          ? Assets.loadingScreenBlueColor
                          : Colors.grey[300],
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
                );
              })
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            //Bg-Image
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Image.asset(
                Assets.greyBgImage,
                fit: BoxFit.fitHeight,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                    //Display-container
                    child: Selector<CreateQrCodeScreenProvider,int>(
                      selector: (context,provider)=> provider.getScreenIndex(),
                      builder: (context,index,_) {
                        return Column(
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
                              ContactsQrCodeContainer(
                                  nameController: nameController,
                                  phoneNumbercontroller: phoneNumbercontroller,
                                  emailController: emailController,
                                  companyNameController: companyNamecontroller,
                                  jobTitleController: jobTitleController,
                                  addressController: addresController),
                        
                            // Wifi-QrCode-container
                            if (screenProvider.getScreenIndex() == 3)
                              WifiQrCodeContainer(
                                  networkNameController: wifiNetworkNameController,
                                  networkPasswordController:
                                      wifiNetworkPasswordController),
                          ],
                        );
                      }
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Bottom-option-buttons
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Selector<CreateQrCodeScreenProvider,int>(
                    selector: (ctx,provider)=> provider.getScreenIndex(),
                    builder: (context,index,_) {
                      return Wrap(
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
                      );
                    }
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
