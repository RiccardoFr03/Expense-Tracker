import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/repositories/database_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

final storeModel = StoreModel().obs;

class StoreModel {
  List<ExpenseModel> expenses = [];

  Future<void> initialize() async {
    expenses = await GetIt.instance<DatabaseRepository>().allExpenses();
  }

  double get totalExpenseToday {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(
      now.year,
      now.month,
      now.day,
    );

    return expenses.where((expenseModel) {
      return expenseModel.createdOn.isAfter(firstDayOfMonth);
    }).fold(0.0, (acc, expenseModel) {
      return acc + expenseModel.value;
    });
  }

  double get totaleExpenseWeek {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday));

    return expenses.where((element) {
      return element.createdOn.isAfter(firstDayOfWeek);
    }).fold(0.0, (acc, element) {
      return acc + element.value;
    });
  }

  double get totaleExpenseMonth {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(
      now.year,
      now.month,
      0,
    );

    return expenses.where((element) {
      return element.createdOn.isAfter(firstDayOfMonth);
    }).fold(0.0, (acc, element) {
      return acc + element.value;
    });
  }

  double get totaleExpenseYear {
    final now = DateTime.now();
    final firstDayOfYear = DateTime(
      now.year,
      0,
      0,
    );

    return expenses.where((element) {
      return element.createdOn.isAfter(firstDayOfYear);
    }).fold(0.0, (acc, element) {
      return acc + element.value;
    });
  }

  void createExpense({
    required double value,
    required String? description,
  }) {
    final expense = ExpenseModel(
      uuid: const Uuid().v4(),
      value: value,
      description: description,
      createdOn: DateTime.now(),
    );

    expenses.insert(0, expense);
    GetIt.instance<DatabaseRepository>().createExpense(expense);
    storeModel.refresh();
  }

  void editExpense(
    ExpenseModel expenseModel, {
    required double value,
    required String? description,
  }) {
    expenseModel.value = value;
    expenseModel.description = description;
    GetIt.instance<DatabaseRepository>().updateExpense(expenseModel);
    storeModel.refresh();
  }

  void deleteExpense(ExpenseModel expenseModel) {
    expenses.remove(expenseModel);
    GetIt.instance<DatabaseRepository>().deleteExpense(expenseModel);
    storeModel.refresh();
  }
}
