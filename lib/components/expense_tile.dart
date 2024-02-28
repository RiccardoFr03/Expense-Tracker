import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/pages/edit_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseModel expenseModel;

  const ExpenseTile({super.key, required this.expenseModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(
        context,
        EditExpensePage.route,
        arguments: expenseModel,
      ),
      leading: AspectRatio(
        aspectRatio: 5 / 3,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              "€ ${expenseModel.value.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.green.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        DateFormat("dd MMMM").format(expenseModel.createdOn),
      ),
      subtitle: Text(expenseModel.description ?? "-"),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey.shade300,
      ),
    );
  }
}
