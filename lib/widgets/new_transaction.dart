import 'package:flutter/material.dart';

//*make this class stateful even we won't use setstate() as input fields were cleared */
class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({@required this.addNewTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleEditController = TextEditingController();

  final amountEditController = TextEditingController();

  submitData() {
    final title = titleEditController.text;
    final amount = double.parse(amountEditController.text);
    if (title.isEmpty || amount <= 0) {
      return;
    }
    widget.addNewTransaction(title, amount);
    Navigator.of(context).pop();
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
