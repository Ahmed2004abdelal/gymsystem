import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/helper/extensions.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/features/home/logic/attendance/attendance_table_cubit.dart';
import 'package:gymsystem/features/home/logic/attendance/attendance_table_state.dart';
import 'package:gymsystem/features/home/ui/widgets/attendance_table.dart';

/// الـ AttendanceTableCubit لازم يتوفر فوق الشاشة دي (BlocProvider بره).
/// ما تنادي loadPage في create بتاع الـ BlocProvider، الشاشة بتناديها بنفسها.
class AttendanceTableScreen extends StatefulWidget {
  const AttendanceTableScreen({super.key});

  @override
  State<AttendanceTableScreen> createState() => _AttendanceTableScreenState();
}

class _AttendanceTableScreenState extends State<AttendanceTableScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AttendanceTableCubit>().loadPage(1);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _refresh() {
    _searchCtrl.clear();
    context.read<AttendanceTableCubit>().clearFilters(); // بيحمّل أول صفحة
  }

  @override
  Widget build(BuildContext context) {
    final scale = context.scale;
    final pad = Responsive.value(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    return Padding(
      padding: EdgeInsets.all(pad),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(pad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _searchCtrl,
                        onChanged: context
                            .read<AttendanceTableCubit>()
                            .setTrainerName,
                        style: AppTextStyle.inputText.copyWith(
                          fontSize: 18 * scale,
                        ),
                        decoration: InputDecoration(
                          hintText: 'بحث باسم المدرب',
                          hintStyle: AppTextStyle.inputHint.copyWith(
                            fontSize: 16 * scale,
                          ),
                          fillColor: AppColors.surfaceContainerLow,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.textSecondary,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace(12),
                    Material(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: _refresh,
                        child: Padding(
                          padding: EdgeInsets.all(14 * scale),
                          child: Icon(
                            Icons.refresh_rounded,
                            size: 24 * scale,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(16),
                const _AttendanceFilters(),
                verticalSpace(20),
                const SizedBox(
                  width: double.infinity,
                  child: AttendanceTable(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Filters (period / gender / has trainer)
// ---------------------------------------------------------------------------
extension on AttendancePeriod {
  String get label => switch (this) {
    AttendancePeriod.today => 'اليوم',
    AttendancePeriod.thisWeek => 'هذا الأسبوع',
    AttendancePeriod.thisMonth => 'هذا الشهر',
  };
}

extension on AttendanceGender {
  String get label => switch (this) {
    AttendanceGender.male => 'ذكر',
    AttendanceGender.female => 'أنثى',
  };
}

class _AttendanceFilters extends StatelessWidget {
  const _AttendanceFilters();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AttendanceTableCubit>();

    return BlocBuilder<AttendanceTableCubit, AttendanceTableState>(
      buildWhen: (p, c) =>
          p.period != c.period ||
          p.gender != c.gender ||
          p.hasTrainer != c.hasTrainer,
      builder: (context, s) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final p in AttendancePeriod.values)
              _FilterChip(
                label: p.label,
                selected: s.period == p,
                onTap: () => cubit.setPeriod(s.period == p ? null : p),
              ),
            for (final g in AttendanceGender.values)
              _FilterChip(
                label: g.label,
                selected: s.gender == g,
                onTap: () => cubit.setGender(s.gender == g ? null : g),
              ),
            _FilterChip(
              label: 'بمدرب',
              selected: s.hasTrainer == true,
              onTap: () =>
                  cubit.setHasTrainer(s.hasTrainer == true ? null : true),
            ),
          ],
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      labelStyle: AppTextStyle.labelMd.copyWith(
        color: selected ? AppColors.neonLime : AppColors.textSecondary,
      ),
      backgroundColor: AppColors.surfaceContainerLow,
      selectedColor: AppColors.neonLimeBg,
      side: BorderSide(
        color: selected ? AppColors.neonLime : AppColors.strokeDefault,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
