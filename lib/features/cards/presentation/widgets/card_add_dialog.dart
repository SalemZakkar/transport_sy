import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transport_sy/routes/routes.dart';

class CardAddDialog extends StatefulWidget {
  final void Function(String) onChanged;

  const CardAddDialog({super.key, required this.onChanged});

  @override
  State<CardAddDialog> createState() => _CardAddDialogState();
}

class _CardAddDialogState extends State<CardAddDialog> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _onAdd() {
    if (_formKey.currentState!.validate()) {
      AppRoutes.rootNavigatorKey.currentContext?.pop();
      widget.onChanged(_numberController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width - 32,
      ),
      title: const Text("إضافة بطاقة جديدة", textAlign: TextAlign.center),
      backgroundColor: Theme.of(context).cardColor,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _numberController,
              decoration: const InputDecoration(
                labelText: "رقم البطاقة",
                hintText: "أدخل 8 أرقام",
                prefixIcon: Icon(Icons.credit_card),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],
              validator: MultiValidator([
                RequiredValidator(errorText: "هذا الحقل مطلوب"),
                MinLengthValidator(8, errorText: "يجب إدخال 8 أرقام"),
              ]).call,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text("إلغاء")),
        ElevatedButton(onPressed: _onAdd, child: const Text("إضافة")),
      ],
    );
  }
}
