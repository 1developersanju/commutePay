import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestLogin extends StatefulWidget {
  const TestLogin({super.key});

  @override
  State<TestLogin> createState() => _TestLoginState();
}

class _TestLoginState extends State<TestLogin> {
  //final auth = FirebaseAuth.instance;
  bool loading = false;
  TextEditingController phoneNoControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test_Login'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          TextFormField(
            controller: phoneNoControler,
            decoration: const InputDecoration(hintText: '+91 123 4567 890'),
          ),
          SizedBox(
            height: 50,
          ),
          TextButton(onPressed: () {}, child: Text('Login'))
        ],
      ),
    );
  }
}
