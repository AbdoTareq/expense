import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

import 'models/transaction.dart';
import 'widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          textTheme: ThemeData.light().textTheme.copyWith(
                // title => headline6
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  // title => headline6
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactions = [
//    Transaction(title: "Phone", amount: 70, date: DateTime.now()),
//    Transaction(title: "Nj", amount: 70, date: DateTime.now()),
//    Transaction(title: "Ad", amount: 40, date: DateTime.now()),
//    Transaction(title: "Ad", amount: 40, date: DateTime.now()),
//    Transaction(title: "Ad", amount: 40, date: DateTime.now()),
//    Transaction(title: "Ad", amount: 40, date: DateTime.now()),
//    Transaction(title: "468", amount: 40, date: DateTime.now()),
//    Transaction(title: "adad", amount: 20, date: DateTime.now())
  ];

  bool _showChart = false;

  // this method is to get the last 7 days transactions through filtering by where keyword
  List<Transaction> get _recentTransactions {
    return userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addNewTransaction(String title, double amount, DateTime date) {
    setState(() {
      userTransactions.add(Transaction(
          title: title,
          amount: amount,
          id: DateTime.now().toString(),
          date: date));
    });
  }

  _deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere((element) => element.id == id);
    });
  }

  _startAddNewTransaction(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => NewTransaction(
              addNewTransaction: _addNewTransaction,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expense'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    final deviceSize = mediaQuery.size.height -
        appBar.preferredSize.height -
        // this is status bar height
        mediaQuery.padding.top;
    final txListWidget = Container(
      height: deviceSize * .7,
      child: TransactionList(
        transactions: userTransactions,
        deleteTransaction: _deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      }),
                ],
              ),
            if (!isLandScape)
              Container(
                height: deviceSize * .3,
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
              ),
            if (!isLandScape) txListWidget,
            if (isLandScape)
              _showChart
                  ? Container(
                      height: deviceSize * .7,
                      child: Chart(
                        recentTransactions: _recentTransactions,
                      ),
                    )
                  : txListWidget,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
