import 'package:flutter/material.dart';
import 'package:kinetic_qr/providers/screens_provider.dart';
import 'package:kinetic_qr/router/generate_route.dart';
import 'package:kinetic_qr/screens/home_screen/home_screen.dart';
import 'package:kinetic_qr/screens/loading_screen/loading_screen.dart';
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
          create: (context) => ScreensProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Kinetic QR',
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Assets.loadingScreenBlueColor),
            useMaterial3: true,
            fontFamily: 'Roboto'),
        onGenerateRoute: generateRoute,
        home: HomeScreen(),
      ),
    );
  }
}
