import 'package:bus_proj/helpers/db.dart';
import 'package:flutter/material.dart';

class WalletRechargeDialog extends StatefulWidget {
  String phoneNo;
  int balance;
  bool cardPurchased;
  WalletRechargeDialog(
      {required this.phoneNo,
      required this.balance,
      required this.cardPurchased});
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
                    onPressed: selectedUpiApp == "" ||
                            amountController.text == ""
                        ? null
                        : widget.cardPurchased == true
                            ? () {
                                setState(() {
                                  isPaymentProcessing = true;
                                });
                                var balance = int.parse(amountController.text) +
                                    int.parse(widget.balance.toString());
                                // TODO: Implement payment logic here
                                Future.delayed(Duration(seconds: 2), () {
                                  setState(() {
                                    isPaymentProcessing = false;
                                    paymentSuccess = true;
                                  });
                                  print(balance is int);
                                  Future.delayed(Duration(seconds: 3), () {
                                    recharge({
                                      "phoneNumber": widget.phoneNo,
                                      "amount": balance,
                                      "upi": selectedUpiApp
                                    });
                                  });
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.pop(context);
                                  });
                                });
                              }
                            : () {
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.pop(context);
                                });
                              },
                    child: Text('Proceed'),
                  ),
            const SizedBox(height: 8),
            widget.cardPurchased == false
                ? const Text("Purchase a card")
                : paymentSuccess
                    ? const Text(
                        'Payment successful!',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
