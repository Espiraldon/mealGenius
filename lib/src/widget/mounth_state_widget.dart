import 'package:flutter/material.dart';

import '../data/data.dart';

class Mounth extends StatefulWidget {
  const Mounth({super.key});

  @override
  State<Mounth> createState() => _MounthState();
}

class _MounthState extends State<Mounth> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15),
          child: Column(children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: positive,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}