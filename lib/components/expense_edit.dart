import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ExpenseEdit extends StatefulWidget {
  final double? initialValue;
  final String? initialDescription;
  final IconData? floatingActionButtonIcon;
  final void Function()? onFloatingActionButtonPressed;
  final void Function({
    required double value,
    required String? description,
  }) onSubmit;

  const ExpenseEdit(
      {super.key,
      this.floatingActionButtonIcon,
      this.onFloatingActionButtonPressed,
      this.initialValue,
      this.initialDescription,
      required this.onSubmit});

  @override
  State<ExpenseEdit> createState() => _ExpenseEditState();
}

class _ExpenseEditState extends State<ExpenseEdit> {
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isTappedDown = false;

  @override
  void initState() {
    priceController.text = widget.initialValue?.toString() ?? "";
    descriptionController.text = widget.initialDescription ?? "";

    super.initState();
  }

  void onSubmit() {
    final value = double.tryParse(priceController.text.trim()) ?? 0.0;
    final description = descriptionController.text.trim();

    if (value == 0) {
      Get.snackbar(
        "Nope!",
        "Non puoi creare una spesa a zero",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.15),
      );
      return;
    }

    widget.onSubmit(
      description: description.isEmpty ? null : description,
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: InkWell(
        onHighlightChanged: (change) => setState(() => isTappedDown = change),
        splashColor: Colors.green.shade100,
        focusColor: Colors.transparent,
        highlightColor: Colors.green.shade400,
        onLongPress: onSubmit,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputPrice(),
            inputDescription(),
          ],
        ),
      ),
      floatingActionButton: widget.floatingActionButtonIcon == null
          ? null
          : FloatingActionButton(
              onPressed: widget.onFloatingActionButtonPressed,
              backgroundColor: Colors.green.shade200,
              foregroundColor: Colors.green.shade900,
              child: Icon(widget.floatingActionButtonIcon),
            ),
    );
  }

  Widget inputPrice() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              "€",
              style: TextStyle(
                fontSize: 50,
                color: isTappedDown ? Colors.white : Colors.green.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 20),
          IntrinsicWidth(
            child: TextField(
              controller: priceController,
              style: TextStyle(
                fontSize: 50,
                color: isTappedDown ? Colors.white : Colors.green.shade700,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: "0.00",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: isTappedDown ? Colors.white : Colors.green.shade200,
                ),
              ),
            ),
          ),
        ],
      );

  Widget inputDescription() => IntrinsicWidth(
        child: TextField(
          controller: descriptionController,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: isTappedDown ? Colors.white : Colors.green.shade700,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: "Descrizione (opzionale)",
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.green.shade200,
            ),
          ),
        ),
      );
}
