import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/data.dart';

class DailyConsumeWidget extends StatefulWidget {
  const DailyConsumeWidget({super.key});

  @override
  State<DailyConsumeWidget> createState() => _DailyConsumeWidgetState();
}

class _DailyConsumeWidgetState extends State<DailyConsumeWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: backgroundColor2,
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 20, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        color: backgroundColor2, shape: BoxShape.circle),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '1291',
                            style: GoogleFonts.lato(
                                color: tipo, fontWeight: FontWeight.w900),
                          ),
                          Text(
                            'Eat',
                            style: GoogleFonts.lato(color: tipo),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 90,
                      width: 90,
                      child: Transform.rotate(
                        angle: -0.75 * 3.14,
                        child: CircularProgressIndicator(
                          value: 1 * 0.75,
                          strokeWidth: 8,
                          color: primaryColor,
                          backgroundColor: backgroundColor2,
                        ),
                      )),
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        color: backgroundColor2, shape: BoxShape.circle),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '2000',
                            style: GoogleFonts.lato(
                                color: tipo, fontWeight: FontWeight.w900),
                          ),
                          Text(
                            'Restante',
                            style: GoogleFonts.lato(color: tipo),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConsumeWidget(
                    title: 'Glucides',
                    expected: 254,
                    realised: 200,
                  ),
                  ConsumeWidget(
                    title: 'Protéines',
                    expected: 103,
                    realised: 35,
                  ),
                  ConsumeWidget(
                    title: 'Lipides',
                    expected: 68,
                    realised: 32,
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class ConsumeWidget extends StatelessWidget {
  final String title;
  final int expected;
  final int realised;
  const ConsumeWidget(
      {required this.expected,
      required this.realised,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        title,
        style: GoogleFonts.lato(
          color: tipo,
          fontWeight: FontWeight.w500,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 5,
          width: 70,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(500)),
            child: LinearProgressIndicator(
              value: realised / expected,
              backgroundColor: Colors.grey[300],
              color: primaryColor,
            ),
          ),
        ),
      ),
      Text(
        '$realised/$expected g',
        style: GoogleFonts.lato(color: tipo, fontWeight: FontWeight.w500),
      ),
    ]);
  }
}
