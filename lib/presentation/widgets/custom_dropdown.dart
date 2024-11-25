import 'package:flutter/material.dart';
import 'package:news_admin/core/extension.dart';
import 'package:news_admin/core/constants/colors.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.list,
    this.initiValue,
    this.onTap,
    this.hint,
  });

  final List<String> list;
  final String? initiValue;
  final void Function(String)? onTap;
  final String? hint;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(4),
        isExpanded: true,
        hint: widget.hint != null
            ? Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: Text(
                  widget.hint!,
                  style:
                      context.style.bodyMedium?.copyWith(color: Colors.black),
                ),
              )
            : null,
        iconEnabledColor: bgColor,
        selectedItemBuilder: (context) =>
            widget.list.toSet().map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                value,
                style: context.style.bodyMedium?.copyWith(color: Colors.black),
              ),
            ),
            onTap: () => _onTap(value),
          );
        }).toList(),
        items: widget.list.toSet().map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: context.style.bodyMedium,
            ),
            onTap: () => _onTap(value),
          );
        }).toList(),
        value: _selectedValue ?? widget.initiValue,
        onChanged: (_) {},
      ),
    );
  }

  void _onTap(String value) {
    if (widget.onTap != null) {
      widget.onTap!(value);
    }

    setState(() {
      _selectedValue = value;
    });
  }
}
