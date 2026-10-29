import 'package:flutter/material.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool isObscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextCapitalization textCapitalization;
  final AutovalidateMode autovalidateMode;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  OutlineInputBorder _border(BuildContext context, Color color, double width) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.rs(12)),
        borderSide: BorderSide(color: color, width: context.rs(width)),
      );

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTextStyle.inputLabel.scaled(context)),
          verticalSpace(8),
        ],
        TextFormField(
          controller: controller,
          obscureText: isObscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          maxLines: maxLines,
          maxLength: maxLength,
          readOnly: readOnly,
          onTap: onTap,
          textCapitalization: textCapitalization,
          autovalidateMode: autovalidateMode,
          style: AppTextStyle.inputText.scaled(context),
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyle.inputHint.scaled(context),
            filled: true,
            fillColor: AppColors.surfaceContainer,
            contentPadding: EdgeInsets.symmetric(
              horizontal: rs(16),
              vertical: rs(16),
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: rs(16),
                      end: rs(12),
                    ),
                    child: Icon(
                      prefixIcon,
                      color: AppColors.textTertiary,
                      size: rs(22),
                    ),
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsetsDirectional.only(end: rs(16)),
                    child: suffixIcon,
                  )
                : null,
            prefixIconConstraints: BoxConstraints(
              minWidth: rs(48),
              minHeight: rs(48),
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: rs(48),
              minHeight: rs(48),
            ),
            border: _border(context, AppColors.outline, 1.5),
            enabledBorder: _border(context, AppColors.outline, 1.5),
            focusedBorder: _border(context, AppColors.primary, 2),
            errorBorder: _border(context, AppColors.error, 1.5),
            focusedErrorBorder: _border(context, AppColors.error, 2),
            disabledBorder: _border(
              context,
              AppColors.outline.withValues(alpha: 0.5),
              1.5,
            ),
            errorStyle: AppTextStyle.inputError.scaled(context),
            errorMaxLines: 2,
            counterText: '',
          ),
        ),
      ],
    );
  }
}
