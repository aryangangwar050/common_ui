import 'package:flutter/material.dart';

/// Style configuration for [CommonButton].
///
/// Encapsulates color, gradient, border, and shadow styling
/// to separate UI concerns from widget logic (Single Responsibility).
class CommonButtonStyle {
  /// Primary color. Used as solid background or gradient start.
  final Color primaryColor;

  /// Secondary color for gradient end (if gradient enabled).
  final Color secondaryColor;

  /// Text/label color.
  final Color textColor;

  /// Border color (shown only when [isBorder] is true).
  final Color borderColor;

  /// Optional gradient start alignment.
  final AlignmentGeometry gradientBegin;

  /// Optional gradient end alignment.
  final AlignmentGeometry gradientEnd;

  /// List of shadows for the button container.
  final List<BoxShadow>? boxShadow;

  const CommonButtonStyle({
    this.primaryColor = const Color(0xFF6200EE),
    this.secondaryColor = const Color(0xFF3700B3),
    this.textColor = Colors.white,
    this.borderColor = const Color(0xFF6200EE),
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.boxShadow,
  });
}

/// Reusable button widget with flexible styling and feedback.
///
/// This implementation follows SOLID principles:
/// - Single Responsibility: renders button; style and callbacks injected.
/// - Open/Closed: new styles or feedback behaviors via DI.
class CommonButton extends StatelessWidget {
  /// Button text/label.
  final String text;

  /// Callback triggered on button press.
  final VoidCallback onPressed;

  /// Whether to show a loading indicator instead of text.
  final bool isLoading;

  /// Button width. If null, uses available width.
  final double? width;

  /// Button height.
  final double height;

  /// Vertical padding inside the button.
  final double verticalPadding;

  /// Horizontal padding inside the button.
  final double horizontalPadding;

  /// Corner radius of the button.
  final double borderRadius;

  /// Font size for the button text.
  final double fontSize;

  /// Whether to use border style (outline) instead of filled.
  final bool isBorder;

  /// Whether to enable gradient fill.
  final bool useGradient;

  /// Leading icon (shown on the left if [leadingIcon] is set).
  final Widget? leadingIcon;

  /// Trailing icon (shown on the right if [trailingIcon] is set).
  final Widget? trailingIcon;

  /// Custom style model.
  final CommonButtonStyle style;

  /// Optional callback to provide haptic/sound feedback on press.
  /// If null, no feedback is triggered.
  final VoidCallback? onFeedback;

  /// Optional custom loading widget.
  /// If null, shows [CircularProgressIndicator].
  final Widget? customLoadingWidget;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.verticalPadding = 12,
    this.horizontalPadding = 16,
    this.borderRadius = 8,
    this.fontSize = 14,
    this.isBorder = false,
    this.useGradient = true,
    this.leadingIcon,
    this.trailingIcon,
    this.style = const CommonButtonStyle(),
    this.onFeedback,
    this.customLoadingWidget,
  });

  void _handlePress() {
    onFeedback?.call();
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = isBorder ? Colors.transparent : style.primaryColor;
    final gradient = useGradient && !isBorder
        ? LinearGradient(
            colors: [style.primaryColor, style.secondaryColor],
            begin: style.gradientBegin,
            end: style.gradientEnd,
          )
        : null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : _handlePress,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          decoration: BoxDecoration(
            color: gradient != null ? null : fillColor,
            gradient: gradient,
            border: isBorder
                ? Border.all(
                    color: style.borderColor,
                    width: 1.5,
                  )
                : null,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: style.boxShadow,
          ),
          child: isLoading
              ? _buildLoadingWidget()
              : _buildButtonContent(),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: customLoadingWidget ??
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor:
                  AlwaysStoppedAnimation<Color>(style.textColor),
            ),
          ),
    );
  }

  Widget _buildButtonContent() {
    final children = <Widget>[];

    if (leadingIcon != null) {
      children.add(leadingIcon!);
      children.add(const SizedBox(width: 8));
    }

    children.add(
      Expanded(
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: isBorder ? style.primaryColor : style.textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );

    if (trailingIcon != null) {
      children.add(const SizedBox(width: 8));
      children.add(trailingIcon!);
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}