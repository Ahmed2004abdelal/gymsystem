import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/core/widgets/snakebar.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/home/logic/reception_cubit.dart';
import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';
import 'package:gymsystem/features/register%20screen/logic/register/register_member_cubit.dart';
import 'package:gymsystem/features/register%20screen/logic/register/register_member_state.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;

// ─────────── الحقول اللي بنقرأها من PackageModel (عدّلها لو الأسماء مختلفة) ───────────
String _pkgName(PackageModel p) => p.name;
double _pkgPrice(PackageModel p) => (p.price as num).toDouble();
// ─────────────────────────────────────────────────────────────────────────────────

/// لازم يتوفر فوقها: ReceptionCubit و RegisterMemberCubit (مثيل جديد للصفحة دي).
class RenewSubscriptionScreen extends StatelessWidget {
  final MemberShowCardModel member;
  const RenewSubscriptionScreen({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final pad = isMobile ? 16.0 : 28.0;

    return BlocListener<RegisterMemberCubit, RegisterMemberState>(
      listenWhen: (p, c) => p.subscriptionStatus != c.subscriptionStatus,
      listener: (context, state) {
        if (state.subscriptionStatus == RegisterStatus.success) {
          // نحدّث بطاقة العضو بالاشتراك الجديد ونرجع.
          context.read<ReceptionCubit>().memberShowCard(member.code);
          AppSnackBar.show(context, message: 'تم تجديد الاشتراك بنجاح');
          Navigator.of(context).pop();
        } else if (state.subscriptionStatus == RegisterStatus.failure) {
          AppSnackBar.show(
            context,
            message: state.errorMessage ?? 'حدث خطأ',
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
                _Header(member: member),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(pad),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _PackagesSection(member: member),
                            verticalSpace(16),
                            if (isMobile) ...[
                              const _TrainerSection(),
                              verticalSpace(16),
                              const _InvoiceSection(),
                            ] else
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _TrainerSection()),
                                  SizedBox(width: 16),
                                  Expanded(child: _InvoiceSection()),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _BottomBar(member: member),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────── Header ─────────────────────────────

class _Header extends StatelessWidget {
  final MemberShowCardModel member;
  const _Header({required this.member});

  @override
  Widget build(BuildContext context) {
    final end = member.subscriptionEndDate;
    final endText = end == null ? '—' : DateFormat('yyyy-MM-dd').format(end);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.strokeStrong)),
      ),
      child: Row(
        children: [
          Material(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.close_rounded, color: AppColors.textPrimary),
              ),
            ),
          ),
          horizontalSpace(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تجديد الاشتراك', style: AppTextStyle.titleLarge),
                verticalSpace(4),
                Wrap(
                  spacing: 8,
                  children: [
                    Text(
                      '${member.name} (${member.code})',
                      style: AppTextStyle.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'ينتهي الاشتراك الحالي: $endText',
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.autorenew_rounded, color: AppColors.primary),
        ],
      ),
    );
  }
}

// ───────────────────────────── Shared card ─────────────────────────────

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _Section({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
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
              Icon(icon, size: 20, color: AppColors.primary),
              horizontalSpace(8),
              Text(
                title,
                style: AppTextStyle.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          verticalSpace(14),
          child,
        ],
      ),
    );
  }
}

// ───────────────────────────── Packages ─────────────────────────────

class _PackagesSection extends StatelessWidget {
  final MemberShowCardModel member;
  const _PackagesSection({required this.member});

  void _retry(BuildContext context) {
    context.read<RegisterMemberCubit>().loadForRenewal(
      gender: member.gender.toLowerCase() == 'female' ? 2 : 1,
      currentPackage: member.packageName,
      currentTrainer: member.trainerName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final columns = context.isMobile ? 1 : 4;

    return _Section(
      title: 'اختيار باقة التجديد',
      icon: Icons.card_membership_rounded,
      child: BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
        buildWhen: (p, c) =>
            p.packagesStatus != c.packagesStatus ||
            p.packages != c.packages ||
            p.selectedPackage != c.selectedPackage ||
            p.lookupsError != c.lookupsError,
        builder: (context, state) {
          if (state.packagesStatus == RegisterStatus.loading ||
              state.packagesStatus == RegisterStatus.initial) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }
          if (state.packagesStatus == RegisterStatus.failure) {
            return Column(
              children: [
                Text(
                  state.lookupsError ?? 'تعذر تحميل الباقات',
                  style: AppTextStyle.labelMedium.copyWith(
                    color: AppColors.statusExpired,
                  ),
                ),
                verticalSpace(8),
                TextButton.icon(
                  onPressed: () => _retry(context),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('إعادة المحاولة'),
                ),
              ],
            );
          }
          if (state.packages.isEmpty) {
            return Text('لا توجد باقات متاحة', style: AppTextStyle.caption);
          }

          return LayoutBuilder(
            builder: (context, c) {
              const gap = 12.0;
              final w = (c.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final p in state.packages)
                    SizedBox(
                      width: w,
                      child: _PackageCard(
                        package: p,
                        selected: p.id == state.selectedPackage?.id,
                        isCurrent: _pkgName(p) == member.packageName,
                        onTap: () => context
                            .read<RegisterMemberCubit>()
                            .selectPackage(p),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final PackageModel package;
  final bool selected;
  final bool isCurrent;
  final VoidCallback onTap;

  const _PackageCard({
    required this.package,
    required this.selected,
    required this.isCurrent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.12)
          : AppColors.surfaceDim,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.strokeStrong,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    selected
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    size: 22,
                    color: selected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                  const Spacer(),
                  if (isCurrent)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'الباقة الحالية',
                        style: AppTextStyle.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              verticalSpace(10),
              Text(
                _pkgName(package),
                style: AppTextStyle.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              verticalSpace(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NumberFormat('#,###').format(_pkgPrice(package)),
                    style: AppTextStyle.headlineMedium.copyWith(
                      color: selected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  horizontalSpace(6),
                  Text(
                    'ج.م',
                    style: AppTextStyle.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────── Trainer dropdown ─────────────────────────────

class _TrainerSection extends StatelessWidget {
  const _TrainerSection();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'المدرب (اختياري)',
      icon: Icons.sports_gymnastics_rounded,
      child: BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
        buildWhen: (p, c) =>
            p.trainers != c.trainers || p.selectedTrainer != c.selectedTrainer,
        builder: (context, state) {
          return DropdownButtonFormField<TrainersModel?>(
            key: ValueKey(state.selectedTrainer?.id),
            initialValue: state.selectedTrainer,
            isExpanded: true,
            dropdownColor: AppColors.surfaceContainer,
            iconEnabledColor: AppColors.primary,
            style: AppTextStyle.labelLarge.copyWith(
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surfaceDim,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.strokeStrong),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
            items: [
              DropdownMenuItem<TrainersModel?>(
                value: null,
                child: Text(
                  'بدون مدرب',
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              for (final t in state.trainers)
                DropdownMenuItem<TrainersModel?>(
                  value: t,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          t.name,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        t.phone,
                        textDirection: TextDirection.ltr,
                        style: AppTextStyle.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            onChanged: (t) =>
                context.read<RegisterMemberCubit>().selectTrainer(t),
          );
        },
      ),
    );
  }
}

// ───────────────────────────── Invoice ─────────────────────────────

class _InvoiceSection extends StatelessWidget {
  const _InvoiceSection();

  String _money(double v) => '${NumberFormat('#,##0.00').format(v)} ج.م';

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'تفاصيل الفاتورة',
      icon: Icons.receipt_long_rounded,
      child: BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
        buildWhen: (p, c) => p.selectedPackage != c.selectedPackage,
        builder: (context, state) {
          final p = state.selectedPackage;
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surfaceDim,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.strokeStrong),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'الباقة',
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      child: Text(
                        p == null ? '—' : _pkgName(p),
                        style: AppTextStyle.labelMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 28, color: AppColors.strokeStrong),
                Row(
                  children: [
                    Text(
                      'إجمالي قيمة التجديد:',
                      style: AppTextStyle.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      p == null ? '—' : _money(_pkgPrice(p)),
                      style: AppTextStyle.titleLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ───────────────────────────── Bottom bar ─────────────────────────────

class _BottomBar extends StatelessWidget {
  final MemberShowCardModel member;
  const _BottomBar({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.strokeStrong)),
      ),
      child: BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
        buildWhen: (p, c) =>
            p.subscriptionStatus != c.subscriptionStatus ||
            p.selectedPackage != c.selectedPackage,
        builder: (context, state) {
          final loading = state.subscriptionStatus == RegisterStatus.loading;
          final canSubmit = state.selectedPackage != null && !loading;

          final confirm = _BarButton(
            label: loading ? 'جاري التجديد...' : 'تأكيد التجديد',
            icon: Icons.check_rounded,
            primary: true,
            onTap: canSubmit
                ? () => context.read<RegisterMemberCubit>().renewSubscription(
                    member.id,
                  )
                : null,
          );
          final cancel = _BarButton(
            label: 'إلغاء',
            onTap: loading ? null : () => Navigator.of(context).pop(),
          );

          if (context.isMobile) {
            return Column(children: [confirm, verticalSpace(8), cancel]);
          }
          return Row(
            children: [
              Expanded(flex: 3, child: confirm),
              horizontalSpace(10),
              Expanded(flex: 1, child: cancel),
            ],
          );
        },
      ),
    );
  }
}

class _BarButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool primary;
  final VoidCallback? onTap;

  const _BarButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final fg = primary ? AppColors.textOnPrimary : AppColors.textPrimary;
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: primary ? AppColors.primary : AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: primary
                ? BorderSide.none
                : const BorderSide(color: AppColors.strokeStrong),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: fg),
                    horizontalSpace(8),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.buttonMedium.copyWith(color: fg),
                    ),
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
