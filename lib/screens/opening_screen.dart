import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'login_screen.dart';

class OpenningScreen extends StatelessWidget {
  const OpenningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width =
        MediaQuery.of(context).size.width; // to get the width of the screen
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.14,
            ),
            Lottie.asset('assets/lotties/open.json'),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              'Chat with your friends, share photo and video files fast with high quality',
              style: GoogleFonts.poppins(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.16,
            ),
          ],
        ),
      ),
    );
  }
}
