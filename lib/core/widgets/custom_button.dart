import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final LinearGradient? gradient;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.height,
    this.width,
    this.borderRadius = 12,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.gradient,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.onPressed == null || widget.isLoading;
    final Color bg = widget.backgroundColor ?? AppColors.primary;
    final Color hoverBg = widget.backgroundColor != null
        ? widget.backgroundColor!
        : AppColors.primaryHover;
    final Color fg = widget.textColor ?? AppColors.textOnPrimary;
    final double radius = context.rs(widget.borderRadius);

    final double effectiveHeight = widget.height != null
        ? context.rs(widget.height!)
        : Responsive.value(context, mobile: 48.0, tablet: 50.0, desktop: 52.0);

    final EdgeInsetsGeometry effectivePadding =
        widget.padding ??
        EdgeInsets.symmetric(
          horizontal: Responsive.value(
            context,
            mobile: 16.0,
            tablet: 20.0,
            desktop: 24.0,
          ),
        );

    final TextStyle effectiveTextStyle =
        (widget.textStyle ?? AppTextStyle.buttonLarge.copyWith(color: fg))
            .scaled(context);

    return SizedBox(
      height: effectiveHeight,
      width: widget.width != null ? context.rs(widget.width!) : double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: isDisabled ? null : widget.gradient,
          color: isDisabled
              ? bg.withValues(alpha: widget.isLoading ? 0.85 : 0.5)
              : (widget.gradient == null
                    ? (_hovering ? hoverBg : bg)
                    : null),
          borderRadius: BorderRadius.circular(radius),
          border: widget.borderColor != null
              ? Border.all(
                  color: widget.borderColor!,
                  width: context.rs(1.5),
                )
              : null,
          boxShadow: isDisabled || widget.gradient != null
              ? null
              : [
                  BoxShadow(
                    color: bg.withValues(alpha: 0.3),
                    blurRadius: context.rs(12),
                    offset: Offset(0, context.rs(4)),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isDisabled ? null : widget.onPressed,
            onHover: (hovering) => setState(() => _hovering = hovering),
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              padding: effectivePadding,
              alignment: Alignment.center,
              child: isDisabled
                  ? SpinKitThreeBounce(color: fg, size: context.rs(20))
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.prefixIcon != null) ...[
                          widget.prefixIcon!,
                          horizontalSpace(8),
                        ],
                        Flexible(
                          child: Text(
                            widget.text,
                            style: effectiveTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.suffixIcon != null) ...[
                          horizontalSpace(8),
                          widget.suffixIcon!,
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
