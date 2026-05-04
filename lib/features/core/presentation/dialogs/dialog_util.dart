import 'package:core_package/core_package.dart';
import 'package:core_package/generated/core_translation/core_translations.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'loading_dialog.dart';

class DialogUtil {
  BuildContext context;
  final bool canPop;
  final VoidCallback? onShow, onAccept, onCancel;

  DialogUtil({
    required this.context,
    this.canPop = true,
    this.onAccept,
    this.onShow,
    this.onCancel,
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
}