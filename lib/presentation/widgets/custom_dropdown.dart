import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_admin/core/extension.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.list,
    required this.valueNotifier,
    this.onTap,
    this.hint,
  });

  final List<String> list;
  final void Function(String)? onTap;
  final ValueNotifier<String?> valueNotifier;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, _, __) => DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.zero,
        ),
        isExpanded: true,
        hint: hint != null
            ? Padding(
                padding: const EdgeInsets.only(left: 32).w,
                child: Text(
                  hint!,
                  style: context.style.bodyMedium,
                ),
              )
            : null,
        items: list.toSet().map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              padding: const EdgeInsets.only(left: 16).r,
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: Text(value, style: context.style.bodyMedium),
              ),
            ),
            onTap: () => _onTap(value),
          );
        }).toList(),
        value: (() {
          assignFirstValue();
          return valueNotifier.value;
        }()),
        onChanged: (_) {},
      ),
    );
  }

  void _onTap(String value) {
    if (onTap != null) {
      onTap!(value);
    }

    valueNotifier.value = value;
  }

  void assignFirstValue() {
    if (list.contains(valueNotifier.value) == false && hint == null) {
      valueNotifier.value = list.first;
    }
  }
}
