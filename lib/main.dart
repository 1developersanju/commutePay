import 'package:bus_proj/helpers/test.dart';
import 'package:bus_proj/home.dart';
import 'package:bus_proj/login/login.dart';
import 'package:bus_proj/test/test_login.dart';
import 'package:bus_proj/userData/getUserData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var isNewUser = prefs.getBool("isNewUser");
  // print("isNewUser ${prefs.getBool("isNewUser")}");
  runApp(MyApp(
    isNewUser: true,
  ));
}

class MyApp extends StatelessWidget {
  bool isNewUser;
  MyApp({super.key, required this.isNewUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GetUserData());
    // isNewUser == true ? LoginPage() : const HomePage());
  }
}
