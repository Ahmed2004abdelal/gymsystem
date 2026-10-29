import 'package:flutter/material.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';

class MemberProfileScreen extends StatelessWidget {
  const MemberProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.value(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(pad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BackButton(),
              verticalSpace(16),
              const _HeaderCard(),
              verticalSpace(20),
              const _InfoCard(),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────── Back button ─────────────────────────────

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainer,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).maybePop(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.strokeStrong),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // RTL: this arrow points right, which means "back".
              const Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: AppColors.textPrimary,
              ),
              horizontalSpace(8),
              Text(
                'رجوع',
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────── Header ─────────────────────────────

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    final identity = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'أحمد مصطفى السعيد',
              style: AppTextStyle.displaySmall.scaled(context),
            ),
            const _Pill(
              icon: Icons.workspace_premium_rounded,
              label: 'VIP بلاتينيوم سنوية',
              color: AppColors.primary,
              bg: AppColors.neonLimeBg,
              border: AppColors.strokeStrong,
            ),
          ],
        ),
        verticalSpace(10),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            _MetaText(icon: Icons.tag_rounded, text: 'GYM-8821', mono: true),
            _MetaText(icon: Icons.cake_outlined, text: '28 سنة (14 مايو 1996)'),
            _MetaText(
              icon: Icons.verified_user_outlined,
              text: 'الهوية: 1098472910',
            ),
          ],
        ),
        verticalSpace(12),
        const Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _Pill(
              icon: Icons.phone_rounded,
              label: '050 123 4567',
              color: AppColors.textPrimary,
              bg: AppColors.surfaceContainer,
              border: AppColors.strokeStrong,
              ltr: true,
            ),
            _Pill(
              icon: Icons.chat_rounded,
              label: 'واتساب مباشر',
              color: AppColors.statusActive,
              bg: AppColors.statusActiveBg,
              border: AppColors.statusActiveBorder,
            ),
          ],
        ),
      ],
    );

    const actions = Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _PrimaryAction(
          label: 'تسجيل دخول فوري',
          icon: Icons.meeting_room_rounded,
        ),
        _SecondaryAction(label: 'تجديد الباقة', icon: Icons.autorenew_rounded),
      ],
    );

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Column(
        children: [
          // Lime accent line on top
          Container(height: 3, color: AppColors.primary),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: identity),
                          horizontalSpace(16),
                          actions,
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [identity, verticalSpace(16), actions],
                      ),
                verticalSpace(20),
                const _StatsStrip(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsStrip extends StatelessWidget {
  const _StatsStrip();

  @override
  Widget build(BuildContext context) {
    const items = [
      _Stat(
        icon: Icons.event_available_rounded,
        label: 'نهاية الاشتراك',
        value: '15 نوفمبر 2025',
        sub: 'متبقي 22 يوماً',
        subColor: AppColors.warning,
        subIcon: Icons.hourglass_bottom_rounded,
        highlight: true,
      ),
      _Stat(
        icon: Icons.sports_gymnastics_rounded,
        label: 'المدرب الشخصي (PT)',
        value: 'كابتن طارق السالم',
        sub: 'جلسات متبقية: 7 / 12',
      ),
      _Stat(
        icon: Icons.history_rounded,
        label: 'تاريخ الانضمام',
        value: '15 يناير 2024',
        sub: 'عضو مستمر منذ 10 أشهر',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceDim,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          if (c.maxWidth < 640) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                items[0],
                verticalSpace(16),
                items[1],
                verticalSpace(16),
                items[2],
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [for (final s in items) Expanded(child: s)],
          );
        },
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String sub;
  final Color subColor;
  final IconData? subIcon;
  final bool highlight;

  const _Stat({
    required this.icon,
    required this.label,
    required this.value,
    required this.sub,
    this.subColor = AppColors.textSecondary,
    this.subIcon,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppColors.primary),
            horizontalSpace(6),
            Flexible(child: Text(label, style: AppTextStyle.caption)),
          ],
        ),
        verticalSpace(6),
        Text(
          value,
          style: AppTextStyle.headlineMedium.copyWith(
            color: highlight ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
        verticalSpace(4),
        Row(
          children: [
            if (subIcon != null) ...[
              Icon(subIcon, size: 14, color: subColor),
              horizontalSpace(4),
            ],
            Flexible(
              child: Text(
                sub,
                style: AppTextStyle.labelSmall.copyWith(color: subColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ───────────────────────────── Personal info (reformatted) ─────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + edit
          Row(
            children: [
              const Icon(
                Icons.badge_outlined,
                size: 22,
                color: AppColors.primary,
              ),
              horizontalSpace(10),
              Expanded(
                child: Text('البيانات الشخصية', style: AppTextStyle.titleLarge),
              ),
              Material(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.strokeStrong),
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(8),
          const Divider(color: AppColors.strokeDefault, height: 24),
          const _InfoGrid(
            fields: [
              _InfoField(
                icon: Icons.person_outline_rounded,
                label: 'الاسم الرباعي المعتمد',
                value: 'أحمد مصطفى عبد الرحمن السعيد',
              ),
              _InfoField(
                icon: Icons.credit_card_rounded,
                label: 'رقم الهوية / الإقامة',
                value: '1098472910',
                ltr: true,
                badge: 'موثّق عبر نفاذ',
              ),
              _InfoField(
                icon: Icons.wc_rounded,
                label: 'الجنس والجنسية',
                value: 'ذكر | سعودي',
              ),
              _InfoField(
                icon: Icons.mail_outline_rounded,
                label: 'البريد الإلكتروني',
                value: 'ahmed.saeed@example.com',
                ltr: true,
              ),
              _InfoField(
                icon: Icons.location_on_outlined,
                label: 'المدينة والعنوان',
                value: 'الرياض - حي العليا - شارع الملك فهد',
              ),
            ],
          ),
          verticalSpace(20),
          const _EmergencyBlock(),
        ],
      ),
    );
  }
}

class _InfoField {
  final IconData icon;
  final String label;
  final String value;
  final bool ltr;
  final String? badge;

  const _InfoField({
    required this.icon,
    required this.label,
    required this.value,
    this.ltr = false,
    this.badge,
  });
}

/// Two columns on wide containers, one column on narrow ones.
class _InfoGrid extends StatelessWidget {
  final List<_InfoField> fields;
  const _InfoGrid({required this.fields});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        const gap = 14.0;
        final cols = c.maxWidth >= 560 ? 2 : 1;
        final w = (c.maxWidth - gap * (cols - 1)) / cols;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final f in fields)
              SizedBox(
                width: w,
                child: _FieldTile(field: f),
              ),
          ],
        );
      },
    );
  }
}

class _FieldTile extends StatelessWidget {
  final _InfoField field;
  const _FieldTile({required this.field});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceDim,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(field.icon, size: 18, color: AppColors.primary),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(field.label, style: AppTextStyle.caption),
                verticalSpace(4),
                Text(
                  field.value,
                  textDirection: field.ltr ? TextDirection.ltr : null,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontFamily: field.ltr ? 'monospace' : null,
                  ),
                ),
                if (field.badge != null) ...[
                  verticalSpace(6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      horizontalSpace(4),
                      Text(
                        field.badge!,
                        style: AppTextStyle.labelSmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmergencyBlock extends StatelessWidget {
  const _EmergencyBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.statusExpiredBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.statusExpiredBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.emergency_outlined,
                size: 18,
                color: AppColors.statusExpired,
              ),
              horizontalSpace(8),
              Text(
                'جهة الاتصال في حالات الطوارئ',
                style: AppTextStyle.labelLarge.copyWith(
                  color: AppColors.statusExpired,
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 10,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('خالد مصطفى السعيد', style: AppTextStyle.titleMedium),
                  Text('صلة القرابة: الأخ الشقيق', style: AppTextStyle.caption),
                ],
              ),
              const _Pill(
                icon: Icons.phone_rounded,
                label: '055 112 2334',
                color: AppColors.textPrimary,
                bg: AppColors.surfaceContainer,
                border: AppColors.strokeStrong,
                ltr: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── Small reusable pieces ─────────────────────────────

class _Pill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bg;
  final Color border;
  final bool ltr;

  const _Pill({
    required this.icon,
    required this.label,
    required this.color,
    required this.bg,
    required this.border,
    this.ltr = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          horizontalSpace(6),
          Text(
            label,
            textDirection: ltr ? TextDirection.ltr : null,
            style: AppTextStyle.labelSmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _MetaText extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool mono;

  const _MetaText({required this.icon, required this.text, this.mono = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.primary),
        horizontalSpace(6),
        Text(
          text,
          textDirection: mono ? TextDirection.ltr : null,
          style: AppTextStyle.labelMedium.copyWith(
            color: AppColors.textSecondary,
            fontFamily: mono ? 'monospace' : null,
          ),
        ),
      ],
    );
  }
}

class _PrimaryAction extends StatelessWidget {
  final String label;
  final IconData icon;
  const _PrimaryAction({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: AppColors.glowActive,
            blurRadius: 20,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: AppColors.textOnPrimary),
                horizontalSpace(8),
                Text(label, style: AppTextStyle.buttonLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SecondaryAction extends StatelessWidget {
  final String label;
  final IconData icon;
  const _SecondaryAction({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainer,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.strokeStrong),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: AppColors.primary),
              horizontalSpace(8),
              Text(
                label,
                style: AppTextStyle.buttonMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
