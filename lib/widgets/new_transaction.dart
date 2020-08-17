import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleEditController = TextEditingController();
  final amountEditController = TextEditingController();
  final Function addNewTransaction;

  NewTransaction({@required this.addNewTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleEditController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: amountEditController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            FlatButton(
              onPressed: () {
                addNewTransaction(titleEditController.text,
                    double.parse(amountEditController.text));
              },
              textColor: Colors.purple,
              child: Text('Add transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
