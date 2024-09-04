class ContactInfoModel {
  final String name;
  final String phoneNumber;
  final String email;
  final String companyName;
  final String jobTitle;
  final String address;

  ContactInfoModel(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      required this.companyName,
      required this.jobTitle,
      required this.address});

  String generateQrData() {
    return 'Name: $name\n'
        'Phone: $phoneNumber\n'
        'Email: ${email.isEmpty ? 'None' : email}\n'
        'Company: ${companyName.isEmpty ? 'None' : companyName}\n'
        'Job Title: ${jobTitle.isEmpty ? 'None' : jobTitle}\n'
        'Address: ${address.isEmpty ? 'None' : address}\n';
  }
}
