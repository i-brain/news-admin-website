import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_admin/core/extension.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hint,
    this.hintStyle,
    this.obscure = false,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.errorMessage,
    this.optional = false,
    this.suffix,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.enabled = true,
    this.prefixIcon,
    this.focusNode,
    this.onTap,
    this.onSubmitted,
    this.readOnly = false,
    this.onChanged,
    this.autofocus = false,
    this.inputFormatters,
    this.maxLines,
    this.borderColor,
  });

  final TextEditingController? controller;
  final String? hint;
  final TextStyle? hintStyle;
  final bool obscure;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final int? maxLines;
  final List<dynamic>? errorMessage;
  final bool optional;
  final Widget? suffix;
  final AutovalidateMode autovalidateMode;
  final bool enabled;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final bool readOnly;
  final void Function(String)? onChanged;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showText = false;
  bool showClearIcon = false;

  late final StreamController<List<dynamic>?> errorMessageStreamController;

  @override
  void initState() {
    super.initState();
    errorMessageStreamController = StreamController<List<dynamic>?>()
      ..add(null);
  }

  @override
  void dispose() {
    errorMessageStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    errorMessageStreamController.add(widget.errorMessage);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          inputFormatters: widget.inputFormatters,
          autovalidateMode: widget.autovalidateMode,
          obscureText: widget.obscure != showText,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onSubmitted,
          onChanged: widget.onChanged,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          validator: _onValidate,
          style: context.style.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: widget.hintStyle ??
                context.style.bodyLarge?.copyWith(
                  color: const Color(0xff737373),
                ),
            filled: true,
            fillColor: Colors.white,
            errorStyle: const TextStyle(fontSize: 0),
            border: border,
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(color: context.colors.primary),
            ),
            focusedErrorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.red),
            ),
            disabledBorder: border,
            errorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 32,
              vertical: widget.maxLines != null ? 32 : 0,
            ).r,
            suffixIcon: widget.suffix,
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          ),
        ),
        CustomTextFieldErrorMessage(
          streamController: errorMessageStreamController,
        )
      ],
    );
  }

  InputBorder get border => OutlineInputBorder(
        // borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: widget.borderColor ?? const Color(0xff737373),
        ),
      );

  String? _onValidate(String? value) {
    if (widget.optional || widget.readOnly) {
      return null;
    }
    if (widget.errorMessage != null) {
      errorMessageStreamController.add(widget.errorMessage!);
    } else if (value == null || value.isEmpty) {
      errorMessageStreamController.add(['*Required']);
      return '';
    } else {
      errorMessageStreamController.add(null);
    }

    return null;
  }
}

class CustomTextFieldErrorMessage extends StatelessWidget {
  const CustomTextFieldErrorMessage({
    super.key,
    required this.streamController,
  });

  final StreamController<List<dynamic>?>? streamController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>?>(
      stream: streamController!.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Padding(
            padding: const EdgeInsets.only(top: 4, left: 8).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                snapshot.data!.length,
                (index) => Text(
                  snapshot.data?[index],
                  style: context.style.bodySmall
                      ?.copyWith(color: context.colors.error),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
