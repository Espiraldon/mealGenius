import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealgenius/src/data/colors.dart';

class Dashboard extends StatefulWidget {
  final String ingredientnumber;
  final String expirenumber;
  final String reicipenumber;
  final Function(int) onchangedstep;
  final String shopnumber;
  const Dashboard(
      {this.expirenumber = '0',
      this.ingredientnumber = '0',
      this.reicipenumber = '0',
      this.shopnumber = '0',
      required this.onchangedstep,
      super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DashContainers(
              title: 'Ingredients',
              number: widget.ingredientnumber,
              onChangedStep: widget.onchangedstep,
              index: 1,
            ),
            DashContainers(
              title: 'Expiration',
              number: widget.expirenumber,
              ispositive: false,
              onChangedStep: widget.onchangedstep,
              index: 2,
            )
          ],
        ),
        Row(
          children: [
            DashContainers(
              title: 'Your reicipes',
              number: widget.reicipenumber,
              onChangedStep: widget.onchangedstep,
              index: 3,
            ),
            DashContainers(
              title: 'Shopping lists',
              number: widget.shopnumber,
              onChangedStep: widget.onchangedstep,
              index: 4,
            ),
          ],
        ),
      ],
    );
  }
}

class DashContainers extends StatefulWidget {
  final String title;
  final String number;
  final String image;
  final bool ispositive;
  final Function(int) onChangedStep;
  final int index;
  const DashContainers(
      {required this.title,
      required this.number,
      this.image = "",
      this.ispositive = true,
      required this.onChangedStep,
      required this.index,
      super.key});

  @override
  State<DashContainers> createState() => _DashContainersState();
}

class _DashContainersState extends State<DashContainers> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChangedStep(widget.index),
      child: Container(
        height: 110,
        width: 175,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(
          top: 35,
          left: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: neutral,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.number,
                  style: GoogleFonts.lato(
                      fontSize: 30, fontWeight: FontWeight.w900, color: tipo),
                ),
                const SizedBox(
                  width: 5,
                ),
                widget.ispositive
                    ? Icon(
                        Icons.arrow_circle_up_outlined,
                        color: positive,
                      )
                    : Icon(
                        Icons.arrow_circle_down_outlined,
                        color: negative,
                      ),
              ],
            ),
            Text(
              widget.title,
              style: GoogleFonts.lato(
                  fontSize: 15, fontWeight: FontWeight.w400, color: tipo),
            ),
          ],
        ),
      ),
    );
  }
}
