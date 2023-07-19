import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/widget/today_state_widget.dart';

import '../data/data.dart';

class Week extends StatefulWidget {
  const Week({super.key});

  @override
  State<Week> createState() => _WeekState();
}

class _WeekState extends State<Week> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      DayperWeekWidget(
        day: 'Monday',
      ),
      DayperWeekWidget(
        day: 'Tuesday',
      ),
      DayperWeekWidget(
        day: 'Wenesday',
      ),
      DayperWeekWidget(
        day: 'Thirsday',
      ),
      DayperWeekWidget(
        day: 'Friday',
      ),
      DayperWeekWidget(
        day: 'Saturday',
      ),
      DayperWeekWidget(
        day: 'Sunday',
      ),
    ];
    return SafeArea(
      child: CarouselSlider(
        options: CarouselOptions(height: MediaQuery.of(context).size.height),
        items: [0, 1, 2, 3, 4, 5, 6].map((e) {
          return Builder(builder: (BuildContext context) {
            return widgets[e];
          });
        }).toList(),
      ),
    );
  }
}

class DayperWeekWidget extends StatefulWidget {
  final String day;
  const DayperWeekWidget({required this.day, super.key});

  @override
  State<DayperWeekWidget> createState() => _DayperWeekWidgetState();
}

class _DayperWeekWidgetState extends State<DayperWeekWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            widget.day,
            style: GoogleFonts.lato(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: backgroundColor2,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
