import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/features/cards/presentation/widgets/my_cards_widget.dart';
import 'package:transport_sy/features/core/presentation/widget/bloc/user_builder.dart';
import 'package:transport_sy/injection.dart';

class HomePage extends StatefulWidget {
  static String path = "/HomePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الصفحة الرئيسية")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              16.height(),
              MyCardsWidget()
              // UserBuilder(builder: (user) => Text(user.name ?? '')),
              // ElevatedButton(
              //   onPressed: () {
              //     getIt<AuthCubit>().logout();
              //   },
              //   child: Text("data"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
