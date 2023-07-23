import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/data.dart';

class DailyConsumeWidget extends StatefulWidget {
  const DailyConsumeWidget({super.key});

  @override
  State<DailyConsumeWidget> createState() => _DailyConsumeWidgetState();
}

class _DailyConsumeWidgetState extends State<DailyConsumeWidget> {
  int sum(List<String> k) {
    int sum = 0;
    for (int i = 0; i < 3; i++) sum += int.parse(k[i]);
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
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
                    height: 85,
                    width: 75,
                    decoration: BoxDecoration(
                        color: backgroundColor2, shape: BoxShape.circle),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${sum(todayReicipe!.where((element) => element.calories.runtimeType == String).map((e) => e.calories).toList())}',
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
                      height: 100,
                      width: 100,
                      child: Transform.rotate(
                        angle: -0.75 * 3.14,
                        child: CircularProgressIndicator(
                          value: sum(todayReicipe!
                                  .where((element) =>
                                      element.calories.runtimeType == String)
                                  .map((e) => e.calories)
                                  .toList()) /
                              2000 *
                              0.75,
                          strokeWidth: 8,
                          color: primaryColor,
                          backgroundColor: backgroundColor2,
                        ),
                      )),
                  Container(
                    height: 70,
                    width: 70,
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
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConsumeWidget(
                    title: 'Glucides',
                    expected: 254,
                    realised: sum(todayReicipe!
                        .where(
                            (element) => element.glucides.runtimeType == String)
                        .map((e) => e.glucides)
                        .toList()),
                  ),
                  ConsumeWidget(
                    title: 'Protéines',
                    expected: 103,
                    realised: sum(todayReicipe!
                        .where((element) =>
                            element.proteines.runtimeType == String)
                        .map((e) => e.proteines)
                        .toList()),
                  ),
                  ConsumeWidget(
                    title: 'Lipides',
                    expected: 120,
                    realised: sum(todayReicipe!
                        .where(
                            (element) => element.lipides.runtimeType == String)
                        .map((e) => e.lipides)
                        .toList()),
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
