import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const PhoneNumberTextField({super.key, required this.onChanged});

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.ltr,
      validator: MultiValidator([
        RequiredValidator(
          errorText: context.coreTranslations.fieldRequiredMessage,
        ),
        LengthRangeValidator(min: 9, max: 10, errorText: "رقم الهاتف يجب ان يكون بين 9 ل 10 ارقام")
      ]).call,
      inputFormatters: [LengthLimitingTextInputFormatter(10)],
      decoration: InputDecoration(
        hintText: "رقم الهاتف",
        prefixIcon: SizedBox(width: 48, child: Icon(Icons.phone)),
        suffixIcon: Container(
          width: 56,
          alignment: Alignment.center,
          child: Text(
            "+963",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      keyboardType: TextInputType.phone,
      onChanged: (v) {
        String k = v.startsWith("0") ? v.substring(1, v.length) : v;
        widget.onChanged("+963$k");
      },
    );
  }
}
