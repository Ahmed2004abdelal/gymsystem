import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gymsystem/core/helper/extensions.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/helper/timezone_helper.dart' show EgyptTime;
import 'package:gymsystem/core/routing/routes.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/home/logic/reception_cubit.dart';
import 'package:gymsystem/features/home/logic/reception_state.dart';
import 'package:intl/intl.dart' show DateFormat;

bool _sessionsExhausted(MemberShowCardModel m) =>
    m.totalSessions != null &&
    m.totalSessions! > 0 &&
    (m.remainingSessions ?? 0) <= 0;

/// يعرض بطاقة العضو لو في عضو، وإلا يعرض placeholder (أو loading / خطأ).
class MemberCard extends StatelessWidget {
  const MemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceptionCubit, ReceptionState>(
      builder: (context, state) {
        final isLoading =
            state.memberCheckinStatus == ReceptionStatus.loading ||
            state.memberShowCardStatus == ReceptionStatus.loading;
        if (isLoading) return const _MemberPlaceholder(isLoading: true);

        final hasError =
            state.memberCheckinStatus == ReceptionStatus.failure ||
            state.memberShowCardStatus == ReceptionStatus.failure;
        if (hasError) {
          return _MemberPlaceholder(errorMessage: state.errorMessage);
        }

        final member = state.memberShowCardData;
        if (member == null) return const _MemberPlaceholder();

        return _MemberCardContent(member: member);
      },
    );
  }
}

// ───────────────────────────── Placeholder ─────────────────────────────

class _MemberPlaceholder extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;

  const _MemberPlaceholder({this.isLoading = false, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final hasError = errorMessage != null;

    final String title = isLoading
        ? 'جاري التحقق من العضو...'
        : hasError
        ? 'تعذر تحميل بيانات العضو'
        : 'لا يوجد عضو حالياً';
    final String subtitle = hasError
        ? errorMessage!
        : 'امسح بطاقة العضو أو أدخل الكود لعرض بياناته هنا';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading)
            const SpinKitFadingCircle(color: AppColors.primary, size: 48)
          else
            Icon(
              hasError ? Icons.error_outline_rounded : Icons.badge_outlined,
              size: 56,
              color: hasError
                  ? AppColors.statusExpired
                  : AppColors.textTertiary,
            ),
          verticalSpace(12),
          Text(title, style: AppTextStyle.titleMedium),
          verticalSpace(4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyle.caption,
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── Status ─────────────────────────────

enum _SubStatus { active, expiring, expired, none }

/// الحالة بتتحسب من subscriptionStatus والباقة وعدد الأيام المتبقية.
_SubStatus _statusOf(MemberShowCardModel m) {
  if (m.subscriptionStatus == 'No Subscription' ||
      (m.packageName == null && m.subscriptionEndDate == null)) {
    return _SubStatus.none;
  }
  final days = m.remainingDays ?? 0;
  if (days <= 0) return _SubStatus.expired;
  if (days <= 7) return _SubStatus.expiring;
  return _SubStatus.active;
}

class _StatusStyle {
  final Color color;
  final Color bg;
  final Color border;
  final IconData chipIcon;
  final IconData passIcon;
  final String chipText;
  final String passTitle;
  final String passMessage;
  final String passTag;

  const _StatusStyle({
    required this.color,
    required this.bg,
    required this.border,
    required this.chipIcon,
    required this.passIcon,
    required this.chipText,
    required this.passTitle,
    required this.passMessage,
    required this.passTag,
  });
}

_StatusStyle _styleOf(_SubStatus s) {
  switch (s) {
    case _SubStatus.active:
      return const _StatusStyle(
        color: AppColors.statusActive,
        bg: AppColors.statusActiveBg,
        border: AppColors.statusActiveBorder,
        chipIcon: Icons.check_circle_outline_rounded,
        passIcon: Icons.meeting_room_rounded,
        chipText: 'اشتراك نشط وصالح',
        passTitle: 'تصريح دخول فوري مسموح به',
        passMessage: 'الاشتراك ساري ويمكن للعضو دخول الصالة',
        passTag: 'PASS:\nVALID',
      );
    case _SubStatus.expiring:
      return const _StatusStyle(
        color: AppColors.statusExpiring,
        bg: AppColors.statusExpiringBg,
        border: AppColors.statusExpiringBorder,
        chipIcon: Icons.warning_amber_rounded,
        passIcon: Icons.meeting_room_rounded,
        chipText: 'الاشتراك على وشك الانتهاء',
        passTitle: 'الدخول مسموح مع تنبيه بالتجديد',
        passMessage: 'يرجى تنبيه العضو بقرب انتهاء الاشتراك',
        passTag: 'PASS:\nEXPIRING',
      );
    case _SubStatus.expired:
      return _StatusStyle(
        color: AppColors.statusExpired,
        bg: AppColors.statusExpired.withValues(alpha: 0.12),
        border: AppColors.statusExpired.withValues(alpha: 0.35),
        chipIcon: Icons.cancel_outlined,
        passIcon: Icons.no_meeting_room_rounded,
        chipText: 'الاشتراك منتهي',
        passTitle: 'الدخول غير مسموح',
        passMessage: 'يجب تجديد الاشتراك قبل دخول الصالة',
        passTag: 'PASS:\nDENIED',
      );
    case _SubStatus.none:
      return _StatusStyle(
        color: AppColors.statusExpired,
        bg: AppColors.statusExpired.withValues(alpha: 0.12),
        border: AppColors.statusExpired.withValues(alpha: 0.35),
        chipIcon: Icons.block_rounded,
        passIcon: Icons.no_meeting_room_rounded,
        chipText: 'لا يوجد اشتراك',
        passTitle: 'الدخول غير مسموح',
        passMessage: 'العضو مسجل لكن ليس لديه اشتراك فعّال',
        passTag: 'PASS:\nDENIED',
      );
  }
}

// ───────────────────────────── Card ─────────────────────────────

class _MemberCardContent extends StatelessWidget {
  final MemberShowCardModel member;
  const _MemberCardContent({required this.member});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final status = _statusOf(member);
    final style = _styleOf(status);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.strokeDefault),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(member: member, style: style),
                  verticalSpace(16),
                  if (isMobile) ...[
                    Center(child: _Photo(style: style)),
                    verticalSpace(16),
                    _Info(member: member, status: status, style: style),
                  ] else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _Info(
                            member: member,
                            status: status,
                            style: style,
                          ),
                        ),
                        const SizedBox(width: 20),
                        _Photo(style: style),
                      ],
                    ),
                  verticalSpace(16),
                  _PassBanner(style: style),
                  verticalSpace(16),
                  _Actions(member: member),
                ],
              ),
            ),
            // Accent bar on the end edge (left in RTL)
            PositionedDirectional(
              top: 0,
              bottom: 0,
              end: 0,
              child: SizedBox(width: 5, child: ColoredBox(color: style.color)),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────── Header ─────────────────────────────

class _Header extends StatelessWidget {
  final MemberShowCardModel member;
  final _StatusStyle style;
  const _Header({required this.member, required this.style});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 8,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('بطاقة العضو المحققة', style: AppTextStyle.caption),
            horizontalSpace(10),
            Text(
              '#${member.code}',
              textDirection: TextDirection.ltr,
              style: AppTextStyle.titleLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: style.bg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: style.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(style.chipIcon, size: 16, color: style.color),
              horizontalSpace(6),
              Text(
                style.chipText,
                style: AppTextStyle.labelMedium.copyWith(color: style.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ───────────────────────────── Info ─────────────────────────────

class _Info extends StatelessWidget {
  final MemberShowCardModel member;
  final _SubStatus status;
  final _StatusStyle style;

  const _Info({
    required this.member,
    required this.status,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final lastAttendance = member.lastAttendanceTime == null
        ? 'لا يوجد'
        : DateFormat('yyyy-MM-dd  hh:mm a')
              .format(EgyptTime.from(member.lastAttendanceTime!));

    final hasSessions =
        member.totalSessions != null &&
        member.remainingSessions != null &&
        member.totalSessions! > 0;
    final activities = member.activityNames ?? const <String>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          member.name,
          style: AppTextStyle.displaySmall.copyWith(
            fontSize: 36 * context.scale,
          ),
        ),
        verticalSpace(2),
        Text(
          member.phone,
          textDirection: TextDirection.ltr,
          style: AppTextStyle.caption,
        ),
        verticalSpace(10),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.workspace_premium_rounded,
              size: 18,
              color: AppColors.primary,
            ),
            Text(
              member.packageName ?? 'بدون باقة',
              style: AppTextStyle.labelLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        verticalSpace(14),
        _DatesBlock(member: member, status: status, style: style),
        if (hasSessions) ...[
          verticalSpace(10),
          _SessionsBlock(
            remaining: member.remainingSessions!,
            total: member.totalSessions!,
          ),
        ],
        if (activities.isNotEmpty) ...[
          verticalSpace(10),
          _ActivitiesBlock(names: activities),
        ],
        verticalSpace(14),
        Wrap(
          spacing: 22,
          runSpacing: 12,
          children: [
            _Meta(
              icon: Icons.sports_gymnastics_rounded,
              label: 'المدرب الخاص:',
              value: member.trainerName ?? 'بدون مدرب',
            ),
            _Meta(
              icon: Icons.history_rounded,
              label: 'آخر دخول:',
              value: lastAttendance,
            ),
          ],
        ),
      ],
    );
  }
}

class _DatesBlock extends StatelessWidget {
  final MemberShowCardModel member;
  final _SubStatus status;
  final _StatusStyle style;

  const _DatesBlock({
    required this.member,
    required this.status,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final end = member.subscriptionEndDate;
    final endText = end == null ? '—' : DateFormat('yyyy-MM-dd').format(end);

    final days = member.remainingDays ?? 0;
    final remainingText = switch (status) {
      _SubStatus.none => '—',
      _SubStatus.expired => 'منتهي',
      _ => 'متبقي $days يوماً',
    };
    final remainingColor = status == _SubStatus.active
        ? AppColors.textPrimary
        : style.color;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceDim,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 24,
        runSpacing: 12,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('تاريخ الانتهاء', style: AppTextStyle.caption),
              verticalSpace(2),
              Text(
                endText,
                textDirection: TextDirection.ltr,
                style: AppTextStyle.headlineMedium,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('المدة المتبقية', style: AppTextStyle.caption),
              verticalSpace(6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.hourglass_bottom_rounded,
                    size: 18,
                    color: remainingColor,
                  ),
                  horizontalSpace(6),
                  Text(
                    remainingText,
                    style: AppTextStyle.titleLarge.copyWith(
                      color: remainingColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _Meta({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        horizontalSpace(8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyle.caption),
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

// ───────────────────────────── Photo ─────────────────────────────

/// Placeholder. Replace the Icon with Image.network(...) later.
class _Photo extends StatelessWidget {
  final _StatusStyle style;
  const _Photo({required this.style});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 170,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.strokeStrong),
            gradient: const LinearGradient(
              colors: [AppColors.surfaceContainer, AppColors.surfaceDim],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Icon(
            Icons.person_rounded,
            size: 72,
            color: AppColors.textTertiary,
          ),
        ),
        PositionedDirectional(
          bottom: -12,
          start: 10,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: style.color,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surface, width: 3),
            ),
            child: Icon(
              style.chipIcon,
              size: 16,
              color: AppColors.textOnPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

// ───────────────────────────── Pass banner ─────────────────────────────

class _PassBanner extends StatelessWidget {
  final _StatusStyle style;
  const _PassBanner({required this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: style.border),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: style.color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(style.passIcon, size: 22, color: style.color),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style.passTitle,
                  style: AppTextStyle.labelLarge.copyWith(color: style.color),
                ),
                Text(
                  style.passMessage,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: style.color.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          horizontalSpace(12),
          Text(
            style.passTag,
            textDirection: TextDirection.ltr,
            style: AppTextStyle.titleMedium.copyWith(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              color: style.color,
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── Actions ─────────────────────────────

class _Actions extends StatelessWidget {
  final MemberShowCardModel member;
  const _Actions({required this.member});

  void _logedin(BuildContext context) {
    context.read<ReceptionCubit>().memberLogedin();
  }

  @override
  Widget build(BuildContext context) {
    final isLoggingIn =
        context.watch<ReceptionCubit>().state.memberLogedinStatus ==
        ReceptionStatus.loading;
    final exhausted = _sessionsExhausted(member);

    final Widget checkIn = exhausted
        ? const _NoSessionsNotice()
        : _ActionButton(
            label: isLoggingIn ? 'جاري تسجيل الدخول...' : 'تسجيل دخول العضو',
            icon: Icons.check_circle_outline_rounded,
            onTap: isLoggingIn ? null : () => _logedin(context),
            primary: true,
          );
    final renew = _ActionButton(
      label: 'تجديد الاشتراك',
      icon: Icons.desktop_windows_outlined,
      onTap: () {
        context.pushNamed(
          Routes.renewSubscriptionScreen,
          arguments: {
            'member': member,
            'receptionCubit': context.read<ReceptionCubit>(),
          },
        );
      },
    );
    final pay = _ActionButton(
      label: 'تجديد بنفس الباقه',
      icon: Icons.repeat,
      onTap: () => context.read<ReceptionCubit>().renewSubscription(),
    );

    if (context.isMobile) {
      return Column(
        children: [checkIn, verticalSpace(10), renew, verticalSpace(10), pay],
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 5, child: checkIn),
          horizontalSpace(10),
          Expanded(flex: 4, child: renew),
          horizontalSpace(10),
          Expanded(flex: 4, child: pay),
        ],
      ),
    );
  }
}

class _NoSessionsNotice extends StatelessWidget {
  const _NoSessionsNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.statusExpired.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.statusExpired.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.block_rounded,
            size: 18,
            color: AppColors.statusExpired,
          ),
          horizontalSpace(8),
          Flexible(
            child: Text(
              'ممنوع تسجيل الدخول، تم نفاد الحصص المتاحة',
              textAlign: TextAlign.center,
              style: AppTextStyle.labelMedium.copyWith(
                color: AppColors.statusExpired,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool primary;
  final void Function()? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    final fg = primary ? AppColors.textOnPrimary : AppColors.textPrimary;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: primary
            ? const [
                BoxShadow(
                  color: AppColors.glowActive,
                  blurRadius: 20,
                  spreadRadius: -4,
                ),
              ]
            : null,
      ),
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: primary ? AppColors.primary : AppColors.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: primary
              ? BorderSide.none
              : const BorderSide(color: AppColors.strokeStrong),
        ),
        child: InkWell(
          onTap: () => onTap?.call(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: fg),
                horizontalSpace(8),
                Flexible(
                  child: Text(
                    label,
                    style: AppTextStyle.buttonMedium.copyWith(color: fg),
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

class _SessionsBlock extends StatelessWidget {
  final int remaining;
  final int total;

  const _SessionsBlock({required this.remaining, required this.total});

  @override
  Widget build(BuildContext context) {
    final used = (total - remaining).clamp(0, total);
    final ratio = (remaining / total).clamp(0.0, 1.0);
    final low = remaining <= 2;
    final color = remaining == 0
        ? AppColors.statusExpired
        : low
        ? AppColors.statusExpiring
        : AppColors.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceDim,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.fitness_center_rounded, size: 16, color: color),
              horizontalSpace(8),
              Text('الحصص', style: AppTextStyle.caption),
              const Spacer(),
              Text(
                '$remaining / $total',
                textDirection: TextDirection.ltr,
                style: AppTextStyle.titleMedium.copyWith(color: color),
              ),
            ],
          ),
          verticalSpace(8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
              color: color,
              backgroundColor: AppColors.strokeDefault,
            ),
          ),
          verticalSpace(6),
          Text(
            'المستخدم: $used • المتبقي: $remaining',
            style: AppTextStyle.caption,
          ),
        ],
      ),
    );
  }
}

class _ActivitiesBlock extends StatelessWidget {
  final List<String> names;
  const _ActivitiesBlock({required this.names});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceDim,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الأنشطة', style: AppTextStyle.caption),
          verticalSpace(8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final name in names)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.strokeStrong),
                  ),
                  child: Text(
                    name,
                    style: AppTextStyle.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
