import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

import 'new_transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'New shoes', amount: 66, date: DateTime.now()),
    Transaction(id: 't2', title: 'New Bag', amount: 55, date: DateTime.now()),
  ];

  _addNewTransaction(String title, double amount) {
    setState(() {
      transactions.add(Transaction(
          title: title,
          amount: amount,
          id: DateTime.now().toString(),
          date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          addNewTransaction: _addNewTransaction,
        ),
        TransactionList(
          transactions: transactions,
        ),
      ],
    );
  }
}
