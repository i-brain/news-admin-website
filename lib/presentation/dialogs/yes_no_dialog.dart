import 'package:flutter/material.dart';
import 'package:news_admin/core/constants/colors.dart';
import 'package:news_admin/core/extension.dart';

Future<bool?> showYesNoDialog(
  BuildContext context, {
  required String title,
  void Function()? onYes,
}) async {
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
          const Icon(Icons.info, size: 50, color: primaryColor),
          const SizedBox(height: 16),
          Text(
            title,
            style: context.style.titleMedium?.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    'No',
                    style:
                        context.style.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: onYes,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text(
                    'Yes',
                    style:
                        context.style.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
