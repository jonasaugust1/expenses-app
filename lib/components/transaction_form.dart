import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    super.key,
    required this.onSubmit
  });

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    
    if(title.isEmpty || value <= 0) return;

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context, 
      firstDate: DateTime.now().subtract(Duration(days: 365)), 
      lastDate: DateTime.now()
    ).then((pickedDate) {
      setState(() {
        if(pickedDate != null) {
          _selectedDate = pickedDate;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    onSubmitted: (_) => _submitForm(),
                    decoration: InputDecoration(
                      labelText: 'Título'
                    ),
                  ),
                  TextField(
                    controller: _valueController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => _submitForm(),
                    decoration: InputDecoration(
                      labelText: 'Valor (R\$)'
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Data da transação: ${DateFormat('dd/MM/y').format(_selectedDate)}'
                          ),
                        ),
                        TextButton(
                          onPressed: _showDatePicker, 
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          'Nova Transação'
                        ), 
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}