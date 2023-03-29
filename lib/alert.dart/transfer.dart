import 'package:flutter/material.dart';

class TransferMoneyDialog extends StatefulWidget {
  @override
  _TransferMoneyDialogState createState() => _TransferMoneyDialogState();
}

class _TransferMoneyDialogState extends State<TransferMoneyDialog> {
  final _formKey = GlobalKey<FormState>();

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
                keyboardType: TextInputType.text,
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
            _submitForm();
          },
        ),
      ],
    );
  }
}
