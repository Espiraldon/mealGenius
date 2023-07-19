import 'package:flutter/material.dart';
import 'package:happly/src/data/colors.dart';
import 'package:happly/src/screens/public/delayed_animated.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  final Function(int) onChangedStep;
  const WelcomeScreen({super.key, required this.onChangedStep});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 30,
          ),
          child: Column(children: [
            DelayedAnimated(
              delay: 1500,
              child: SizedBox(
                height: 200,
                child: Image.asset('lib/img/logo1.png'),
              ),
            ),
            DelayedAnimated(
              delay: 1500,
              child: SizedBox(
                height: 200,
                child: Image.asset('lib/img/logoprincipaleblanc.png'),
              ),
            ),
            DelayedAnimated(
              delay: 2500,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                ),
                child: Text(
                  "Take control of your meals and discover a world of culinary possibilities with our innovative food management and meal suggestion app.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: tipo,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            DelayedAnimated(
              delay: 3500,
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => widget.onChangedStep(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(13),
                  ),
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(
                      color: backgroundColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
