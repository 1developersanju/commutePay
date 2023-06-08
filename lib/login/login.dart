import 'dart:async';

import 'package:bus_proj/home.dart';
import 'package:bus_proj/login/authCheck.dart';
import 'package:bus_proj/login/register.dart';
import 'package:bus_proj/userData/getUserData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool readOnly = false;
  final TextEditingController _pinEditingController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? _verificationCode;
  bool _showTimer = false;
  late Timer _timer;
  int _timerSeconds = 60;
    late String _errorMessage;


  @override
  void dispose() {
    _pinEditingController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timerSeconds < 1) {
          _showTimer = false;
          _timerSeconds = 60;
          _timer.cancel();
        } else {
          _timerSeconds -= 1;
        }
      });
    });
  }

  _verifyPhone(phone) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91${phone}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => GetUserData()),
                    (route) => false);
              }
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e.message);
          },
          codeSent: (String? verficationID, int? resendToken) {
            print('Verification code sent to phone number');
            setState(() {
              _showTimer = true;
            });
            _startTimer();
            setState(() {
              _verificationCode = verficationID;
            });
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            setState(() {
              _verificationCode = verificationID;
            });
            print("timeout");
          },
          timeout: Duration(seconds: _timerSeconds));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'We have blocked all requests from this device due to unusual activity. Try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to CommutePay',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            _showTimer ? Text("$_timerSeconds") : SizedBox(),

            SizedBox(height: 50),
            Container(
              width: 300,
              child: TextFormField(
                readOnly: readOnly,
                controller: phoneController,
                autofocus: true,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+91'),
                  ),
                  hintText: 'Enter your mobile number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_android),
                ),
                onEditingComplete: () {
                  _verifyPhone(phoneController.text);
                  setState(() {
                    readOnly = true;
                  });
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 300,
              child: PinInputTextField(
                enableInteractiveSelection: true,
                pinLength: 6,
                decoration: BoxLooseDecoration(
                  strokeColorBuilder: PinListenColorBuilder(
                    Colors.black,
                    Theme.of(context).focusColor,
                  ),
                ),
                controller: _pinEditingController,
                autoFocus: true,
                textInputAction: TextInputAction.done,
                onSubmit: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode!, smsCode: pin))
                        .then((value) async {
                      print("pin $pin");

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetUserData()),
                          (route) => false);
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }

                  // widget.onCompleted(pin);
                },
              ),
            ),
            const SizedBox(
              height: 20,
              width: 40,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     _verifyPhone(phoneController
            //         .text); // TODO: implement login functionality
            //   },
            //   child: Text('Next'),
            // ),
          ],
        ),
      ),
    );
  }
}
