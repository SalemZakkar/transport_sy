import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/injection.dart';

class AuthUserCompletePage extends StatefulWidget {
  static String path = "/AuthUserCompletePage";

  const AuthUserCompletePage({super.key});

  @override
  State<AuthUserCompletePage> createState() => _AuthUserCompletePageState();
}

class _AuthUserCompletePageState extends State<AuthUserCompletePage> {
  var key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 4),
      body: Form(
        key: key,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height(),
                HeaderText(title: "اهلا بك"),
                8.height(),
                Text("يرجى ادخال الاسم"),
                16.height(),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(hintText: "الإسم"),
                  validator: RequiredValidator(
                    errorText: context.coreTranslations.fieldRequiredMessage,
                  ).call,
                ),
                16.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        getIt<AuthCubit>().complete(name.text);
                      }
                    },
                    child: Text("متابعة"),
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
