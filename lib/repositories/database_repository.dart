import 'package:expense_tracker/models/expense_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseRepository {
  final Database database;

  DatabaseRepository(this.database);

  static Future<DatabaseRepository> newConnection() async {
    final databasesPath = await getDatabasesPath();
    final databasePath = path.join(databasesPath, "expense_tracker.db");

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (Database db, int version) async {
        db.execute("""
        CREATE TABLE expenses(
          uuid TEXT PRIMARY KEY,
          value REAL NOT NULL,
          description TEXT,
          createdOn INTEGER NOT NULL
        );

      """);
      },
    );

    return DatabaseRepository(database);
  }

  Future<List<ExpenseModel>> allExpenses() async {
    final rows = await database.query("expenses");
    return rows.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  void createExpense(ExpenseModel expenseModel) {
    database.insert("expenses", expenseModel.toMap());
  }

  void updateExpense(ExpenseModel expenseModel) {
    database.update(
      "expenses",
      expenseModel.toMap(),
      where: "uuid = ?",
      whereArgs: [expenseModel.uuid],
    );
  }

  void deleteExpense(ExpenseModel expenseModel) {
    database.delete(
      "expenses",
      where: "uuid = ?",
      whereArgs: [expenseModel.uuid],
    );
  }
}
