import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:transport_sy/features/cards/presentation/widgets/my_cards_widget.dart';
import 'package:transport_sy/features/core/presentation/widget/sheets/pay_sheet.dart';
import 'package:transport_sy/themes/app_colors_shema.dart';

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
      appBar: AppBar(
        title: Text("الصفحة الرئيسية"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                builder: (context) => PaySheet(),
              );
            },
            icon: Icon(
              Iconsax.card_pos_bold,
              color: LightAppColorSchema().secondary,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              16.height(),
              MyCardsWidget(),
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
