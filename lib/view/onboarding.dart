import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7B61FF),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            Text(
              'CipherX',
              textAlign: TextAlign.center,
              style: GoogleFonts.brunoAceSc(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: -0.72,
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'By\nOpen Source ',
                    style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.5400000214576721),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                  TextSpan(
                    text: 'Community',
                    style: GoogleFonts.poppins(
                      color: Color(0xFFF7A301),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ]),
    );
  }
}
