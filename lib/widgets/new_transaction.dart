import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  //double amountValueDouble;
  NewTransaction(this.addTx);

  void submitData() {
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    if (enterTitle.isEmpty || enterAmount <= 0) {
      return;
    }

    addTx(
      enterTitle,
      enterAmount,
    );
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
