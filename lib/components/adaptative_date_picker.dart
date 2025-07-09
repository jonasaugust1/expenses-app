import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  AdaptativeDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChanged
  });

  final DateTime selectedDate;
  final Function(DateTime?) onDateChanged;

  final DateTime currentDate = DateTime.now();

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context, 
      firstDate: currentDate.subtract(Duration(days: 365)), 
      lastDate: currentDate
    ).then((pickedDate) {
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
    ? 
    SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: currentDate,
        minimumDate: currentDate.subtract(Duration(days: 365)),
        maximumDate: currentDate,
        onDateTimeChanged: onDateChanged,
      ),
    )
    :
    SizedBox(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Data da transação: ${DateFormat('dd/MM/y').format(selectedDate)}'
            ),
          ),
          TextButton(
            onPressed: () => _showDatePicker(context), 
            child: Text(
              'Selecionar data',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold
              ),
            )
          )
        ],
      ),
    );
  }
}