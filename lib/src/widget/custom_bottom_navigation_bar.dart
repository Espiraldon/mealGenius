import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 8, 25, 54),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: const Row(
            children: [
              SizedBox(
                  height: 36,
                  width: 36,
                  child: RiveAnimation.asset(
                    "lib/img/RivaAssets/1298-2487-animated-icon-set-1-color.riv",
                    artboard: "HOME",
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
