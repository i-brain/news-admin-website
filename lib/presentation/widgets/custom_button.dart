import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_admin/core/extension.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.backgroundColor,
  });
  final String title;
  final bool isLoading;
  final void Function() onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isLoading ? null : onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? context.colors.primary,
            shadowColor: Colors.transparent,
            foregroundColor: context.colors.onPrimary,
          ),
          child: Padding(
            padding: EdgeInsets.all(isLoading ? 14.0 : 10.0).r,
            child: isLoading
                ? const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  )
                : Text(
                    title,
                    style: context.style.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      color: context.colors.onPrimary,
                    ),
                    maxLines: 1,
                  ),
          ),
        ),
      ),
    );
  }
}
