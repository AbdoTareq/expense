import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleEditController = TextEditingController();
  final amountEditController = TextEditingController();
  final Function addNewTransaction;

  NewTransaction({@required this.addNewTransaction});

  submitData() {
    final title = titleEditController.text;
    final amount = double.parse(amountEditController.text);
    if (title.isEmpty || amount <= 0) {
      return;
    }
    addNewTransaction(title, amount);
  }

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
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              controller: amountEditController,
              decoration: InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
            ),
            FlatButton(
              onPressed: submitData,
              textColor: Colors.purple,
              child: Text('Add transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
