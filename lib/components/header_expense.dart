import 'package:flutter/material.dart';

class HeaderExpense extends StatelessWidget {
  final double value;
  final String label;
  const HeaderExpense({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade300,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.green.shade200,
        ),
      ),
      child: Column(
        children: [
          Text(
            "€ ${value.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 9,
              color: Colors.green.shade100,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
