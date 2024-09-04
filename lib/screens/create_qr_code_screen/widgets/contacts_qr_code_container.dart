import 'package:flutter/material.dart';
import 'package:kinetic_qr/providers/create_qr_code_screen_provider.dart';
import 'package:provider/provider.dart';

class ContactsQrCodeContainer extends StatelessWidget {
  const ContactsQrCodeContainer({
    super.key,
    required this.nameController,
    required this.phoneNumbercontroller,
    required this.emailController,
    required this.companyNameController,
    required this.jobTitleController,
    required this.addressController,
  });

  final TextEditingController nameController;
  final TextEditingController phoneNumbercontroller;
  final TextEditingController emailController;
  final TextEditingController companyNameController;
  final TextEditingController jobTitleController;
  final TextEditingController addressController;

  bool validateContactTextField() {
    return nameController.text.isEmpty || phoneNumbercontroller.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      (nameController.text.isNotEmpty && phoneNumbercontroller.text.isNotEmpty)
          ? context
              .read<CreateQrCodeScreenProvider>()
              .setCreateButtonStatus(true)
          : context
              .read<CreateQrCodeScreenProvider>()
              .setCreateButtonStatus(false);
    });
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '* Name:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              child: TextFormField(
                onChanged: (_) {
                  validateContactTextField()
                      ? context
                          .read<CreateQrCodeScreenProvider>()
                          .setCreateButtonStatus(false)
                      : context
                          .read<CreateQrCodeScreenProvider>()
                          .setCreateButtonStatus(true);
                },
                controller: nameController,
                keyboardType: TextInputType.name,
                minLines: 1,
                maxLines: null,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '* Phone Number:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextFormField(
              onChanged: (_) {
                validateContactTextField()
                    ? context
                        .read<CreateQrCodeScreenProvider>()
                        .setCreateButtonStatus(false)
                    : context
                        .read<CreateQrCodeScreenProvider>()
                        .setCreateButtonStatus(true);
              },
              controller: phoneNumbercontroller,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Email:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Company:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextFormField(
              controller: companyNameController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Job Title:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextFormField(
              controller: jobTitleController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Address:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextFormField(
              controller: addressController,
              keyboardType: TextInputType.name,
            )
          ],
        ));
  }
}
