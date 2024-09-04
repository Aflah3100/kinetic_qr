import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kinetic_qr/providers/home_screen_provider.dart';
import 'package:kinetic_qr/router/route_constants.dart';
import 'package:kinetic_qr/screens/create_qr_code_screen/create_qr_code_screen.dart';
import 'package:kinetic_qr/screens/home_screen/widgets/bottom_nav_bar.dart';
import 'package:kinetic_qr/screens/scan_qr_code_screen/scan_qr_code_screen.dart';
import 'package:kinetic_qr/screens/settings_screen/settings_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = RouteConstants.homeScreen;
  HomeScreen({super.key});

  final screens = [
    CreateQrCodeScreen(),
    const ScanQrCodeScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomeScreenProvider>(
        builder: (context, provider, child) {
          return screens[provider.getCurrentScreenIndex()];
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
