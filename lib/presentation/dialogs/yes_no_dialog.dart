import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        insetPadding: const EdgeInsets.symmetric(horizontal: 20).r,
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(16).r,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        children: [
          Text(
            title,
            style: context.style.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
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
              SizedBox(width: 16.r),
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
