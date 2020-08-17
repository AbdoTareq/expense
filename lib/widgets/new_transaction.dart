import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleEditController = TextEditingController();
  final amountEditController = TextEditingController();

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
                print('dart_mess ${titleEditController.text}');
                print('dart_mess ${amountEditController.text}');
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
