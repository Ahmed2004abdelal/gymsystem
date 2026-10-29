import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/helper/extensions.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/routing/routes.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/core/widgets/custom_button.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_response_model.dart';
import 'package:gymsystem/features/home/logic/reception_cubit.dart';
import 'package:gymsystem/features/home/logic/reception_state.dart';

// class _LogEntry {
//   final String name;
//   final String plan;
//   final String time;
//   final bool expiring;
//   const _LogEntry(this.name, this.plan, this.time, {this.expiring = false});
// }

// const _entries = [
//   _LogEntry('طارق فهد الكوارى', 'باقة شهرية شاملة', '10:42 ص'),
//   _LogEntry('كريم عبد العزيز', 'باقة 3 شهور - لياقة', '10:35 ص'),
//   _LogEntry('سامي الجابري', 'باقة سنوية ذهبية VIP', '10:20 ص'),
//   _LogEntry('ياسين بن عمر', 'باقة تدريب خاص (PT)', '09:55 ص', expiring: true),
//   _LogEntry('عمر رضوان', 'باقة شهرية - حديد', '09:40 ص'),
// ];

class LiveLogCard extends StatelessWidget {
  const LiveLogCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CustomButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.registerMember);
              },
              text: 'تسجيل مشترك جديد',
              prefixIcon: const Icon(Icons.person_add_alt_1_rounded),
            ),
          ],
        ),
        verticalSpace(16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.strokeDefault),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              verticalSpace(8),

              LogiTileBlocBuilder(),
            ],
          ),
        ),
      ],
    );
  }
}

class LogiTileBlocBuilder extends StatelessWidget {
  const LogiTileBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceptionCubit, ReceptionState>(
      buildWhen: (p, c) =>
          p.firstFiveAttendancesStatus != c.firstFiveAttendancesStatus,
      builder: (context, state) {
        switch (state.firstFiveAttendancesStatus) {
          case ReceptionStatus.initial:
          case ReceptionStatus.loading:
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );

          case ReceptionStatus.failure:
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  state.errorMessage ?? 'حدث خطأ أثناء تحميل السجل',
                  style: AppTextStyle.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            );

          case ReceptionStatus.success:
            final items = state.fiveAttendancesData.take(5).toList();
            if (items.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'لا يوجد سجل دخول اليوم',
                    style: AppTextStyle.caption,
                  ),
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: AppColors.strokeDefault),
              itemBuilder: (_, i) => _LogTile(entry: items[i]),
            );
        }
      },
    );
  }
}

// ───────────────────────────── Header ─────────────────────────────

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.schedule_rounded, size: 20, color: AppColors.primary),
        horizontalSpace(8),
        Expanded(
          child: Text(
            'سجل الدخول المباشر اليوم',
            style: AppTextStyle.titleMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        horizontalSpace(8),
        const _SmallButton(
          icon: Icons.drive_file_move_rtl_outlined,
          label: 'المزيد',
        ),
      ],
    );
  }
}

class _SmallButton extends StatelessWidget {
  final IconData icon;
  final String? label;

  const _SmallButton({required this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainer,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          context.pushNamed(Routes.attendanceTableScreen);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.strokeStrong),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: AppColors.textPrimary),
              if (label != null) ...[
                horizontalSpace(6),
                Text(
                  label!,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────── Tile ─────────────────────────────

class _LogTile extends StatelessWidget {
  final MemberLogedinResponseModel entry;
  const _LogTile({required this.entry});

  // Adjust to whatever values your API returns for statusAtCheckIn
  bool get _expiring {
    final s = entry.statusAtCheckIn.toLowerCase();
    return s == 'expired' || s == 'expiring' || s == 'منتهي';
  }

  String get _time {
    final t = entry.checkInTime.toLocal();
    final h12 = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    final period = t.hour < 12 ? 'ص' : 'م';
    return '${h12.toString().padLeft(2, '0')}:$m $period';
  }

  @override
  Widget build(BuildContext context) {
    final expiring = _expiring;
    final timeColor = expiring ? AppColors.warning : AppColors.primary;
    final dotColor = expiring
        ? AppColors.statusExpiring
        : AppColors.statusActive;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.strokeStrong),
                ),
                child: const Icon(
                  Icons.person,
                  size: 22,
                  color: AppColors.textTertiary,
                ),
              ),
              PositionedDirectional(
                top: -3,
                end: -3,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.memberName,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  entry.packageNameAtCheckIn,
                  style: AppTextStyle.caption,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          horizontalSpace(8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _time,
                style: AppTextStyle.labelLarge.copyWith(
                  color: timeColor,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              verticalSpace(4),
              _StatusChip(expiring: expiring),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool expiring;
  const _StatusChip({required this.expiring});

  @override
  Widget build(BuildContext context) {
    final color = expiring ? AppColors.statusExpiring : AppColors.statusActive;
    final bg = expiring ? AppColors.statusExpiringBg : AppColors.statusActiveBg;
    final border = expiring
        ? AppColors.statusExpiringBorder
        : AppColors.statusActiveBorder;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border),
      ),
      child: Text(
        expiring ? 'انتهي' : 'نشط',
        style: AppTextStyle.labelSmall.copyWith(color: color),
      ),
    );
  }
}

// // ───────────────────────────── Density chart ─────────────────────────────

// class _DensityChart extends StatelessWidget {
//   const _DensityChart();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           alignment: WrapAlignment.spaceBetween,
//           spacing: 12,
//           runSpacing: 4,
//           children: [
//             Text('كثافة الدخول على مدار الساعات', style: AppTextStyle.caption),
//             Text(
//               'ذروة الفترة الصباحية',
//               style: AppTextStyle.caption.copyWith(color: AppColors.primary),
//             ),
//           ],
//         ),
//         verticalSpace(10),
//         SizedBox(
//           height: 56,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               for (final v in _density)
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 2),
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: FractionallySizedBox(
//                         heightFactor: v,
//                         widthFactor: 1,
//                         child: DecoratedBox(
//                           decoration: BoxDecoration(
//                             color: v >= 0.85
//                                 ? AppColors.primary
//                                 : AppColors.surfaceContainerHigh,
//                             borderRadius: BorderRadius.circular(3),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
