import 'package:flutter/material.dart';
import 'package:happly/src/screens/guestscreen.dart';

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FriendMatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GuestScreeen(),
    );
  }
}
