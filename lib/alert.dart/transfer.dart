import 'package:bus_proj/helpers/db.dart';
import 'package:flutter/material.dart';

class TransferMoneyDialog extends StatefulWidget {
  int balance;
  String phone;
  TransferMoneyDialog({required this.balance, required this.phone});
  @override
  _TransferMoneyDialogState createState() => _TransferMoneyDialogState();
}

class _TransferMoneyDialogState extends State<TransferMoneyDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController recipientAddressController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  String _amount = "";
  String _recipientWalletAddress = "";
  String _notes = "";

  _submitForm() {
    print("test amount $_amount");
    print(_notes);

    // if (_formKey.currentState!.validate()) {
    //   print(_amount);
    //   print(_notes);
    //   // Send transfer request to server or API
    //   // Display confirmation message to user
    //   // Navigate to another page in the app

    //   Navigator.pop(context); // Close the dialog box
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Transfer Money'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
                onSaved: (value) {
                  print("value $value");
                  _amount = value!;
                },
              ),
              TextFormField(
                controller: recipientAddressController,
                keyboardType: TextInputType.phone,
                decoration:
                    InputDecoration(labelText: 'Recipient Wallet Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a wallet address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _recipientWalletAddress = value!;
                },
              ),
              TextFormField(
                controller: messageController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Notes (optional)'),
                onSaved: (value) {
                  _notes = value!;
                },
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context); // Close the dialog box
          },
        ),
        ElevatedButton(
          child: Text('Transfer'),
          onPressed: () {
            print(_amount == '' ? "empty" : _amount);
            print(_recipientWalletAddress);
            transfer({
              "transferredAmount": amountController.text,
              "recipientNumber": "+91${recipientAddressController.text}"
            }).then((value) {
              updateWalletOnTransfer({
                "amount": widget.balance - int.parse(amountController.text),
                "walletId": widget.phone
              });
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
  }
}
