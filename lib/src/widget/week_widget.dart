// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealgenius/src/widget/money_widget.dart';
import 'package:mealgenius/src/widget/today_state_widget.dart';

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
        index: 0,
      ),
      DayperWeekWidget(
        day: 'Tuesday',
        reicipe: tuesday,
        index: 1,
      ),
      DayperWeekWidget(
        day: 'Wenesday',
        reicipe: wenesday,
        index: 2,
      ),
      DayperWeekWidget(
        day: 'Thirsday',
        reicipe: thirsday,
        index: 3,
      ),
      DayperWeekWidget(
        day: 'Friday',
        reicipe: friday,
        index: 4,
      ),
      DayperWeekWidget(
        day: 'Saturday',
        reicipe: saturday,
        index: 5,
      ),
      DayperWeekWidget(day: 'Sunday', reicipe: sunday, index: 6),
    ];
    return SafeArea(
      child: CarouselSlider.builder(
        itemCount: widgets.length,
        options: CarouselOptions(
          height: 900,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          viewportFraction: 0.95,
          autoPlay: false,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return widgets[index];
        },
      ),
    );
  }
}

class DayperWeekWidget extends StatefulWidget {
  final String day;
  List<ReicipeContent>? reicipe;
  int index;
  DayperWeekWidget(
      {required this.index,
      required this.reicipe,
      required this.day,
      super.key});

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
            style: GoogleFonts.lato(fontSize: 20, color: tipo),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 520,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Column(
                children: [
                  WeekMoneySpentWidget(
                    currentday: widget.index,
                    dayshow: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 260,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: neutral,
                        borderRadius: BorderRadius.circular(20)),
                    child: MenuWidget(
                      reicipe: widget.reicipe,
                      backgroundcolor: neutral,
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
