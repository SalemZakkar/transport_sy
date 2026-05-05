import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transport_sy/features/cards/domain/entity/card.dart';
import 'package:transport_sy/features/cards/presentation/cubit/my_cards_cubit.dart';
import 'package:transport_sy/injection.dart';

class CardDepositDialog extends StatefulWidget {
  const CardDepositDialog({super.key, required this.onChanged});

  final void Function(int) onChanged;

  @override
  State<CardDepositDialog> createState() => _CardDepositDialogState();
}

class _CardDepositDialogState extends State<CardDepositDialog> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // void _onDeposit() {
  //   if (_formKey.currentState!.validate()) {
  //     final number = _numberController.text;
  //     final amount = int.tryParse(_amountController.text) ?? 0;
  //
  //     final cardIndex = cards.indexWhere((e) => e.number == number);
  //     if (cardIndex != -1) {
  //       getIt<MyCardsCubit>().deposit(cards[cardIndex].id, amount);
  //       context.pop(true);
  //     } else {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(const SnackBar(content: Text("رقم البطاقة غير موجود")));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      constraints: BoxConstraints(
        // maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width - 32,
      ),
      insetPadding: EdgeInsets.zero,
      title: const Text("إيداع رصيد", textAlign: TextAlign.center),
      backgroundColor: Theme.of(context).cardColor,
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: "رقم البطاقة",
                  hintText: "أدخل 10 أرقام",
                  prefixIcon: Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: MultiValidator([
                  RequiredValidator(errorText: "هذا الحقل مطلوب"),
                  MinLengthValidator(
                    10,
                    errorText: "رقم البطاقة يجب أن يكون 10 أرقام",
                  ),
                ]).call,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: "قيمة الإيداع",
                  hintText: "أدخل المبلغ",
                  prefixIcon: Icon(Icons.money),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: RequiredValidator(errorText: "هذا الحقل مطلوب").call,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text("إلغاء")),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onChanged(
                int.parse(_amountController.text),
                // _numberController.text,
              );
              context.pop();
            }
          },
          child: const Text("إيداع"),
        ),
      ],
    );
  }
}
