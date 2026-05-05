import 'package:core_package/core_package.dart';
import 'package:core_package/generated/core_translation/core_translations.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'loading_dialog.dart';

class DialogUtil {
  BuildContext context;
  final bool canPop;
  final bool useRoot;
  final VoidCallback? onShow, onAccept, onCancel;

  DialogUtil({
    required this.context,
    this.canPop = true,
    this.onAccept,
    this.onShow,
    this.onCancel,
    this.useRoot = false,
  });

  Future<void> showLoadingDialog({bool? root}) async {
    onShow?.call();
    await showDialog(
      context: context,
      useRootNavigator: root ?? false,
      builder: (context) => const LoadingDialog(),
      barrierDismissible: false,
    );
  }

  Future<void> showSuccessDialog({String? message}) async {
    onShow?.call();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      titleColor: Theme.of(context).textTheme.headlineSmall!.color!,
      textColor: Theme.of(context).textTheme.headlineSmall!.color!,
      title: message ?? CoreTranslations.of(context)!.success,
      onConfirmBtnTap: () {
        context.pop();
        onAccept?.call();
      },
      backgroundColor: Theme.of(context).cardColor,
      confirmBtnText: CoreTranslations.of(context)!.ok,
      // confirmBtnColor: context.appColorSchema.statusColors.success,
    );
  }

  Future<void> showErrorDialog({String? message}) async {
    onShow?.call();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      titleColor: Theme.of(context).textTheme.headlineSmall!.color!,
      textColor: Theme.of(context).textTheme.headlineSmall!.color!,
      title: message ?? CoreTranslations.of(context)!.success,
      onConfirmBtnTap: () {
        context.pop();
        onAccept?.call();
      },
      backgroundColor: Theme.of(context).cardColor,
      confirmBtnText: CoreTranslations.of(context)!.ok,
      // confirmBtnColor: context.appColorSchema.statusColors.success,
    );
  }

  Future<void> showConfirmDialog({String? message, String? title}) async {
    onShow?.call();
    await showDialog(
      context: context,
      useRootNavigator: useRoot,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            title ?? "تأكيد العملية",
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          content: Text(
            message ?? "هل أنت متأكد من الاستمرار في هذا الإجراء؟",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                onCancel?.call();
              },
              child: Text(
                "إلغاء",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 91, minHeight: 41),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  context.pop();
                  onAccept?.call();
                },
                child: const Text("تأكيد"),
              ),
            ),
          ],
        );
      },
    );
  }
}
