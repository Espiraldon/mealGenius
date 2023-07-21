// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/widget/today_state_widget.dart';

import '../data/data.dart';
import '../models/content.dart';

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
        reicipe: monday,
      ),
      DayperWeekWidget(
        day: 'Tuesday',
        reicipe: tuesday,
      ),
      DayperWeekWidget(
        day: 'Wenesday',
        reicipe: wenesday,
      ),
      DayperWeekWidget(
        day: 'Thirsday',
        reicipe: thirsday,
      ),
      DayperWeekWidget(
        day: 'Friday',
        reicipe: friday,
      ),
      DayperWeekWidget(
        day: 'Saturday',
        reicipe: saturday,
      ),
      DayperWeekWidget(
        day: 'Sunday',
        reicipe: sunday,
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
  List<ReicipeContent>? reicipe;
  DayperWeekWidget({required this.reicipe, required this.day, super.key});

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
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: backgroundColor2,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: neutral, borderRadius: BorderRadius.circular(20)),
                child: MenuWidget(
                  reicipe: widget.reicipe,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
