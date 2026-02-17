import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:common_ui/src/validators/validators.dart';

/// A simple alias for validator functions used by `CommonTextField`.
///
/// The function receives the current field value and should return
/// an error message string when invalid, or `null` when valid.
typedef FieldValidator = String? Function(String? value);

/// Visual styling configuration for `CommonTextField`.
///
/// Encapsulates border, fill and radius values so the widget
/// remains focused on building UI while styling is provided
/// via a single dependency (Single Responsibility).
class CommonTextFieldStyle {
  final Color? borderColor;
  final Color? fillColor;
  final double borderRadius;

  const CommonTextFieldStyle({
    this.borderColor,
    this.fillColor,
    this.borderRadius = 12,
  });

  OutlineInputBorder border(Color? overrideColor) {
    final color = overrideColor ?? borderColor ?? Colors.grey;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: color),
    );
  }
}

/// Reusable text field that keeps validation and styling injected.
///
/// This implementation follows SOLID principles:
/// - Single Responsibility: UI rendering only; validation and style
///   are injected/delegated.
/// - Open/Closed: new validation strategies or style objects can be
///   provided without changing this widget.
class CommonTextField extends StatelessWidget {
  /// Controller that holds the text being edited.
  final TextEditingController controller;

  /// Field title used in default validation messages.
  final String title;

  /// Optional hint shown inside the field.
  final String? hintText;

  /// Called when the field value changes.
  final ValueChanged<String>? onChanged;

  /// Optional focus node to control focus from outside.
  final FocusNode? focusNode;

  /// Keyboard type for the input.
  final TextInputType? keyboardType;

  /// Input formatters applied to changes.
  final List<TextInputFormatter>? inputFormatters;

  /// Optional widget to show at the end of the field.
  final Widget? suffix;

  /// Optional widget to show at the start of the field.
  final Widget? prefix;

  /// Whether the field is read-only.
  final bool isRead;

  /// Whether to obscure the text (password fields).
  final bool obscureText;

  /// Maximum allowed length for the field.
  final int maxLength;

  /// Maximum and minimum lines for multiline support.
  final int? maxLines;
  final int? minLines;

  /// Optional onTap callback.
  final VoidCallback? onTap;

  /// Explicit validator injected by the consumer.
  /// If provided, it takes precedence over legacy flags.
  final FieldValidator? validator;

  /// Styling model for borders and fill.
  final CommonTextFieldStyle style;

  /// Legacy convenience: if no `validator` is provided, these
  /// flags are used to construct a default validator (backwards
  /// compatible).
  final bool isMandatory;
  final RegExp? textRegex;

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
    this.maxLength = 250,
    this.maxLines = 1,
    this.minLines,
    this.onTap,
    this.validator,
    this.style = const CommonTextFieldStyle(),
    this.isMandatory = true,
    this.textRegex,
  });

  FieldValidator get _effectiveValidator {
    if (validator != null) return validator!;

    // Compose a default validator using existing logic from
    // `validators.dart` so callers that relied on previous
    // behaviour continue to work.
    return (String? value) {
      if (isMandatory) {
        final req = AppValidators.required(value, title);
        if (req != null) return req;
      }
      if (textRegex != null) {
        final msg = "Please enter valid $title";
        final rg = AppValidators.regex(value, textRegex!, msg);
        if (rg != null) return rg;
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor =
        style.borderColor ?? Theme.of(context).dividerColor;

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
      validator: _effectiveValidator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: style.fillColor != null,
        fillColor: style.fillColor,
        prefixIcon: prefix,
        suffixIcon: suffix,
        counterText: '',
        border: style.border(effectiveBorderColor),
        enabledBorder: style.border(effectiveBorderColor),
        focusedBorder: style.border(
          style.borderColor ?? Theme.of(context).primaryColor,
        ),
        errorBorder: style.border(Colors.red),
      ),
    );
  }
}
