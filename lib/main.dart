import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:productivity/firebase_options.dart';
import 'package:productivity/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  bool result = await InternetConnection().hasInternetAccess;
  print(result ? "Connected to the internet" : "No internet connection");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Productivity Boost',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        title: 'Productvity Boost',
      ),
    );
  }
}
