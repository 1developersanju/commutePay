import 'package:flutter/material.dart';

class AddSmartCardDialog extends StatefulWidget {
  @override
  _AddSmartCardDialogState createState() => _AddSmartCardDialogState();
}

class _AddSmartCardDialogState extends State<AddSmartCardDialog> {
  final _formKey = GlobalKey<FormState>();
  final _smartCardIds = <String>[];
  String _newSmartCardId = "";
  final TextEditingController cardController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _smartCardIds.add(_newSmartCardId);
        _newSmartCardId = "";
      });
      cardController.clear();
    }
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Smart Cards'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure you want to add these Smart Cards to your Wallet?'),
                SizedBox(height: 16),
                Text('Smart Cards to be added:'),
                SizedBox(height: 8),
                ..._smartCardIds.map(
                  (smartCardId) => Text('- $smartCardId'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                // Add Smart Cards to Wallet
                Navigator.of(context).pop();
                Navigator.of(context).pop(_smartCardIds);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Smart Card'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add a new smart card by entering its unique ID:'),
            SizedBox(height: 16),
            TextFormField(
              controller: cardController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Smart Card ID',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a Smart Card ID';
                }
                return null;
              },
              onSaved: (value) {
                _newSmartCardId = value!;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Add Smart Card'),
            ),
            SizedBox(height: 16),
            Text('Smart Cards in Wallet:'),
            SizedBox(height: 8),
            ..._smartCardIds.map(
              (smartCardId) => Text('- $smartCardId'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _smartCardIds.isEmpty
              ? null
              : () {
                  // Show confirmation dialog
                  _showConfirmationDialog(context);
                },
          child: Text('Save'),
        ),
      ],
    );
  }
}

