
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessageDialog extends StatefulWidget {
  final String message;

  const MessageDialog({
    super.key,
    required this.message,
  });

  @override
  State<MessageDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(16),
      content: Text(
        widget.message,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
      ),
      backgroundColor: Theme.of(context).cardColor,
      actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      actions: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 91, minHeight: 41),
          // width: 91,
          // height: 41,
          child: ElevatedButton(
            onPressed: () {
              context.pop();
            },

            child: Text("نعم"),
          ),
        ),
      ],
    );
  }
}
