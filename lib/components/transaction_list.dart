import 'package:expenses/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key, 
    required this.transactions,
    required this.onRemove
  });

  final void Function(String) onRemove;

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? 
    LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(height: constraints.maxHeight * 0.05),
            Text(
              'Nenhuma transação cadastrada.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
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
    : 
    ListView.builder(
      shrinkWrap: true,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text('R\$${transaction.value}')
                ),
              ),
            ),
            title: Text(
              transaction.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              DateFormat('d MMM y').format(transaction.date)
            ),
            trailing: MediaQuery.of(context).size.width > 480 ?
            TextButton.icon(
              onPressed: () => onRemove(transaction.id), 
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error
              ),
              label: Text('Excluir'),
            )
            :
            IconButton(
              onPressed: () => onRemove(transaction.id), 
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
                semanticLabel: 'Excluir',
              )
            ) 
          ),
        );
      },
    );
  }
}