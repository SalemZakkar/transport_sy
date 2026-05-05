import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/injection.dart';

class SettingsPage extends StatefulWidget {
  static String path = "/SettingsPage";

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإعدادات"),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(onPressed: getIt<AuthCubit>().logout, child: Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }
}
