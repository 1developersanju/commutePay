import 'package:bus_proj/Wallet/buyingSteps.dart';
import 'package:flutter/material.dart';

class BuySmartCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy a New Smart Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Get a new Smart Card by following these simple steps:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16),
            _buildStep(1, 'Choose a Smart Card type'),
            _buildStep(2, 'Provide your personal information'),
            _buildStep(3, 'Choose a payment method'),
            _buildStep(4, 'Confirm your purchase'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BuySmartCardStepsPage()));
                // TODO: Implement Smart Card purchase flow
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number.',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
