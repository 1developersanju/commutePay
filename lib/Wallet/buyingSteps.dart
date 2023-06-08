import 'package:bus_proj/helpers/db.dart';
import 'package:bus_proj/providers/userDataProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuySmartCardStepsPage extends StatefulWidget {
  @override
  _BuySmartCardStepsPageState createState() => _BuySmartCardStepsPageState();
}

class _BuySmartCardStepsPageState extends State<BuySmartCardStepsPage> {
  int _currentStep = 0;

  String _smartCardType = "";
  String _name = "";
  String _email = "";
  String _phoneNumber = "";
  String _paymentMethod = "";

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    final phoneNumber = "${user.phoneNumber}";
    final firestoreStreamProvider =
        Provider.of<FirestoreStreamProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy a New Smart Card'),
      ),
      body: StreamBuilder(
        stream: firestoreStreamProvider.getUserDataStream(uid, phoneNumber),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            var username = data!["userName"];
            var phone = data["phone"];
            return Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                setState(() {
                  if (_currentStep < 3) {
                    _currentStep += 1;
                  } else {
                    addUserToFirestore({
                      "smartCardType": _smartCardType,
                      "name": username,
                      "email": _email,
                      "phoneNumber": phone,
                      "paymentMethod": _paymentMethod
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('adding user data to Firestore.'),
                          duration: Duration(seconds: 2)),
                    );

                    Navigator.pop(context);
                    // Purchase logic
                    // Navigate to purchase confirmation screen
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (_currentStep > 0) {
                    _currentStep -= 1;
                  } else {
                    // Navigate back to previous screen
                  }
                });
              },
              steps: [
                Step(
                  title: const Text('Choose a Smart Card type'),
                  isActive: _currentStep >= 0,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          'Select the type of Smart Card you want to buy:'),
                      RadioListTile(
                        value: 'Regular',
                        groupValue: _smartCardType,
                        onChanged: (value) {
                          setState(() {
                            _smartCardType = value!;
                          });
                        },
                        title: const Text('Regular Smart Card'),
                      ),
                      RadioListTile(
                        value: 'Student',
                        groupValue: _smartCardType,
                        onChanged: (value) {
                          setState(() {
                            _smartCardType = value!;
                          });
                        },
                        title: const Text('Student Smart Card'),
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Provide your personal information'),
                  isActive: _currentStep >= 1,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Please enter your personal information:'),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: username,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _name = username;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone number',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _phoneNumber = phone;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep >= 2,
                  title: const Text('Choose a payment method'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select the payment method you want to use:'),
                      RadioListTile(
                        value: 'Credit Card',
                        groupValue: _paymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _paymentMethod = value!;
                          });
                        },
                        title: const Text('Credit Card'),
                      ),
                      RadioListTile(
                        value: 'Debit Card',
                        groupValue: _paymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _paymentMethod = value!;
                          });
                        },
                        title: const Text('Debit Card'),
                      ),
                      RadioListTile(
                        value: 'Net Banking',
                        groupValue: _paymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _paymentMethod = value!;
                          });
                        },
                        title: const Text('Net Banking'),
                      ),
                      RadioListTile(
                        value: 'UPI',
                        groupValue: _paymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _paymentMethod = value!;
                          });
                        },
                        title: const Text('UPI'),
                      ),
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep == 3,
                  title: const Text('Confirm your purchase'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Please review your order details:'),
                      const SizedBox(height: 16),
                      Text('Smart Card type: $_smartCardType'),
                      const SizedBox(height: 16),
                      Text('Name: $username'),
                      const SizedBox(height: 16),
                      Text('Email: $_email'),
                      const SizedBox(height: 16),
                      Text('Phone number: $phone'),
                      const SizedBox(height: 16),
                      Text('Payment method: $_paymentMethod'),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            // Display error message
            return Text("Error: ${snapshot.error}");
          } else {
            // Display circular progress indicator
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
