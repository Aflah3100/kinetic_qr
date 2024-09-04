import 'package:flutter/material.dart';

class ContacrsQrCodeContainer extends StatelessWidget {
  const ContacrsQrCodeContainer({
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

  @override
  Widget build(BuildContext context) {
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
