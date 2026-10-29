import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/helper/extensions.dart';
import 'package:gymsystem/core/helper/timezone_helper.dart';
import 'package:intl/intl.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_spacing.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_response_model.dart';
import 'package:gymsystem/features/home/logic/attendance/attendance_table_cubit.dart';
import 'package:gymsystem/features/home/logic/attendance/attendance_table_state.dart';

// flex لكل عمود (الهيدر والصفوف بيستخدموا نفس القيم)
const _flexes = [2, 3, 3, 3, 2, 3];
const _titles = [
  'كود العضو',
  'الاسم',
  'الباقة',
  'المدرب',
  'الحالة',
  'وقت الدخول',
];

class AttendanceTable extends StatelessWidget {
  const AttendanceTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceTableCubit, AttendanceTableState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceLevel1,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: AppColors.strokeDefault),
          ),
          child: Column(
            children: [
              const _HeaderRow(),
              const Divider(height: 1, color: AppColors.strokeDefault),
              _Body(state: state),
              const Divider(height: 1, color: AppColors.strokeDefault),
              _PaginationBar(state: state),
            ],
          ),
        );
      },
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceMd,
        vertical: AppSpacing.spaceMd,
      ),
      child: Row(
        children: [
          for (var i = 0; i < _titles.length; i++)
            Expanded(
              flex: _flexes[i],
              child: Text(_titles[i], style: AppTextStyle.tableHeader),
            ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final AttendanceTableState state;
  const _Body({required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && state.items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.space2xl),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.status == AttendanceTableStatus.failure) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.space2xl),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.errorMessage ?? 'حصل خطأ',
                style: AppTextStyle.bodyMd.copyWith(color: AppColors.error),
              ),
              const SizedBox(height: AppSpacing.spaceSm),
              TextButton(
                onPressed: context.read<AttendanceTableCubit>().refresh,
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.space2xl),
        child: Center(child: Text('لا توجد نتائج', style: AppTextStyle.bodyMd)),
      );
    }

    return Stack(
      children: [
        Opacity(
          opacity: state.isLoading ? 0.5 : 1,
          child: Column(
            children: [
              for (var i = 0; i < state.items.length; i++) ...[
                _DataRow(item: state.items[i]),
                if (i != state.items.length - 1)
                  const Divider(height: 1, color: AppColors.strokeDefault),
              ],
            ],
          ),
        ),
        if (state.isLoading)
          const Positioned.fill(
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}

class _DataRow extends StatelessWidget {
  final MemberLogedinResponseModel item;
  const _DataRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final time = EgyptTime.from(item.checkInTime);
    final timeText = DateFormat('yyyy/MM/dd  hh:mm a').format(time);

    Widget cell(int i, Widget child) =>
        Expanded(flex: _flexes[i], child: child);

    Widget text(String v, {TextStyle? style}) => Text(
      v,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: style ?? AppTextStyle.tableCell,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceMd,
        vertical: AppSpacing.spaceSm + 4,
      ),
      child: Row(
        children: [
          cell(0, text(item.memberCode, style: AppTextStyle.tableCellNumeric)),
          cell(1, text(item.memberName)),
          cell(2, text(item.packageNameAtCheckIn)),
          cell(3, text(item.trainerNameAtCheckIn ?? '—')),
          cell(
            4,
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: _StatusChip(status: item.statusAtCheckIn),
            ),
          ),
          cell(5, text(timeText, style: AppTextStyle.tableCellNumeric)),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color, bg, border) = switch (status) {
      'Active' => (
        'نشط',
        AppColors.statusActive,
        AppColors.statusActiveBg,
        AppColors.statusActiveBorder,
      ),
      'EndingSoon' => (
        'ينتهي قريباً',
        AppColors.statusExpiring,
        AppColors.statusExpiringBg,
        AppColors.statusExpiringBorder,
      ),
      'Expired' => (
        'منتهي',
        AppColors.statusExpired,
        AppColors.statusExpiredBg,
        AppColors.statusExpiredBorder,
      ),
      'Frozen' => (
        'مجمد',
        AppColors.statusFrozen,
        AppColors.statusFrozenBg,
        AppColors.statusFrozenBorder,
      ),
      _ => (
        status,
        AppColors.textSecondary,
        AppColors.surfaceContainer,
        AppColors.strokeDefault,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      child: Text(label, style: AppTextStyle.statusChip(color)),
    );
  }
}

const _pageSizes = [5, 10, 20, 50];

class _PaginationBar extends StatelessWidget {
  final AttendanceTableState state;
  const _PaginationBar({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AttendanceTableCubit>();
    final totalPages = state.totalPages == 0 ? 1 : state.totalPages;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spaceMd,
        vertical: AppSpacing.spaceSm,
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.spaceMd,
        runSpacing: AppSpacing.spaceSm,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('عدد الصفوف:', style: AppTextStyle.bodySm),
              const SizedBox(width: AppSpacing.spaceSm),
              _PageSizeDropdown(
                value: state.pageSize,
                enabled: !state.isLoading,
                onChanged: cubit.changePageSize,
              ),
              const SizedBox(width: AppSpacing.spaceMd),
              Text('الإجمالي: ${state.totalCount}', style: AppTextStyle.bodySm),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: state.hasPrevious && !state.isLoading
                    ? cubit.previousPage
                    : null,
                icon: const Icon(Icons.chevron_right), // RTL: السابق
                color: AppColors.primary,
              ),
              Text(
                '${state.pageNumber} / $totalPages',
                style: AppTextStyle.labelMd,
              ),
              IconButton(
                onPressed: state.hasNext && !state.isLoading
                    ? cubit.nextPage
                    : null,
                icon: const Icon(Icons.chevron_left), // RTL: التالي
                color: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageSizeDropdown extends StatelessWidget {
  final int value;
  final bool enabled;
  final ValueChanged<int> onChanged;

  const _PageSizeDropdown({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // لو الـ pageSize مش في القايمة (مثلاً اتغير من الكود) نضيفه عشان مايحصلش assert
    final sizes = _pageSizes.contains(value)
        ? _pageSizes
        : ([..._pageSizes, value]..sort());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          isDense: true,
          dropdownColor: AppColors.surfaceContainer,
          iconEnabledColor: AppColors.primary,
          style: AppTextStyle.labelMd,
          items: [
            for (final s in sizes)
              DropdownMenuItem(value: s, child: Text('$s')),
          ],
          onChanged: enabled
              ? (v) {
                  if (v != null && v != value) onChanged(v);
                }
              : null,
        ),
      ),
    );
  }
}
