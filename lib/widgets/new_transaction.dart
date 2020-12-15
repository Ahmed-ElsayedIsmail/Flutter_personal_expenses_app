import 'package:flutter/material.dart';
import '../widgets/user_transactions.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);

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
              /*onChanged: (value) {
                      titleInput = value;
                    },*/
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              /*onChanged: (value) {
                      amountInput = value;
                    },*/
            ),
            FlatButton(
              child: Text(
                'Add Transaction',
                //style: TextStyle(color: Colors.purpleAccent),
              ),
              textColor: Colors.purpleAccent,
              onPressed: addTx(
                titleController.text,
                double.parse(amountController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
