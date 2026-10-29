import 'dart:ui' show Color;

import 'package:flutter/material.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';

enum SnackType { success, error }

class AppSnackBar {
  const AppSnackBar._();

  static const _successBg = Color(0xFF14532D);
  static const _successFg = Color(0xFF86EFAC);
  static const _errorBg = Color(0xFF7F1D1D);
  static const _errorFg = Color(0xFFFCA5A5);

  static void show(
    BuildContext context, {
    required String message,
    SnackType type = SnackType.success,
  }) {
    final isSuccess = type == SnackType.success;
    final bg = isSuccess ? _successBg : _errorBg;
    final fg = isSuccess ? _successFg : _errorFg;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: bg,
          elevation: 0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: fg.withValues(alpha: 0.4)),
          ),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                Icon(
                  isSuccess
                      ? Icons.check_circle_rounded
                      : Icons.error_outline_rounded,
                  color: fg,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: AppTextStyle.labelLarge.copyWith(color: fg),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
