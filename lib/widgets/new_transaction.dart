import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//*make this class stateful even we won't use set state() as input fields were cleared */
class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({@required this.addNewTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleEditController = TextEditingController();
  final _amountEditController = TextEditingController();
  DateTime _selectedDate;

  _submitData() {
    if (_amountEditController.text == null) {
      return;
    }
    final title = _titleEditController.text;
    final amount = double.parse(_amountEditController.text);
    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
              controller: _titleEditController,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              controller: _amountEditController,
              decoration: InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) => _submitData(),
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen!'
                          : 'Picked date ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      'Choose date',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              textColor: Theme.of(context).buttonColor,
              color: Theme.of(context).primaryColor,
              child: Text('Add transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
