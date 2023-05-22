import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDayPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectDate = pickedDate;
        });
      },
    );
  }

  final textStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 7,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                //onChanged: (v) => titleInput = v,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 18,
                ),
                child: TextField(
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData,
                  controller: _amountController,
                  //onChanged: (v) => amountInput = v,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 50.0,
                  top: 0.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectDate == null
                            ? 'No Date Chosen!'
                            : 'Date:   ${DateFormat.yMd().format(_selectDate)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Colors.green[600],
                      child: Text(
                        'Choose date',
                        style: textStyle,
                      ),
                      onPressed: _presentDayPicker,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.green[600],
                  child: Text(
                    'Add Transaction',
                    style: textStyle,
                  ),
                  onPressed: _submitData,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
