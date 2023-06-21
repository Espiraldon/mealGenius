import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 125,
          title: const Text('FriendMatch'),
          backgroundColor: Colors.cyan,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 30),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Question ?'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => print("oui"),
                  child: const Text('OUI'),
                ),
                ElevatedButton(
                  onPressed: () => print("non"),
                  child: const Text('NON'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
