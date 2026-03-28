import 'package:flutter/material.dart';
import '../models/link_model.dart';
import '../utils/constants.dart';

class EditLinkDialog extends StatefulWidget {
  final LinkModel link;

  const EditLinkDialog({super.key, required this.link});

  @override
  State<EditLinkDialog> createState() => _EditLinkDialogState();
}

class _EditLinkDialogState extends State<EditLinkDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _urlController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.link.url);
    _nameController = TextEditingController(text: widget.link.name);
  }

  @override
  void dispose() {
    _urlController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    final urlPattern = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(url);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop({
        'url': _urlController.text.trim(),
        'name': _nameController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.edit, color: AppColors.primary),
          const SizedBox(width: 8),
          const Text(AppStrings.editLink),
        ],
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: AppStrings.url,
                  hintText: AppStrings.enterUrl,
                  prefixIcon: const Icon(Icons.link),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.invalidUrl;
                  }
                  if (!_isValidUrl(value.trim())) {
                    return AppStrings.invalidUrl;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppStrings.shortName,
                  hintText: AppStrings.enterName,
                  prefixIcon: const Icon(Icons.short_text),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submitForm(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.invalidName;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppStrings.cancel,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(AppStrings.save),
        ),
      ],
    );
  }
}
