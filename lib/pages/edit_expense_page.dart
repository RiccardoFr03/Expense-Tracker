// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'package:expense_tracker/components/expense_edit.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/models/store_model.dart';

class EditExpensePage extends StatefulWidget {
  final ExpenseModel expenseModel;
  EditExpensePage(this.expenseModel, {super.key});

  static const route = "/expense/edit";

  @override
  State<EditExpensePage> createState() => _EditExpensePageState();
}

class _EditExpensePageState extends State<EditExpensePage> {
  void onSubmit({
    required double value,
    required String? description,
  }) {
    storeModel.value.editExpense(
      widget.expenseModel,
      value: value,
      description: description,
    );
    Navigator.pop(context);
  }

  void onDelete() {
    storeModel.value.deleteExpense(widget.expenseModel);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ExpenseEdit(
      floatingActionButtonIcon: Icons.delete,
      onFloatingActionButtonPressed: onDelete,
      initialValue: widget.expenseModel.value,
      initialDescription: widget.expenseModel.description,
      onSubmit: onSubmit,
    );
  }
}
