import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = titleController.text;
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
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
    return SingleChildScrollView(
      child: Card(
        elevation: 7.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_val) => _submitData(),
                /*onChanged: (value) {
                        titleInput = value;
                      },*/
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_val) => _submitData(),
                /*onChanged: (value) {
                  //amountValueDouble = double.parse(value);
                  amountController = double.parse(value);

                },*/
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date Chosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            onPressed: _presentDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            onPressed: _presentDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontSize: 17),
                  //style: TextStyle(color: Colors.purpleAccent),
                ),
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
