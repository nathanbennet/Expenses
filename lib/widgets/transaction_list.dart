import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final transaction;
  final deleteTx;
  TransactionList(this.transaction, this.deleteTx);

  final horizontal = 10.0;
  final vertical = 10.0;

  final text = 'No transactions added yet!';
  final image = 'assets/images/zzz.png';
  final deleteIcon = Icon(Icons.delete);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final themeTitle = Theme.of(context).textTheme.title;

    return Container(
      height: mediaQuery.size.height * 0.6,
      child: transaction.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      text,
                      style: themeTitle,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: vertical,
                            horizontal: horizontal,
                          ),
                          child: Text(
                            '\$${transaction[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.green[900],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            border: Border.all(
                              color: Colors.green,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(4),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              transaction[index].title,
                              style: themeTitle,
                            ),
                            Text(
                              DateFormat.yMMMMEEEEd()
                                  .format(transaction[index].date),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: mediaQuery.size.width > 500
                            ? FlatButton.icon(
                                icon: deleteIcon,
                                label: Text('delete'),
                                textColor: Colors.red,
                                onPressed: () =>
                                    deleteTx(transaction[index].id),
                              )
                            : IconButton(
                                icon: deleteIcon,
                                color: Colors.red,
                                iconSize: 25,
                                onPressed: () =>
                                    deleteTx(transaction[index].id),
                              ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
