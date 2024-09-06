import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:kinetic_qr/providers/create_qr_code_screen_provider.dart';
import 'package:kinetic_qr/providers/home_screen_provider.dart';
import 'package:kinetic_qr/router/generate_route.dart';
import 'package:kinetic_qr/screens/home_screen/home_screen.dart';
import 'package:kinetic_qr/screens/loading_screen/loading_screen.dart';
import 'package:kinetic_qr/services/shared_prefs.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => CreateQrCodeScreenProvider())
      ],
      child: MaterialApp(
        title: 'Kinetic QR',
        themeMode: ThemeMode.light,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        theme: ThemeData(
            brightness: Brightness.light,
            colorScheme:
                ColorScheme.fromSeed(seedColor: Assets.loadingScreenBlueColor),
            useMaterial3: true,
            fontFamily: 'Roboto'),
        onGenerateRoute: generateRoute,
        home: FutureBuilder(
          future: SharedPrefs.instance.getLoginFlag(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data != null) {
              return HomeScreen();
            } else {
              return const LoadingScreen();
            }
          },
        ),
      ),
    );
  }
}
