import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/components/header_expense.dart';
import 'package:expense_tracker/models/store_model.dart';
import 'package:expense_tracker/pages/new_expense_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          header(),
          contentList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, NewExpensePage.route),
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Spesa"),
      ),
    );
  }

  Widget header() => Obx(
        () => Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          color: Colors.green.shade400,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Questo Mese".toUpperCase(),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.green.shade100,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "€ ${storeModel.value.totaleExpenseMonth.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.4,
                  ),
                  children: [
                    HeaderExpense(
                      value: storeModel.value.totalExpenseToday,
                      label: "Oggi",
                    ),
                    HeaderExpense(
                      value: storeModel.value.totaleExpenseWeek,
                      label: "Settimana",
                    ),
                    HeaderExpense(
                      value: storeModel.value.totaleExpenseYear,
                      label: "Anno",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
  Widget contentList() => Obx(
        () => Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -2),
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 0,
                )
              ],
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: storeModel.value.expenses.length,
              itemBuilder: (context, index) => ExpenseTile(
                expenseModel: storeModel.value.expenses[index],
              ),
              separatorBuilder: (context, index) => const Divider(
                height: 0,
                indent: 0,
                endIndent: 0,
                thickness: 0,
              ),
            ),
          ),
        ),
      );
}
