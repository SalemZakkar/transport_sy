import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/injection.dart';

class AuthVerifyOtpPage extends StatefulWidget {
  final String phone;
  static String path = "/AuthVerifyOtpPage";

  const AuthVerifyOtpPage({super.key, required this.phone});

  @override
  State<AuthVerifyOtpPage> createState() => _AuthVerifyOtpPageState();
}

class _AuthVerifyOtpPageState extends State<AuthVerifyOtpPage> {
  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 4),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height(),
                HeaderText(title: "التحقق"),
                8.height(),
                Text("أدخل رمز التحقق المكون من 6 ارقام"),
                16.height(),
                PinEntryTextField(
                  fields: 6,
                  onSubmit: (v) {
                    getIt<AuthCubit>().login();
                  },
                ),
                16.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        getIt<AuthCubit>().login();
                      }
                    },
                    child: Text(context.coreTranslations.continuE),
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
