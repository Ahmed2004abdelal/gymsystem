import 'package:flutter/material.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/helper/timezone_helper.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:intl/intl.dart';

class EgyptDateTimeBadge extends StatelessWidget {
  const EgyptDateTimeBadge({super.key});

  static final _dateFormat = DateFormat('yyyy-MM-dd');
  static final _timeFormat = DateFormat('hh:mm:ss a');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      initialData: EgyptTime.now(),
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => EgyptTime.now(),
      ),
      builder: (context, snapshot) {
        final now = snapshot.data!;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.date_range_rounded, color: AppColors.primary),
            horizontalSpace(8),
            Text(_dateFormat.format(now), style: AppTextStyle.titleMedium),
            horizontalSpace(12),
            const Icon(Icons.access_time_rounded, color: AppColors.primary),
            horizontalSpace(8),
            Text(_timeFormat.format(now), style: AppTextStyle.titleMedium),
          ],
        );
      },
    );
  }
}
