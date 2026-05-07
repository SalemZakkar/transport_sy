import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:transport_sy/features/auth/domain/entity/user.dart';
import 'package:transport_sy/features/auth/domain/enum/user_type.dart';
import 'package:transport_sy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:transport_sy/features/auth/presentation/page/presentation/auth_wallet_page.dart';
import 'package:transport_sy/features/core/presentation/page/complains_page.dart';
import 'package:transport_sy/features/core/presentation/widget/bloc/user_builder.dart';
import 'package:transport_sy/features/trips/domain/entity/trip.dart';
import 'package:transport_sy/features/trips/presentation/page/trip_logs_page.dart';
import 'package:transport_sy/injection.dart';
import 'package:intl/intl.dart';

class SettingsPage extends StatefulWidget {
  static String path = "/SettingsPage";

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("الإعدادات"),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              child: UserBuilder(
                builder: (user) => _buildContent(user, context, isMobile),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(User user, BuildContext context, bool isMobile) {
    return Column(
      children: [
        _buildUserCard(user, context, isMobile),
        SizedBox(height: isMobile ? 16 : 24),
        _buildActionButtons(context, isMobile),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isMobile) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[400],
        ),
        onPressed: () => _handleLogout(context),
        child: const Text("تسجيل الخروج"),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text("تسجيل الخروج"),
        content: const Text("هل أنت متأكد من رغبتك في تسجيل الخروج؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              getIt<AuthCubit>().logout();
            },
            child: const Text("تسجيل الخروج"),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(User user, BuildContext context, bool isMobile) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserHeader(user, context, isMobile),
            SizedBox(height: isMobile ? 16 : 20),
            _buildDetailsList(user, context, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(User user, BuildContext context, bool isMobile) {
    return Row(
      children: [
        _buildUserAvatar(user, isMobile),
        SizedBox(width: isMobile ? 12 : 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? "مستخدم غير معروف",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: isMobile ? 16 : 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: isMobile ? 2 : 4),
              Text(
                _getUserTypeArabic(user.type),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: isMobile ? 12 : 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsList(User user, BuildContext context, bool isMobile) {
    final trips = _getSafeTrips(); // Safe trips retrieval

    return Column(
      children: [
        _buildDetailItem(
          icon: Icons.phone,
          label: "الهاتف",
          value: user.phone ?? "غير محدد",
          isMobile: isMobile,
        ),
        _buildDetailItem(
          icon: Icons.location_city,
          label: "المدينة",
          value: user.city ?? "غير محدد",
          isMobile: isMobile,
        ),
        _buildDetailItem(
          icon: Icons.home,
          label: "العنوان",
          value: user.address ?? "غير محدد",
          isMobile: isMobile,
        ),
        _buildDetailItem(
          icon: Icons.cake,
          label: "تاريخ الميلاد",
          value: _formatBirthDate(user.birth),
          isMobile: isMobile,
        ),
        _buildDetailItem(
          icon: Icons.verified_user,
          label: "الجنس",
          value: _getGenderArabic(user.gender ?? ""),
          isMobile: isMobile,
        ),
        _buildDetailItem(
          icon: Icons.bus_alert_outlined,
          label: "رحلاتي",
          value: trips.length.toString(),
          isMobile: isMobile,
          trailingWidget: _buildNavigationButton(
            onPressed: () => _navigateSafely(context, TripLogsPage.path),
          ),
        ),
        _buildDetailItem(
          icon: Icons.wallet,
          label: "المحفظة",
          value: _formatBalance(user.balance),
          isMobile: isMobile,
          trailingWidget: _buildNavigationButton(
            onPressed: () => _navigateSafely(context, AuthWalletPage.path),
          ),
        ),
        _buildDetailItem(
          icon: Icons.report_problem_outlined,
          label: "الشكاوي",
          value: "قائمة الشكاوي الخاصة بك",
          isMobile: isMobile,
          trailingWidget: _buildNavigationButton(
            onPressed: () => _navigateSafely(context, ComplainsPage.path),
          ),
        ),
      ],
    );
  }

  Widget _buildUserAvatar(User user, bool isMobile) {
    final avatarSize = isMobile ? 64.0 : 72.0;
    final fontSize = isMobile ? 24.0 : 28.0;

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
      ),
      child: Center(
        child: Text(
          _getAvatarText(user.name),
          style: TextStyle(
            fontSize: fontSize,
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
    required bool isMobile,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 10),
      child: Row(
        mainAxisAlignment: trailingWidget != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  icon,
                  size: isMobile ? 18 : 20,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: isMobile ? 10 : 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).hintColor,
                          fontSize: isMobile ? 12 : 14,
                        ),
                      ),
                      SizedBox(height: isMobile ? 1 : 2),
                      Text(
                        value,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: isMobile ? 13 : 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (trailingWidget != null)
            Padding(
              padding: EdgeInsets.only(left: isMobile ? 4 : 8),
              child: trailingWidget,
            ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_forward_ios),
      iconSize: 18,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      padding: EdgeInsets.zero,
    );
  }

  // Safe helper methods
  String _getUserTypeArabic(UserType type) {
    return switch (type) {
      UserType.rider => "راكب",
      UserType.driver => "سائق",
    };
  }

  String _getGenderArabic(String gender) {
    if (gender.isEmpty) return "غير محدد";
    final lowerGender = gender.toLowerCase();
    return switch (lowerGender) {
      'male' || 'm' => "ذكر",
      'female' || 'f' => "أنثى",
      _ => gender,
    };
  }

  String _getAvatarText(String? name) {
    if (name == null || name.isEmpty) return "?";
    return name[0].toUpperCase();
  }

  String _formatBirthDate(DateTime? date) {
    if (date == null) return "غير محدد";
    try {
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return "غير محدد";
    }
  }

  String _formatBalance(num? balance) {
    if (balance == null) return "0 SP";
    try {
      return balance.toString().addSyp;
    } catch (e) {
      return "0 SP";
    }
  }

  List<Trip> _getSafeTrips() {
    try {
      // Replace with actual trips retrieval from your state management
      // This is a safe fallback to empty list
      return []; // TODO: Get from actual state
    } catch (e) {
      return [];
    }
  }

  void _navigateSafely(BuildContext context, String path) {
    try {
      if (context.mounted) {
        context.push(path);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("حدث خطأ أثناء الملاحة"),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
