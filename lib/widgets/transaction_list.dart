import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteFunction;

  TransactionList(this.transactions, this.deleteFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Text('No Transactions added yet!'),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 250,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
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
                    trailing: IconButton(
                        onPressed: () => deleteFunction(transactions[index].id),
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor),
                  ),
                );

                /*Card(
                  elevation: 3,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );*/
              },
            ),
    );
  }
}
