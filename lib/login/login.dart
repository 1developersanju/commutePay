import 'package:bus_proj/home.dart';
import 'package:bus_proj/login/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _pinEditingController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? _verificationCode;

  @override
  void dispose() {
    _pinEditingController.dispose();
    super.dispose();
  }

  _verifyPhone(phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
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
            SizedBox(height: 50),
            Container(
              width: 300,
              child: TextFormField(
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
                      if (value.user != null) {
                        print("response value ${value.user}");
                        print(
                            "response value ${value.additionalUserInfo!.isNewUser}");
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        // prefs.setBool(
                        //     'isNewUser', value.credential.);
                        print("isNewUser ${prefs.getBool("isNewUser")}");

                        print("response value ${value.credential!.token}");

                        // Navigator.pushAndRemoveUntil(r
                        //     context,
                        //     MaterialPageRoute(builder: (context) => HomePage()),
                        //     (route) => false);
                      }
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
