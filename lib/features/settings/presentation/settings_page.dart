import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/domain/entity/user.dart';
import 'package:transport_sy/features/auth/domain/enum/user_type.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/features/core/presentation/widget/bloc/user_builder.dart';
import 'package:transport_sy/features/trips/presentation/page/trip_logs_page.dart';
import 'package:transport_sy/injection.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

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
      appBar: AppBar(title: Text("الإعدادات")),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: UserBuilder(
              builder: (user) => Column(
                children: [
                  _buildUserCard(user, context),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: getIt<AuthCubit>().logout,
                      child: Text("تسجيل الخروج"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(User user, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User header with avatar
            Row(
              children: [
                _buildUserAvatar(user),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name ?? "مستخدم غير معروف",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getUserTypeArabic(user.type),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // User details grid
            _buildDetailItem(
              icon: Icons.phone,
              label: "الهاتف",
              value: user.phone,
            ),
            _buildDetailItem(
              icon: Icons.location_city,
              label: "المدينة",
              value: user.city,
            ),
            _buildDetailItem(
              icon: Icons.home,
              label: "العنوان",
              value: user.address,
            ),
            _buildDetailItem(
              icon: Icons.cake,
              label: "تاريخ الميلاد",
              value: DateFormat('dd/MM/yyyy').format(user.birth),
            ),
            _buildDetailItem(
              icon: Icons.account_balance_wallet,
              label: "الرصيد",
              value: "${NumberFormat('#,##0').format(user.balance)} ل.س",
            ),
            _buildDetailItem(
              icon: Icons.verified_user,
              label: "الجنس",
              value: _getGenderArabic(user.gender),
            ),
            _buildDetailItem(
              icon: Icons.bus_alert_outlined,
              label: "رحلاتي",
              value: "5 رحلات", // Placeholder value, replace with actual data
              trailingWidget: ElevatedButton(
                onPressed: () {
                  context.push(TripLogsPage.path);
                  // Navigate to user's trips page
                },
                child: Text("عرض الرحلات"),
              ),
            ),
            _buildDetailItem(
              icon: Icons.wallet,
              label: "المحفظة",
              value: "100 ل.س", // Placeholder value, replace with actual data
              trailingWidget: ElevatedButton(
                onPressed: () {
                  context.push(TripLogsPage.path);
                  // Navigate to user's trips page
                },
                child: Text("عرض المحفظة"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar(User user) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
      ),
      child: Center(
        child: Text(
          user.name != null && user.name!.isNotEmpty
              ? user.name![0].toUpperCase()
              : "?",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    Widget? trailingWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: trailingWidget != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Theme.of(context).primaryColor),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  const SizedBox(height: 2),

                  Text(value, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ],
          ),
          if (trailingWidget != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: trailingWidget,
            ),
        ],
      ),
    );
  }

  String _getUserTypeArabic(UserType type) {
    switch (type) {
      case UserType.rider:
        return "راكب";
      case UserType.driver:
        return "سائق";
    }
  }

  String _getGenderArabic(String gender) {
    final lowerGender = gender.toLowerCase();
    if (lowerGender == 'male' || lowerGender == 'm') return "ذكر";
    if (lowerGender == 'female' || lowerGender == 'f') return "أنثى";
    return gender;
  }
}
