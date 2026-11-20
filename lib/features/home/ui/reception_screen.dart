import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/helper/extensions.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/routing/routes.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/core/widgets/date_time_badge.dart';
import 'package:gymsystem/core/widgets/snakebar.dart';
import 'package:gymsystem/features/home/logic/reception_cubit.dart';
import 'package:gymsystem/features/home/logic/reception_state.dart';
import 'package:gymsystem/features/home/ui/widgets/live_log_card.dart';
import 'package:gymsystem/features/home/ui/widgets/member_card.dart';
import 'package:gymsystem/features/home/ui/widgets/scanner_card.dart';

/// الـ ReceptionCubit لازم يكون متوفر فوق الشاشة دي (BlocProvider بره).
class ReceptionScreen extends StatelessWidget {
  const ReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final pad = Responsive.value(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    final mainColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SessionCheckBlockListener(),
        const _TopInfo(),
        verticalSpace(16),
        const ScannerCard(),
        verticalSpace(16),
        const MemberCard(),
        if (!isDesktop) ...[verticalSpace(16), const LiveLogCard()],
      ],
    );

    return BlocListener<ReceptionCubit, ReceptionState>(
      listenWhen: (p, c) => p.memberCheckinStatus != c.memberCheckinStatus,
      listener: (context, state) {
        // الكود مش متسجل -> شاشة تسجيل عضو جديد
        if (state.memberCheckinStatus == ReceptionStatus.success &&
            state.memberCheckinData?.exists == false) {
          context.pushNamed(
            Routes.registerMember,
            arguments: state.memberCheckinData?.memberCode,
          );
        }
        if (state.memberCheckinStatus == ReceptionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'حدث خطأ')),
          );
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(pad),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1600),
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First child = right side in RTL
                            Expanded(flex: 6, child: mainColumn),
                            horizontalSpace(16),
                            const Expanded(flex: 4, child: LiveLogCard()),
                          ],
                        )
                      : mainColumn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopInfo extends StatelessWidget {
  const _TopInfo();

  // void refreshLiveAttendance(BuildContext context) {
  //   context.read<ReceptionCubit>().liveAttendance();
  // }

  // جوه _TopInfo
  void _onSingleSession(BuildContext context) {
    context.read<ReceptionCubit>().sessionCheckIn();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //   decoration: BoxDecoration(
        //     color: AppColors.surfaceVariant,
        //     borderRadius: BorderRadius.circular(100),
        //   ),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       const CircleAvatar(backgroundColor: AppColors.primary, radius: 5),
        //       horizontalSpace(8),
        // GestureDetector(
        //   onTap: () => refreshLiveAttendance(context),
        //   child: Text.rich(
        //     TextSpan(
        //       children: [
        //         TextSpan(
        //           text: 'داخل الصالة الآن',
        //           style: AppTextStyle.bodyMedium,
        //         ),
        //         TextSpan(
        //           text:
        //               '  ${context.watch<ReceptionCubit>().state.liveAttendanceData?.length ?? 0} عضو',
        //           style: AppTextStyle.titleMedium.copyWith(
        //             color: AppColors.primary,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        //       SessionCheckBlockListener(),
        //     ],
        //   ),
        // ),
        const EgyptDateTimeBadge(),
        _SingleSessionButton(
          fee: context.select<ReceptionCubit, double?>(
            (c) => c.state.sessionFee,
          ),
          onTap: () => _onSingleSession(context),
        ),
      ],
    );
  }
}

class _SingleSessionButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? fee;
  const _SingleSessionButton({required this.onTap, this.fee});

  String get _label {
    if (fee == null) return 'اضافة حصه فرديه';
    final v = fee! == fee!.roundToDouble()
        ? fee!.toStringAsFixed(0)
        : fee!.toStringAsFixed(2);
    return 'اضافة حصه فرديه • $v ج.م';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Text(
            _label,
            style: AppTextStyle.buttonMedium.copyWith(
              color: AppColors.textOnPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class SessionCheckBlockListener extends StatelessWidget {
  const SessionCheckBlockListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceptionCubit, ReceptionState>(
      listenWhen: (p, c) =>
          p.sessionsCheckInStatus != c.sessionsCheckInStatus ||
          p.renewSubscriptionStatus != c.renewSubscriptionStatus,
      listener: (context, state) {
        if (state.sessionsCheckInStatus == ReceptionStatus.success) {
          AppSnackBar.show(
            context,
            message: 'تم اضافة الحصه الفرديه بنجاح',
            type: SnackType.success,
          );
        } else if (state.sessionsCheckInStatus == ReceptionStatus.failure) {
          AppSnackBar.show(
            context,
            message: state.errorMessage ?? 'حدث خطأ',
            type: SnackType.error,
          );
        }
        if (state.renewSubscriptionStatus == ReceptionStatus.success) {
          AppSnackBar.show(
            context,
            message: 'تم تجديد الاشتراك بنجاح',
            type: SnackType.success,
          );
        } else if (state.renewSubscriptionStatus == ReceptionStatus.failure) {
          AppSnackBar.show(
            context,
            message: state.errorMessage ?? 'حدث خطأ',
            type: SnackType.error,
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
