import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/features/core/presentation/dialogs/dialog_util.dart';
import 'package:transport_sy/injection.dart';

class AuthLoginPage extends StatefulWidget {
  static String path = "/AuthLoginPage";

  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الدخول'),
      ),
      body: Form(
        key: key,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                TextFormField(
                  validator: RequiredValidator(
                    errorText: context.coreTranslations.fieldRequiredMessage,
                  ).call,
                  decoration: InputDecoration(hintText: "الايميل"),
                  controller: email,
                ),
                PasswordInputField(passwordController: password),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!key.currentState!.validate()) {
                        return;
                      }
                      var user = getIt<AuthCubit>().login(
                        email.text,
                        password.text,
                      );
                      if (user == null) {
                        DialogUtil(
                          context: context,
                        ).showErrorDialog(message: "الحساب او كلمة السر خاطئة");
                      }
                    },
                    child: Text("تسجيل الدخول"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
