import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
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
      appBar: AppBar(),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserBuilder(builder: (user) => Text(user.name)),
              ElevatedButton(onPressed: () {
                getIt<AuthCubit>().logout();
              }, child: Text("data")),
            ],
          ),
        ),
      ),
    );
  }
}
