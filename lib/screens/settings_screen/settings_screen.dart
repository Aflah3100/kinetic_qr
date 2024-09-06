import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showFeedbackDialog(BuildContext context) {
    final feedbackController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text(
                'Thanks for your valuable feedback',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Your opinion makes us Improve!',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    color: Colors.grey),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                height: 160,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: feedbackController,
                  minLines: 1,
                  maxLines: 10,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Leave your feedback here'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //Submit-button
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () async {
                      if (feedbackController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Please leave your advice',
                            backgroundColor: Colors.black45,
                            textColor: Colors.white);
                      } else {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'aflah3100@gmail.com',
                          queryParameters: <String, String>{
                            'subject': 'KineticQr App Feedback',
                            'body': feedbackController.text,
                          },
                        );

                        if (await canLaunchUrl(emailLaunchUri)) {
                          await launchUrl(emailLaunchUri);
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Could not open email app',
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Assets.loadingScreenBlueColor),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.redAccent)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Settings',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            //Top-Container
            Container(
              width: double.maxFinite,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Stack(
                children: [
                  //image-container
                  SizedBox(
                    width: double.maxFinite,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        Assets.colorfulBgImage,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Kinetic QR',
                          style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffEC4533),
                              letterSpacing: 2),
                        ),
                        Expanded(child: Image.asset(Assets.qrCodeImage))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // Feedback & Support
            ListTile(
              leading: const Icon(
                Icons.feedback,
                color: Assets.loadingScreenBlueColor,
              ),
              title: const Text(
                'Feedback & Support',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                'Send us your feedback or report an issue',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              onTap: () {
                _showFeedbackDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
