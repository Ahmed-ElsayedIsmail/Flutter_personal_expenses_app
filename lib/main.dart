import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.blue,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final amountcontroller = TextEditingController();

  final List<Transaction> _userTransactions = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        elevation: 7,
        builder: (_bCtx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () {
                    _startAddNewTransaction(context);
                  },
                )
              ],
            ),
          )
        : AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _startAddNewTransaction(context);
                },
              ),
            ],
            title: Text(
              'Personal Expenses',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
          );
//***** */

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

//***** */
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // if (isLandscape)
            if (isLandscape)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show Chart',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Switch.adaptive(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          })
                    ],
                  ),
                  _showChart
                      ? Container(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.7,
                          child: Chart(_recentTransactions),
                        )
                      : txListWidget,
                ],
              ),

            // if (!isLandscape)
            if (!isLandscape)
              Column(
                children: [
                  Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(_recentTransactions),
                  ),
                  txListWidget,
                ],
              ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Colors.blueGrey[800],
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                    child: Icon(
                      Icons.add,
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
