import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';

class CustomButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;
    final Color bg = backgroundColor ?? AppColors.primary;
    final Color fg = textColor ?? AppColors.textOnPrimary;
    final double radius = context.rs(borderRadius);

    final double effectiveHeight = height != null
        ? context.rs(height!)
        : Responsive.value(context, mobile: 48.0, tablet: 50.0, desktop: 52.0);

    final EdgeInsetsGeometry effectivePadding =
        padding ??
        EdgeInsets.symmetric(
          horizontal: Responsive.value(
            context,
            mobile: 16.0,
            tablet: 20.0,
            desktop: 24.0,
          ),
        );

    final TextStyle effectiveTextStyle =
        (textStyle ?? AppTextStyle.buttonLarge.copyWith(color: fg)).scaled(
          context,
        );

    return SizedBox(
      height: effectiveHeight,
      width: width != null ? context.rs(width!) : double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: isDisabled ? null : gradient,
          color: isDisabled
              ? bg.withValues(alpha: isLoading ? 0.85 : 0.5)
              : (gradient == null ? bg : null),
          borderRadius: BorderRadius.circular(radius),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: context.rs(1.5))
              : null,
          boxShadow: isDisabled || gradient != null
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
            onTap: isDisabled ? null : onPressed,
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              padding: effectivePadding,
              alignment: Alignment.center,
              child: isLoading
                  ? SpinKitThreeBounce(color: fg, size: context.rs(20))
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (prefixIcon != null) ...[
                          prefixIcon!,
                          horizontalSpace(8),
                        ],
                        Flexible(
                          child: Text(
                            text,
                            style: effectiveTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (suffixIcon != null) ...[
                          horizontalSpace(8),
                          suffixIcon!,
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
