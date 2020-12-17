import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  //double amountValueDouble;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7.0,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_val) => submitData(),
              /*onChanged: (value) {
                      titleInput = value;
                    },*/
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_val) => submitData(),
              /*onChanged: (value) {
                //amountValueDouble = double.parse(value);
                amountController = double.parse(value);

              },*/
            ),
            FlatButton(
              child: Text(
                'Add Transaction',
                //style: TextStyle(color: Colors.purpleAccent),
              ),
              textColor: Colors.purpleAccent,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
