import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:expenses/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AdaptativeTextField(
                    label: 'Título', 
                    textController: _titleController, 
                    onSubmitted: _submitForm
                  ),
                  AdaptativeTextField(
                    label: 'Valor (R\$)', 
                    textController: _valueController, 
                    onSubmitted: _submitForm,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                  AdaptativeDatePicker(
                    selectedDate: _selectedDate, 
                    onDateChanged: (newDate) {
                      setState(() {
                        if(newDate != null) {
                          _selectedDate = newDate;
                        }
                      });
                    }
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AdaptativeButton(
                        label: 'Nova Transação', 
                        onPressed: _submitForm
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}