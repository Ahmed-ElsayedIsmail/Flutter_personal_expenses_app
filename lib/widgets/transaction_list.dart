import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteFunction;

  TransactionList(this.transactions, this.deleteFunction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text('No Transactions added yet!'),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 13,
                margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey[600],
                    radius: 33,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: FittedBox(
                        child: Text(
                          '\$${transactions[index].amount}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          textColor: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteFunction(transactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'))
                      : IconButton(
                          onPressed: () =>
                              deleteFunction(transactions[index].id),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor),
                ),
              );
            },
          );
  }
}
