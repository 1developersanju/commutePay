import 'package:flutter/material.dart';

class BuySmartCardStepsPage extends StatefulWidget {
  @override
  _BuySmartCardStepsPageState createState() => _BuySmartCardStepsPageState();
}

class _BuySmartCardStepsPageState extends State<BuySmartCardStepsPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy a New Smart Card'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          setState(() {
            _currentStep += 1;
          });
        },
        onStepCancel: () {
          setState(() {
            _currentStep -= 1;
          });
        },
        steps: [
          Step(
            title: Text('Choose a Smart Card type'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select the type of Smart Card you want to buy:'),
                RadioListTile(
                  value: 'Regular',
                  groupValue: null,
                  onChanged: (value) {},
                  title: Text('Regular Smart Card'),
                ),
                RadioListTile(
                  value: 'Student',
                  groupValue: null,
                  onChanged: (value) {},
                  title: Text('Student Smart Card'),
                ),
              ],
            ),
          ),
          Step(
            title: Text('Provide your personal information'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Please enter your personal information:'),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                  ),
                ),
              ],
            ),
          ),
          Step(
            title: Text('Choose a payment method'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select the payment method you want to use:'),
                RadioListTile(
                  value: 'Credit Card',
                  groupValue: null,
                  onChanged: (value) {},
                  title: Text('Credit Card'),
                ),
                RadioListTile(
                  value: 'Debit Card',
                  groupValue: null,
                  onChanged: (value) {},
                  title: Text('Debit Card'),
                ),
                RadioListTile(
                  value: 'Net Banking',
                  groupValue: null,
                  onChanged: (value) {},
                  title: Text('Net Banking'),
                ),
                RadioListTile(
                  value: 'UPI',
                  groupValue: null,
                  onChanged: (value) {},
                  title: Text('UPI'),
                ),
              ],
            ),
          ),
          Step(
            title: Text('Confirm your purchase'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Please review your order details:'),
                SizedBox(height: 16),
                Text('Smart Card type: Regular'),
                SizedBox(height: 16),
                Text('Name: Sanjeev Vivekanandan'),
                SizedBox(height: 16),
                Text('Email: s4njeev.av@gmail.com'),
                SizedBox(height: 16),
                Text('Phone number: 9876543210'),
                SizedBox(height: 16),
                Text('Payment method: UPI'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
