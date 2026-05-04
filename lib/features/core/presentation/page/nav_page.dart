import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/routes/routes.dart';

class NavPage extends StatefulWidget {
  final Widget child;
  static String path = "/NavPage";

  const NavPage({super.key, required this.child});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 72,
          child: BottomNavigationBar(
            onTap: (v) {
              AppRoutes.goRouterConfig.go(AppRoutes.tabs[v]);
            },
            currentIndex: AppRoutes.tabs.indexOf(
              GoRouter.of(context).state.path!,
            ),
            items: [
              BottomNavigationBarItem(
                label: "الرئيسية",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "الخريطة",
                icon: Icon(Icons.directions),
              ),
              BottomNavigationBarItem(
                label: "الإعدادات",
                icon: Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
