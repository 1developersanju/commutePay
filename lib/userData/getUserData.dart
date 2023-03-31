import 'package:bus_proj/helpers/db.dart';
import 'package:bus_proj/home.dart';
import 'package:bus_proj/login/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserData extends StatefulWidget {
  @override
  State<GetUserData> createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
  final TextEditingController _pinEditingController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  String? _verificationCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'User Info',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 300,
              child: TextFormField(
                controller: userNameController,
                autofocus: true,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'User Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_2_rounded),
                ),
                onEditingComplete: () {},
              ),
            ),
            SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 20,
              width: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                var userData = {"userName": userNameController.text,"phone":currentuser!.phoneNumber};
                await db.collection("uid").add(userData);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
