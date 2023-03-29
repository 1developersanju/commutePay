import 'package:flutter/material.dart';

class WalletRechargeDialog extends StatefulWidget {
  @override
  _WalletRechargeDialogState createState() => _WalletRechargeDialogState();
}

class _WalletRechargeDialogState extends State<WalletRechargeDialog> {
  final TextEditingController amountController = TextEditingController();
  bool isPaymentProcessing = false;
  bool paymentSuccess = false;
  String selectedUpiApp = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter recharge amount',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Select UPI app',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedUpiApp = 'Google Pay';
                    });
                  },
                  child: Card(
                    color: selectedUpiApp == 'Google Pay'
                        ? Colors.blue
                        : Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Image.network(
                        'https://logowik.com/content/uploads/images/t_google-pay.jpg',
                        height: 50,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedUpiApp = 'Paytm';
                    });
                  },
                  child: Card(
                    color:
                        selectedUpiApp == 'Paytm' ? Colors.blue : Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Image.network(
                        'https://logowik.com/content/uploads/images/t_paytm8487.jpg',
                        height: 50,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedUpiApp = 'PhonePe';
                    });
                  },
                  child: Card(
                    color:
                        selectedUpiApp == 'PhonePe' ? Colors.blue : Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Image.network(
                        'https://logowik.com/content/uploads/images/t_phonepe3248.jpg',
                        height: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            isPaymentProcessing
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed:
                        selectedUpiApp == "" || amountController.text == ""
                            ? null
                            : () {
                                setState(() {
                                  isPaymentProcessing = true;
                                });
                                // TODO: Implement payment logic here
                                Future.delayed(Duration(seconds: 2), () {
                                  setState(() {
                                    isPaymentProcessing = false;
                                    paymentSuccess = true;
                                  });
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.pop(context);
                                  });
                                });
                              },
                    child: Text('Proceed'),
                  ),
            SizedBox(height: 8),
            paymentSuccess
                ? Text(
                    'Payment successful!',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
