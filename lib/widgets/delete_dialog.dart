import 'package:flutter/material.dart';
import '../utils/constants.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String message;

  const DeleteDialog({
    super.key,
    this.title = 'Delete Link',
    this.message = AppStrings.deleteConfirmation,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.error),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      content: Text(
        message,
        style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            AppStrings.no,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(AppStrings.yes),
        ),
      ],
    );
  }
}
