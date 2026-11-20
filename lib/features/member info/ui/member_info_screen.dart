import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/helper/timezone_helper.dart' show EgyptTime;
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/core/widgets/snakebar.dart';
import 'package:gymsystem/features/activities/data/models/member_activity_logedin_model.dart';
import 'package:gymsystem/features/home/data/models/member_logedin_response_model.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/member%20info/logic/member_info_cubit.dart';
import 'package:gymsystem/features/member%20info/logic/member_info_state.dart';
import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/gym_subscription_response_model.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;

// ───────────────────────────── Helpers ─────────────────────────────

String _date(DateTime d) => DateFormat('yyyy-MM-dd').format(EgyptTime.from(d));
String _dateTime(DateTime d) =>
    DateFormat('yyyy-MM-dd  hh:mm a').format(EgyptTime.from(d));
String _money(double v) => '${NumberFormat('#,##0.00').format(v)} ج.م';

({Color color, String label}) _statusInfo(String? s) => switch (s) {
  'Active' => (color: AppColors.statusActive, label: 'نشط'),
  'EndingSoon' => (color: AppColors.statusExpiring, label: 'على وشك الانتهاء'),
  'Expired' => (color: AppColors.statusExpired, label: 'منتهي'),
  'No Subscription' => (color: AppColors.textSecondary, label: 'بدون اشتراك'),
  _ => (color: AppColors.textSecondary, label: s ?? '—'),
};

/// الشاشة بتحتاج MemberInfoCubit متوفر فوقها (BlocProvider بره).
/// بترجّع `true` عند الرجوع لو العضو اتمسح، عشان الشاشة اللي قبلها تحدّث نفسها.
class MemberInfoScreen extends StatefulWidget {
  const MemberInfoScreen({super.key});

  @override
  State<MemberInfoScreen> createState() => _MemberInfoScreenState();
}

class _MemberInfoScreenState extends State<MemberInfoScreen> {
  int _tab = 0; // 0 = الاشتراكات, 1 = الأنشطة, 2 = سجل الحضور
  DateTime? _attendanceDay; // فلتر تاريخ سجل الحضور (null = الكل)

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final basePad = context.isMobile ? 16.0 : 28.0;
    // نخلي المحتوى في عرض أقصى 1000 من غير ما نكسر الـ scroll الكسول.
    final sidePad = math.max(basePad, (width - 1000) / 2);

    return BlocListener<MemberInfoCubit, MemberInfoState>(
      listenWhen: (p, c) =>
          p.updateStatus != c.updateStatus || p.deleteStatus != c.deleteStatus,
      listener: (context, state) {
        if (state.updateStatus == InfoStatus.success) {
          AppSnackBar.show(context, message: 'تم تحديث بيانات العضو');
        }
        if (state.deleteStatus == InfoStatus.success) {
          AppSnackBar.show(context, message: 'تم حذف العضو');
          Navigator.of(context).pop(true);
          return;
        }
        if (state.updateStatus == InfoStatus.failure ||
            state.deleteStatus == InfoStatus.failure) {
          AppSnackBar.show(
            context,
            message: state.actionError ?? 'حدث خطأ',
            type: SnackType.error,
          );
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                const _TopBar(),
                Expanded(
                  child: RefreshIndicator(
                    color: AppColors.primary,
                    backgroundColor: AppColors.surfaceContainer,
                    onRefresh: () => context.read<MemberInfoCubit>().load(),
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(
                            sidePad,
                            16,
                            sidePad,
                            12,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const _MemberHeader(),
                                verticalSpace(16),
                                _TabSwitcher(
                                  selected: _tab,
                                  onChanged: (i) => setState(() => _tab = i),
                                ),
                                if (_tab == 2) ...[
                                  verticalSpace(12),
                                  _DateFilterBar(
                                    day: _attendanceDay,
                                    onChanged: (d) =>
                                        setState(() => _attendanceDay = d),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(sidePad, 0, sidePad, 32),
                          sliver: switch (_tab) {
                            0 => const _SubscriptionsSliver(),
                            1 => const _ActivitiesSliver(),
                            _ => _AttendanceSliver(day: _attendanceDay),
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────── Top bar ─────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar();

  Future<void> _edit(BuildContext context, MemberShowCardModel member) async {
    final cubit = context.read<MemberInfoCubit>();
    final model = await showDialog<CreateMemberModel>(
      context: context,
      builder: (_) => _EditMemberDialog(member: member),
    );
    if (model != null) cubit.updateMember(model);
  }

  Future<void> _delete(BuildContext context, MemberShowCardModel member) async {
    final cubit = context.read<MemberInfoCubit>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.strokeStrong),
          ),
          title: Text('حذف العضو', style: AppTextStyle.titleMedium),
          content: Text(
            'هل تريد حذف "${member.name}" نهائياً؟ لا يمكن التراجع عن هذا الإجراء.',
            style: AppTextStyle.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'حذف',
                style: TextStyle(color: AppColors.statusExpired),
              ),
            ),
          ],
        ),
      ),
    );
    if (ok == true) cubit.deleteMember();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.strokeStrong)),
      ),
      child: Row(
        children: [
          _IconBtn(
            icon: Icons.arrow_forward_rounded,
            onTap: () => Navigator.of(context).pop(),
          ),
          horizontalSpace(12),
          Expanded(child: Text('بيانات العضو', style: AppTextStyle.titleLarge)),
          BlocBuilder<MemberInfoCubit, MemberInfoState>(
            buildWhen: (p, c) =>
                p.member != c.member ||
                p.updateStatus != c.updateStatus ||
                p.deleteStatus != c.deleteStatus,
            builder: (context, state) {
              final member = state.member;
              final busy =
                  state.updateStatus == InfoStatus.loading ||
                  state.deleteStatus == InfoStatus.loading;
              if (busy) {
                return const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.primary,
                  ),
                );
              }
              return Row(
                children: [
                  _IconBtn(
                    icon: Icons.edit_rounded,
                    color: AppColors.primary,
                    onTap: member == null ? null : () => _edit(context, member),
                  ),
                  horizontalSpace(8),
                  _IconBtn(
                    icon: Icons.delete_outline_rounded,
                    color: AppColors.statusExpired,
                    onTap: member == null
                        ? null
                        : () => _delete(context, member),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const _IconBtn({
    required this.icon,
    required this.onTap,
    this.color = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.4 : 1,
      child: Material(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: color, size: 22),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────── Header ─────────────────────────────

class _MemberHeader extends StatelessWidget {
  const _MemberHeader();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberInfoCubit, MemberInfoState>(
      buildWhen: (p, c) =>
          p.member != c.member ||
          p.memberStatus != c.memberStatus ||
          p.memberError != c.memberError,
      builder: (context, state) {
        final member = state.member;
        if (member != null) return _MemberHeaderContent(member: member);

        if (state.memberStatus == InfoStatus.failure) {
          return _ErrorBox(
            message: state.memberError ?? 'تعذر تحميل بيانات العضو',
            onRetry: () => context.read<MemberInfoCubit>().retryMember(),
          );
        }
        return const _Skeleton(height: 200);
      },
    );
  }
}

class _MemberHeaderContent extends StatelessWidget {
  final MemberShowCardModel member;
  const _MemberHeaderContent({required this.member});

  @override
  Widget build(BuildContext context) {
    final status = _statusInfo(member.subscriptionStatus);
    final hasSessions =
        (member.totalSessions ?? 0) > 0 && member.remainingSessions != null;
    final activities = member.activityNames ?? const <String>[];
    final end = member.subscriptionEndDate;
    final last = member.lastAttendanceTime;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokeStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                child: Text(
                  member.name.isEmpty ? '?' : member.name.characters.first,
                  style: AppTextStyle.titleLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: AppTextStyle.titleLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    verticalSpace(2),
                    Wrap(
                      spacing: 12,
                      children: [
                        Text(
                          '#${member.code}',
                          textDirection: TextDirection.ltr,
                          style: AppTextStyle.labelLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          member.phone,
                          textDirection: TextDirection.ltr,
                          style: AppTextStyle.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _StatusChip(color: status.color, label: status.label),
            ],
          ),
          verticalSpace(16),
          Wrap(
            spacing: 28,
            runSpacing: 14,
            children: [
              _InfoItem(
                icon: Icons.workspace_premium_rounded,
                label: 'الباقة',
                value: member.packageName ?? 'بدون باقة',
              ),
              _InfoItem(
                icon: Icons.event_rounded,
                label: 'ينتهي في',
                value: end == null ? '—' : _date(end),
              ),
              _InfoItem(
                icon: Icons.hourglass_bottom_rounded,
                label: 'المتبقي',
                value: member.remainingDays == null
                    ? '—'
                    : '${member.remainingDays} يوم',
              ),
              _InfoItem(
                icon: Icons.sports_gymnastics_rounded,
                label: 'المدرب',
                value: member.trainerName ?? 'بدون مدرب',
              ),
              _InfoItem(
                icon: Icons.history_rounded,
                label: 'آخر دخول',
                value: last == null ? 'لا يوجد' : _dateTime(last),
              ),
              _InfoItem(
                icon: Icons.person_outline_rounded,
                label: 'الجنس',
                value: member.gender.toLowerCase() == 'female' ? 'أنثى' : 'ذكر',
              ),
            ],
          ),
          if (hasSessions) ...[
            verticalSpace(16),
            _SessionsBar(
              remaining: member.remainingSessions!,
              total: member.totalSessions!,
            ),
          ],
          if (activities.isNotEmpty) ...[
            verticalSpace(14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final a in activities)
                  _StatusChip(color: AppColors.primary, label: a),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        horizontalSpace(8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyle.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              value,
              style: AppTextStyle.labelMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SessionsBar extends StatelessWidget {
  final int remaining;
  final int total;
  const _SessionsBar({required this.remaining, required this.total});

  @override
  Widget build(BuildContext context) {
    final ratio = (remaining / total).clamp(0.0, 1.0);
    final color = remaining == 0
        ? AppColors.statusExpired
        : remaining <= 2
        ? AppColors.statusExpiring
        : AppColors.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'الحصص',
              style: AppTextStyle.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            Text(
              '$remaining / $total',
              textDirection: TextDirection.ltr,
              style: AppTextStyle.labelLarge.copyWith(color: color),
            ),
          ],
        ),
        verticalSpace(6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 8,
            color: AppColors.secondary,
            backgroundColor: AppColors.strokeStrong,
          ),
        ),
      ],
    );
  }
}

// ───────────────────────────── Tabs ─────────────────────────────

class _TabSwitcher extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  const _TabSwitcher({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberInfoCubit, MemberInfoState>(
      buildWhen: (p, c) =>
          p.subscriptions.length != c.subscriptions.length ||
          p.activities.length != c.activities.length ||
          p.attendance.length != c.attendance.length,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: _TabChip(
                label: 'الاشتراكات (${state.subscriptions.length})',
                icon: Icons.card_membership_rounded,
                selected: selected == 0,
                onTap: () => onChanged(0),
              ),
            ),
            horizontalSpace(10),
            Expanded(
              child: _TabChip(
                label: 'الأنشطة (${state.activities.length})',
                icon: Icons.sports_gymnastics_rounded,
                selected: selected == 1,
                onTap: () => onChanged(1),
              ),
            ),
            horizontalSpace(10),
            Expanded(
              child: _TabChip(
                label: 'سجل الحضور (${state.attendance.length})',
                icon: Icons.fact_check_outlined,
                selected: selected == 2,
                onTap: () => onChanged(2),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _TabChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.14)
          : AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.strokeStrong,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected ? AppColors.primary : AppColors.textSecondary,
              ),
              horizontalSpace(8),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: selected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────── Subscriptions ─────────────────────────────

class _SubscriptionsSliver extends StatelessWidget {
  const _SubscriptionsSliver();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberInfoCubit, MemberInfoState>(
      buildWhen: (p, c) =>
          p.subscriptionsStatus != c.subscriptionsStatus ||
          p.subscriptions != c.subscriptions ||
          p.subscriptionsError != c.subscriptionsError,
      builder: (context, state) {
        final items = state.subscriptions;

        if (items.isEmpty) {
          if (state.subscriptionsStatus == InfoStatus.failure) {
            return SliverToBoxAdapter(
              child: _ErrorBox(
                message: state.subscriptionsError ?? 'تعذر تحميل الاشتراكات',
                onRetry: () =>
                    context.read<MemberInfoCubit>().retrySubscriptions(),
              ),
            );
          }
          if (state.subscriptionsStatus == InfoStatus.success) {
            return const SliverToBoxAdapter(
              child: _EmptyBox(message: 'لا توجد اشتراكات سابقة'),
            );
          }
          return const _SkeletonSliver();
        }

        return SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _SubscriptionTile(item: items[i]),
          ),
        );
      },
    );
  }
}

class _SubscriptionTile extends StatelessWidget {
  final GymSubscriptionResponseModel item;
  const _SubscriptionTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final status = _statusInfo(item.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.strokeStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.packageName,
                  style: AppTextStyle.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              _StatusChip(color: status.color, label: status.label),
            ],
          ),
          verticalSpace(12),
          Wrap(
            spacing: 28,
            runSpacing: 12,
            children: [
              _InfoItem(
                icon: Icons.date_range_rounded,
                label: 'الفترة',
                value: '${_date(item.startDate)}  ←  ${_date(item.endDate)}',
              ),
              _InfoItem(
                icon: Icons.payments_outlined,
                label: 'المدفوع',
                value: _money(item.paidAmount),
              ),
              _InfoItem(
                icon: Icons.fitness_center_rounded,
                label: 'الحصص',
                value: '${item.remainingSessions} / ${item.totalSessions}',
              ),
              _InfoItem(
                icon: Icons.sports_gymnastics_rounded,
                label: 'المدرب',
                value: item.trainerName ?? 'بدون مدرب',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── Activities ─────────────────────────────

class _ActivitiesSliver extends StatelessWidget {
  const _ActivitiesSliver();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberInfoCubit, MemberInfoState>(
      buildWhen: (p, c) =>
          p.activitiesStatus != c.activitiesStatus ||
          p.activities != c.activities ||
          p.activitiesError != c.activitiesError,
      builder: (context, state) {
        final items = state.activities;

        if (items.isEmpty) {
          if (state.activitiesStatus == InfoStatus.failure) {
            return SliverToBoxAdapter(
              child: _ErrorBox(
                message: state.activitiesError ?? 'تعذر تحميل الأنشطة',
                onRetry: () =>
                    context.read<MemberInfoCubit>().retryActivities(),
              ),
            );
          }
          if (state.activitiesStatus == InfoStatus.success) {
            return const SliverToBoxAdapter(
              child: _EmptyBox(message: 'العضو غير مشترك في أي نشاط'),
            );
          }
          return const _SkeletonSliver();
        }

        return SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _ActivityTile(item: items[i]),
          ),
        );
      },
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final MemberActivityLogedinModel item;
  const _ActivityTile({required this.item});

  /// الحالة المعروضة: الحصص خلصت أو الاشتراك انتهى أو حالة السيرفر.
  ({Color color, String label}) get _status {
    if (item.remainingDays < 0 || item.status == 'Expired') {
      return (color: AppColors.statusExpired, label: 'منتهي');
    }
    if (item.totalSessions > 0 && item.remainingSessions <= 0) {
      return (color: AppColors.statusExpired, label: 'انتهت الحصص');
    }
    if (item.remainingDays <= 7) {
      return (color: AppColors.statusExpiring, label: 'على وشك الانتهاء');
    }
    return _statusInfo(item.status);
  }

  @override
  Widget build(BuildContext context) {
    final status = _status;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.strokeStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.activityName,
                  style: AppTextStyle.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              _StatusChip(color: status.color, label: status.label),
            ],
          ),
          verticalSpace(12),
          Wrap(
            spacing: 28,
            runSpacing: 12,
            children: [
              _InfoItem(
                icon: Icons.event_rounded,
                label: 'ينتهي في',
                value: _date(item.endDate),
              ),
              _InfoItem(
                icon: Icons.hourglass_bottom_rounded,
                label: 'المتبقي',
                value: item.remainingDays < 0
                    ? 'منتهي'
                    : '${item.remainingDays} يوم',
              ),
              _InfoItem(
                icon: Icons.payments_outlined,
                label: 'السعر',
                value: _money(item.price),
              ),
              _InfoItem(
                icon: Icons.fitness_center_rounded,
                label: 'الحصص',
                value: '${item.remainingSessions} / ${item.totalSessions}',
              ),
            ],
          ),
          if (item.totalSessions > 0) ...[
            verticalSpace(14),
            _SessionsBar(
              remaining: item.remainingSessions.clamp(0, item.totalSessions),
              total: item.totalSessions,
            ),
          ],
        ],
      ),
    );
  }
}

// ───────────────────────────── Attendance ─────────────────────────────

class _AttendanceSliver extends StatelessWidget {
  /// لو متحدد: بنعرض حضور اليوم ده بس (بتوقيت مصر).
  final DateTime? day;
  const _AttendanceSliver({this.day});

  bool _sameDay(DateTime checkIn) {
    final d = EgyptTime.from(checkIn);
    return d.year == day!.year && d.month == day!.month && d.day == day!.day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberInfoCubit, MemberInfoState>(
      buildWhen: (p, c) =>
          p.attendanceStatus != c.attendanceStatus ||
          p.attendance != c.attendance ||
          p.attendanceError != c.attendanceError,
      builder: (context, state) {
        final all = state.attendance;

        if (all.isEmpty) {
          if (state.attendanceStatus == InfoStatus.failure) {
            return SliverToBoxAdapter(
              child: _ErrorBox(
                message: state.attendanceError ?? 'تعذر تحميل سجل الحضور',
                onRetry: () =>
                    context.read<MemberInfoCubit>().retryAttendance(),
              ),
            );
          }
          if (state.attendanceStatus == InfoStatus.success) {
            return const SliverToBoxAdapter(
              child: _EmptyBox(message: 'لا يوجد سجل حضور'),
            );
          }
          return const _SkeletonSliver();
        }

        final items = day == null
            ? all
            : all.where((a) => _sameDay(a.checkInTime)).toList();

        if (items.isEmpty) {
          return SliverToBoxAdapter(
            child: _EmptyBox(
              message:
                  'لا يوجد حضور بتاريخ ${DateFormat('yyyy-MM-dd').format(day!)}',
            ),
          );
        }

        return SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _AttendanceTile(item: items[i]),
          ),
        );
      },
    );
  }
}

/// شريط البحث بتاريخ معين في سجل الحضور.
class _DateFilterBar extends StatelessWidget {
  final DateTime? day;
  final ValueChanged<DateTime?> onChanged;
  const _DateFilterBar({required this.day, required this.onChanged});

  Future<void> _pick(BuildContext context) async {
    final now = EgyptTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: day ?? DateTime(now.year, now.month, now.day),
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year, now.month, now.day),
      helpText: 'اختر تاريخ الحضور',
    );
    if (picked != null) {
      onChanged(DateTime(picked.year, picked.month, picked.day));
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = EgyptTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isToday = day != null && day == today;
    final has = day != null;

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Material(
          color: has
              ? AppColors.primary.withValues(alpha: 0.14)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _pick(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: has ? AppColors.primary : AppColors.strokeStrong,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 18,
                    color: has ? AppColors.primary : AppColors.textSecondary,
                  ),
                  horizontalSpace(8),
                  Text(
                    has
                        ? DateFormat('yyyy-MM-dd').format(day!)
                        : 'ابحث بتاريخ معين',
                    textDirection: TextDirection.ltr,
                    style: AppTextStyle.labelLarge.copyWith(
                      color: has ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ActionChip(
          label: Text(
            'اليوم',
            style: AppTextStyle.labelMedium.copyWith(
              color: isToday ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
          backgroundColor: AppColors.surface,
          side: BorderSide(
            color: isToday ? AppColors.primary : AppColors.strokeStrong,
          ),
          onPressed: () => onChanged(today),
        ),
        if (has)
          TextButton.icon(
            onPressed: () => onChanged(null),
            icon: const Icon(Icons.close_rounded, size: 18),
            label: const Text('عرض الكل'),
          ),
      ],
    );
  }
}

class _AttendanceTile extends StatelessWidget {
  final MemberLogedinResponseModel item;
  const _AttendanceTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final status = _statusInfo(item.statusAtCheckIn);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokeStrong),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.login_rounded,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _dateTime(item.checkInTime),
                  textDirection: TextDirection.ltr,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  [
                    item.packageNameAtCheckIn,
                    if (item.trainerNameAtCheckIn != null)
                      item.trainerNameAtCheckIn!,
                  ].join(' • '),
                  style: AppTextStyle.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          _StatusChip(color: status.color, label: status.label),
        ],
      ),
    );
  }
}

// ───────────────────────────── Shared small widgets ─────────────────────────────

class _StatusChip extends StatelessWidget {
  final Color color;
  final String label;
  const _StatusChip({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: AppTextStyle.labelMedium.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  final double height;
  const _Skeleton({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.strokeDefault),
      ),
    );
  }
}

class _SkeletonSliver extends StatelessWidget {
  const _SkeletonSliver();

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 3,
      itemBuilder: (_, __) => const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: _Skeleton(height: 88),
      ),
    );
  }
}

class _EmptyBox extends StatelessWidget {
  final String message;
  const _EmptyBox({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.strokeStrong),
      ),
      child: Text(
        message,
        style: AppTextStyle.labelMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorBox({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.statusExpired.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.statusExpired.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.statusExpired,
            size: 32,
          ),
          verticalSpace(8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyle.labelMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          verticalSpace(8),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── Edit dialog ─────────────────────────────

class _EditMemberDialog extends StatefulWidget {
  final MemberShowCardModel member;
  const _EditMemberDialog({required this.member});

  @override
  State<_EditMemberDialog> createState() => _EditMemberDialogState();
}

class _EditMemberDialogState extends State<_EditMemberDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _phone;
  final _emergency = TextEditingController();
  final _email = TextEditingController();
  final _dob = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.member.name);
    _phone = TextEditingController(text: widget.member.phone);
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _emergency.dispose();
    _email.dispose();
    _dob.dispose();
    super.dispose();
  }

  InputDecoration _dec(String label) => InputDecoration(
    labelText: label,
    labelStyle: AppTextStyle.caption.copyWith(color: AppColors.textSecondary),
    filled: true,
    fillColor: AppColors.surfaceDim,
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.strokeStrong),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
  );

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'مطلوب' : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    String? orNull(TextEditingController c) =>
        c.text.trim().isEmpty ? null : c.text.trim();

    Navigator.of(context).pop(
      CreateMemberModel(
        code: widget.member.code,
        name: _name.text.trim(),
        gender: widget.member.gender.toLowerCase() == 'female' ? 2 : 1,
        phone: _phone.text.trim(),
        emergencyPhone: orNull(_emergency),
        email: _email.text.trim(),
        dateOfBirth: orNull(_dob),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyle.labelLarge.copyWith(
      color: AppColors.textPrimary,
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.strokeStrong),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('تعديل بيانات العضو', style: AppTextStyle.titleMedium),
                  verticalSpace(16),
                  TextFormField(
                    controller: _name,
                    style: style,
                    decoration: _dec('الاسم'),
                    validator: _required,
                  ),
                  verticalSpace(12),
                  TextFormField(
                    controller: _phone,
                    style: style,
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    decoration: _dec('رقم الهاتف'),
                    validator: _required,
                  ),
                  verticalSpace(12),
                  TextFormField(
                    controller: _emergency,
                    style: style,
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
                    decoration: _dec('هاتف الطوارئ (اختياري)'),
                  ),
                  verticalSpace(12),
                  TextFormField(
                    controller: _email,
                    style: style,
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                    decoration: _dec('البريد الإلكتروني'),
                  ),
                  verticalSpace(12),
                  TextFormField(
                    controller: _dob,
                    style: style,
                    textDirection: TextDirection.ltr,
                    decoration: _dec('تاريخ الميلاد (yyyy-MM-dd) اختياري'),
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.textOnPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: _submit,
                          child: const Text('حفظ'),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('إلغاء'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
