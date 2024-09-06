import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinetic_qr/router/route_constants.dart';
import 'package:kinetic_qr/screens/loading_screen/widgets/start_button.dart';
import 'package:kinetic_qr/utils/assets.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = RouteConstants.loadingScreen;
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Image.asset(
              Assets.shinyWhiteBgImage,
              fit: BoxFit.fitHeight,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 15),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          'Welcome To',
                          style: GoogleFonts.dancingScript(
                              fontSize: 47.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 2),
                        )),
                        const Text(
                          'Kinetic QR',
                          style: TextStyle(
                              fontFamily: 'Kanit',
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffEC4533),
                              letterSpacing: 2),
                        ),
                        const SizedBox(
                          height: 70.0,
                        ),
                        const Text(
                          'Empowering Your Journey ',
                          style: TextStyle(
                              fontSize: 35.0,
                              fontFamily: 'Protest Guerilla',
                              fontWeight: FontWeight.w100,
                              letterSpacing: 1,
                              color: Color(0xff13B9DB)),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'With ',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Protest Guerilla',
                                  letterSpacing: 2.5,
                                  color: Color(0xff14C5D9)),
                            ),
                            Text(
                              'Every ',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Protest Guerilla',
                                  letterSpacing: 2.5,
                                  color: Color(0xffEC4533)),
                            ),
                            Text(
                              'Scan ',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Protest Guerilla',
                                  letterSpacing: 2.5,
                                  color: Color(0xffF2BF27)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        //Scan-logo-animation
                        Container(
                          padding: const EdgeInsets.only(left: 45),
                          child: Center(
                              child: Lottie.asset(
                            Assets.qrCodeAnimation,
                            fit: BoxFit.fill,
                          )),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(30),
                child: StartButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
