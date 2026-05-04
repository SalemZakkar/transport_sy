// import 'package:core_package/core_package.dart';
// import 'package:core_package/generated/core_translation/core_translations.dart';
// import 'package:flutter/material.dart';
//
// class ConfirmDialog extends StatefulWidget {
//   final String message;
//   final String title;
//   final String? acceptText;
//   final String? cancelText;
//
//   const ConfirmDialog({
//     super.key,
//     required this.message,
//     this.acceptText,
//     required this.title,
//     this.cancelText,
//   });
//
//   @override
//   State<ConfirmDialog> createState() => _ConfirmDialogState();
// }
//
// class _ConfirmDialogState extends State<ConfirmDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(widget.title),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(widget.message, style: Theme.of(context).textTheme.titleMedium),
//         ],
//       ),
//       actionsAlignment: MainAxisAlignment.end,
//       actions: [
//         SizedBox(
//           // width: 120,
//           child: TextButton(
//             onPressed: () {
//               context.pop();
//             },
//             child: Text(
//               widget.cancelText ?? CoreTranslations.of(context)!.cancel,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         SizedBox(
//           // width: 120,
//           child: TextButton(
//             onPressed: () {
//               context.pop(true);
//             },
//             child: Text(
//               widget.acceptText ?? CoreTranslations.of(context)!.accept,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
