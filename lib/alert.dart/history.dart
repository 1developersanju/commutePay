import 'package:flutter/material.dart';

class WalletHistoryPage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      transactionType: TransactionType.travel,
      startLocation: 'Gandhipuram',
      endLocation: 'Ramanathapuram',
      amount: 25.0,
      date: '16 Oct, 2021',
    ),
    Transaction(
      transactionType: TransactionType.recharge,
      amount: 100.0,
      date: '15 Oct, 2021',
    ),
    Transaction(
      transactionType: TransactionType.transfer,
      recipient: '7010710221',
      amount: 50.0,
      date: '14 Oct, 2021',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black45,
        title: Text('Wallet History'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: getIconForTransactionType(transaction.transactionType),
                title: getTitleForTransactionType(transaction.transactionType),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getSubtitleForTransaction(transaction),
                    Text(transaction.date)
                  ],
                ),
                trailing: Text(
                  '₹${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Icon getIconForTransactionType(TransactionType transactionType) {
    switch (transactionType) {
      case TransactionType.travel:
        return Icon(Icons.directions_bus);
      case TransactionType.recharge:
        return Icon(Icons.credit_card);
      case TransactionType.transfer:
        return Icon(Icons.send);
      default:
        return Icon(Icons.help_outline);
    }
  }

  Text getTitleForTransactionType(TransactionType transactionType) {
    switch (transactionType) {
      case TransactionType.travel:
        return Text('Travel transaction');
      case TransactionType.recharge:
        return Text('Recharge transaction');
      case TransactionType.transfer:
        return Text('Transfer transaction');
      default:
        return Text('Unknown transaction');
    }
  }

  Text getSubtitleForTransaction(Transaction transaction) {
    switch (transaction.transactionType) {
      case TransactionType.travel:
        return Text(
          '${transaction.startLocation} - ${transaction.endLocation}',
        );
      case TransactionType.recharge:
        return Text('Recharge');
      case TransactionType.transfer:
        return Text('To ${transaction.recipient}');
      default:
        return Text('');
    }
  }
}

class Transaction {
  final TransactionType transactionType;
  final String startLocation;
  final String endLocation;
  final String recipient;
  final double amount;
  final String date;

  Transaction({
    required this.transactionType,
    required this.date,
    this.startLocation = "",
    this.endLocation = "",
    this.recipient = "",
    this.amount = 0,
  });
}

enum TransactionType {
  travel,
  recharge,
  transfer,
}
