import 'package:flutter/material.dart';
import 'package:news_admin/core/extension.dart';
import 'package:news_admin/core/constants/colors.dart';

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
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, _, __) => DropdownButton<String>(
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(4),
          isExpanded: true,
          hint: hint != null
              ? Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: Text(
                    hint!,
                    style:
                        context.style.bodyMedium?.copyWith(color: Colors.black),
                  ),
                )
              : null,
          iconEnabledColor: bgColor,
          selectedItemBuilder: (context) => list.toSet().map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  value,
                  style:
                      context.style.bodyMedium?.copyWith(color: Colors.black),
                ),
              ),
              onTap: () => _onTap(value),
            );
          }).toList(),
          items: list.toSet().map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: context.style.bodyMedium,
              ),
              onTap: () => _onTap(value),
            );
          }).toList(),
          value: valueNotifier.value,
          onChanged: (_) {},
        ),
      ),
    );
  }

  void _onTap(String value) {
    if (onTap != null) {
      onTap!(value);
    }

    valueNotifier.value = value;
  }
}
