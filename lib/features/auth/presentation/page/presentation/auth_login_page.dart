import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_verify_otp_page.dart';
import 'package:transport_sy/features/core/presentation/widget/fields/phone_number_text_field.dart';

class AuthLoginPage extends StatefulWidget {
  static String path = "/AuthLoginPage";

  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final key = GlobalKey<FormState>();
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 4),
      body: Form(
        key: key,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          // alignment: Alignment.center,
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              // spacing: 16,
              children: [
                32.height(),
                HeaderText(title: "تسجيل الدخول"),
                8.height(),
                Text("أدخل رقم هاتفك من اجل التحقق وتسجيل الدخول"),
                16.height(),
                PhoneNumberTextField(
                  onChanged: (v) {
                    phone = v;
                  },
                ),
                16.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        // getIt<AuthCubit>().login(phone);
                        context.push(AuthVerifyOtpPage.path, extra: phone);
                      }
                    },
                    child: Text("التحقق"),
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
