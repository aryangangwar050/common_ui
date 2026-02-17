import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? hintText;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final Widget? prefix;
  final bool isRead;
  final bool obscureText;
  final bool isMandatory;
  final int maxLength;
  final RegExp? textRegex;
  final int? maxLines;
  final int? minLines;
  final Color? borderColor;
  final Color? fillColor;
  final double borderRadius;
  final VoidCallback? onTap;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.title,
    this.hintText,
    this.onChanged,
    this.focusNode,
    this.keyboardType,
    this.inputFormatters,
    this.suffix,
    this.prefix,
    this.isRead = false,
    this.obscureText = false,
    this.isMandatory = true,
    this.maxLength = 250,
    this.textRegex,
    this.maxLines = 1,
    this.minLines,
    this.borderColor,
    this.fillColor,
    this.borderRadius = 12,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: isRead,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onTap: onTap,
      validator: (value) {
        if (isMandatory) {
          if (value == null || value.trim().isEmpty) {
            return "$title can't be empty";
          }
          if (textRegex != null && !textRegex!.hasMatch(value)) {
            return "Please enter valid $title";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        filled: fillColor != null,
        fillColor: fillColor,
        prefixIcon: prefix,
        suffixIcon: suffix,
        counterText: '',
        border: _border(borderColor),
        enabledBorder: _border(borderColor),
        focusedBorder: _border(borderColor ?? Theme.of(context).primaryColor),
        errorBorder: _border(Colors.red),
      ),
    );
  }

  OutlineInputBorder _border(Color? color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: color ?? Colors.grey,
      ),
    );
  }
}
