import 'package:flutter/material.dart';
import 'package:news_admin/core/extension.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.maxLines,
  });

  final TextEditingController? controller;
  final String hint;
  final bool obscure;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final int? maxLines;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscure,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          style: context.style.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "*Required";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            fillColor: const Color(0xffF6F8FB).withOpacity(0.5),
            filled: true,
            border: const OutlineInputBorder(),
            label: Text(
              widget.hint,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
