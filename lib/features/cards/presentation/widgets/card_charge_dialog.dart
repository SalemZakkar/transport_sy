import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transport_sy/features/core/presentation/widget/bloc/user_builder.dart';

class CardChargeDialog extends StatefulWidget {
  const CardChargeDialog({super.key, required this.onChanged});

  final void Function(int) onChanged;

  @override
  State<CardChargeDialog> createState() => _CardChargeDialogState();
}

class _CardChargeDialogState extends State<CardChargeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UserBuilder(
      builder: (user) => AlertDialog(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 32,
        ),
        insetPadding: EdgeInsets.zero,
        title: const Text("شحن البطاقة من المحفظة", textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).cardColor,
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "رصيد المحفظة المتوفر: ${user.balance.toString().formatNum().addSyp}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: "قيمة الشحن",
                    hintText: "أدخل المبلغ",
                    prefixIcon: Icon(Icons.money),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "هذا الحقل مطلوب";
                    }
                    final amount = int.tryParse(value) ?? 0;
                    if (amount <= 0) {
                      return "يجب أن يكون المبلغ أكبر من 0";
                    }
                    if (amount > user.balance) {
                      return "المبلغ يتجاوز رصيد المحفظة المتوفر";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("إلغاء"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onChanged(int.parse(_amountController.text));
                Navigator.of(context).pop();
              }
            },
            child: const Text("شحن"),
          ),
        ],
      ),
    );
  }
}
