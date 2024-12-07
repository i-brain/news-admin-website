import 'package:flutter/material.dart';
import 'package:news_admin/core/extension.dart';

Future<bool?> showErrorDialog(BuildContext context, String title) async {
  return showDialog<bool>(
    context: context,
    builder: (context) => SizedBox(
      child: SimpleDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        children: [
          const Icon(Icons.info, size: 50, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            title,
            style: context.style.titleMedium?.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text(
                'Okay',
                style: context.style.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
