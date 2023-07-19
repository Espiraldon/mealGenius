import 'package:flutter/material.dart';
import 'package:happly/src/data/colors.dart';
import 'package:happly/src/screens/public/delayed_animated.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialScreen extends StatefulWidget {
  final Function(int) onChangedStep;
  const SocialScreen({required this.onChangedStep, super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () => widget.onChangedStep(0)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 30,
          ),
          child: Column(
            children: [
              DelayedAnimated(
                delay: 1500,
                child: SizedBox(
                  height: 200,
                  child: SizedBox(
                      height: 200,
                      child: Image.asset('lib/img/logo2blanc.png')),
                ),
              ),
              DelayedAnimated(
                delay: 2500,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Life style change here",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Save the ingredients you have and make your weekly receipe with AI",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          color: tipo,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DelayedAnimated(
                delay: 3500,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => widget.onChangedStep(2),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.mail_outline_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "EMAIL",
                              style: GoogleFonts.lato(
                                color: backgroundColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () => widget.onChangedStep(2),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(220, 30, 87, 183),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.facebook_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "FACEBOOK",
                              style: GoogleFonts.lato(
                                color: backgroundColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () => widget.onChangedStep(2),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 25,
                                child: Image.asset('lib/img/gmal.jpg')),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "GMAIL",
                              style: GoogleFonts.lato(
                                color: tipo,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
