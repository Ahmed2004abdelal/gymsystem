import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gymsystem/core/helper/extensions.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/helper/timezone_helper.dart' show EgyptTime;
import 'package:gymsystem/core/routing/routes.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/features/register%20screen/data/models/member_details_model.dart';
import 'package:gymsystem/features/register%20screen/logic/clients/clients_table_cubit.dart';
import 'package:gymsystem/features/register%20screen/logic/clients/clients_table_state.dart';
import 'package:intl/intl.dart' show DateFormat;

/// أقل عرض للجدول. أقل منه بيظهر scroll أفقي بدل ما الأعمدة تتضغط.
const _minTableWidth = 980.0;

/// أوزان الأعمدة: المشترك | رقم العضوية | الجوال | الباقة والمدرب | الحالة | الانتهاء
const _flex = [30, 20, 22, 28, 20, 24];

const _headers = [
  'المشترك',
  'رقم العضوية',
  'رقم الجوال',
  'الباقة والمدرب',
  'الحالة',
  'تاريخ الانتهاء',
];

/// جدول المشتركين (pagination من السيرفر). الـ ClientsTableCubit لازم يتوفر فوقه.
class TablWithPagenation extends StatelessWidget {
  const TablWithPagenation({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ClientsTableCubit>();

    return BlocBuilder<ClientsTableCubit, ClientsTableState>(
      builder: (context, state) {
        final isLoading =
            state.status == ClientsStatus.loading ||
            state.status == ClientsStatus.initial;

        if (state.status == ClientsStatus.failure) {
          return _MessageBox(
            icon: Icons.error_outline_rounded,
            color: AppColors.statusExpired,
            title: 'تعذر تحميل المشتركين',
            subtitle: state.errorMessage,
            actionLabel: 'إعادة المحاولة',
            onAction: cubit.refresh,
          );
        }

        if (isLoading && state.items.isEmpty) {
          return const _MessageBox(
            loading: true,
            title: 'جاري تحميل المشتركين...',
          );
        }

        if (state.status == ClientsStatus.success && state.totalCount == 0) {
          return _MessageBox(
            icon: Icons.group_off_outlined,
            title: state.searchTerm.isEmpty
                ? 'لا يوجد مشتركون بعد'
                : 'لا توجد نتائج مطابقة للبحث',
            subtitle: state.searchTerm.isEmpty ? null : '"${state.searchTerm}"',
          );
        }

        return Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.strokeDefault),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  _TableBody(items: state.items),
                  if (isLoading)
                    Positioned.fill(
                      child: ColoredBox(
                        color: AppColors.surface.withValues(alpha: 0.6),
                        child: const Center(
                          child: SpinKitFadingCircle(
                            color: AppColors.primary,
                            size: 44,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              _Footer(state: state, cubit: cubit, busy: isLoading),
            ],
          ),
        );
      },
    );
  }
}

// ───────────────────────────── Body ─────────────────────────────

Widget _cell(int index, Widget child) => Expanded(
  flex: _flex[index],
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Align(alignment: AlignmentDirectional.centerStart, child: child),
  ),
);

class _TableBody extends StatelessWidget {
  final List<MemberDetailsModel> items;
  const _TableBody({required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final scroll = c.maxWidth < _minTableWidth;
        final table = SizedBox(
          width: scroll ? _minTableWidth : c.maxWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _HeaderRow(),
              for (final m in items) _MemberRow(member: m),
            ],
          ),
        );
        return scroll
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: table,
              )
            : table;
      },
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: AppColors.surfaceContainer,
      child: Row(
        children: [
          for (var i = 0; i < _headers.length; i++)
            _cell(
              i,
              Text(
                _headers[i],
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  final MemberDetailsModel member;
  const _MemberRow({required this.member});

  @override
  Widget build(BuildContext context) {
    final m = member;
    final DateTime? created = m.createdAt;
    final joined = (created != null && created.year > 2000)
        ? 'انضم: ${DateFormat('yyyy-MM-dd').format(EgyptTime.from(created))}'
        : null;
    final initial = m.name.trim().isEmpty ? '?' : m.name.trim().substring(0, 1);
    final remaining = _remaining(m);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        hoverColor: AppColors.surfaceContainer.withValues(alpha: 0.5),
        onTap: () {
          // context.pushNamed(Routes.memberInfoScreen, arguments: member);
          context.pushNamed(Routes.memberInfoScreen, arguments: member.code);
        },
        child: Container(
          constraints: const BoxConstraints(minHeight: 72),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.strokeDefault)),
          ),
          child: Row(
            children: [
              _cell(
                0,
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.surfaceContainer,
                      child: Text(
                        initial,
                        style: AppTextStyle.labelLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    horizontalSpace(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            m.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.labelLarge.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (joined != null)
                            Text(joined, style: AppTextStyle.caption),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _cell(1, _CodeChip(m.code)),
              _cell(
                2,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        m.phone,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    horizontalSpace(8),
                    _IconBox(
                      icon: Icons.chat_bubble_outline_rounded,
                      onTap: () {}, // TODO: فتح واتساب / رسالة
                    ),
                  ],
                ),
              ),
              _cell(
                3,
                m.packageName == null
                    ? Text(
                        '—',
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            m.packageName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.labelMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (m.trainerName != null)
                            Text(
                              'مدرب: ${m.trainerName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.caption,
                            ),
                        ],
                      ),
              ),
              // الحالة
              _cell(4, _StatusPill(m)),
              // الانتهاء
              _cell(
                5,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _date(m.subscriptionEndDate),
                      textDirection: TextDirection.ltr,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (remaining != null)
                      Text(
                        remaining.text,
                        style: AppTextStyle.caption.copyWith(
                          color: remaining.color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// المدة المتبقية: أخضر (أكتر من 7 أيام) / أصفر (7 أو أقل) / أحمر (منتهي).
({String text, Color color})? _remaining(MemberDetailsModel m) {
  final days = m.remainingDays;
  if (days == null) return null;
  if (days <= 0) {
    return (text: 'منتهي', color: AppColors.statusExpired);
  }
  if (days <= 7) {
    return (
      text: 'متبقي $days ${days <= 10 ? 'أيام' : 'يوماً'}',
      color: AppColors.statusExpiring,
    );
  }
  return (text: 'متبقي $days يوماً', color: AppColors.statusActive);
}

/// subscriptionEndDate جاي String (ISO) غالباً من غير Z، فنعتبره UTC.
String _date(String? iso) {
  if (iso == null || iso.isEmpty) return '—';
  final hasZone =
      iso.endsWith('Z') || RegExp(r'[+-]\d{2}:?\d{2}$').hasMatch(iso);
  final d = DateTime.tryParse(hasZone ? iso : '${iso}Z');
  if (d == null) return iso;
  return DateFormat('yyyy-MM-dd').format(EgyptTime.from(d));
}

// ───────────────────────────── Small widgets ─────────────────────────────

class _CodeChip extends StatelessWidget {
  final String code;
  const _CodeChip(this.code);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainer,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Clipboard.setData(ClipboardData(text: code));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('تم نسخ الكود $code')));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.strokeStrong),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.copy_rounded,
                size: 14,
                color: AppColors.textSecondary,
              ),
              horizontalSpace(8),
              Flexible(
                child: Text(
                  code,
                  textDirection: TextDirection.ltr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontFamily: 'monospace',
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

class _IconBox extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBox({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainer,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(icon, size: 15, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final MemberDetailsModel member;
  const _StatusPill(this.member);

  /// قيم subscriptionStatus المفترضة: Active / Expired / Frozen / No Subscription.
  /// أي قيمة تانية بتتعرض زي ما هي. و Active مع 7 أيام أو أقل = "ينتهي قريباً".
  ({Color color, Color bg, Color border, String label}) get _ui {
    final raw = member.subscriptionStatus ?? '';
    final key = raw.toLowerCase().replaceAll(RegExp(r'[\s_-]'), '');
    final days = member.remainingDays;

    switch (key) {
      case 'active':
        if (days != null && days <= 7) {
          return (
            color: AppColors.statusExpiring,
            bg: AppColors.statusExpiringBg,
            border: AppColors.statusExpiringBorder,
            label: 'ينتهي قريباً',
          );
        }
        return (
          color: AppColors.statusActive,
          bg: AppColors.statusActiveBg,
          border: AppColors.statusActiveBorder,
          label: 'نشط',
        );
      case 'expired':
        return (
          color: AppColors.statusExpired,
          bg: AppColors.statusExpired.withValues(alpha: 0.12),
          border: AppColors.statusExpired.withValues(alpha: 0.35),
          label: 'منتهي',
        );
      case 'frozen':
        const blue = Color(0xFF60A5FA);
        return (
          color: blue,
          bg: blue.withValues(alpha: 0.12),
          border: blue.withValues(alpha: 0.35),
          label: 'مجمّد',
        );
      case '':
      case 'nosubscription':
        return (
          color: AppColors.textSecondary,
          bg: AppColors.surfaceContainer,
          border: AppColors.strokeStrong,
          label: 'بدون اشتراك',
        );
      default:
        return (
          color: AppColors.textSecondary,
          bg: AppColors.surfaceContainer,
          border: AppColors.strokeStrong,
          label: raw,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ui = _ui;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: ui.bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: ui.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: ui.color, shape: BoxShape.circle),
          ),
          horizontalSpace(8),
          Text(
            ui.label,
            style: AppTextStyle.labelMedium.copyWith(color: ui.color),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── Footer / pagination ─────────────────────────────

String _n(int v) =>
    v.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');

/// أرقام الصفحات: الأولى والأخيرة والحالية وجيرانها، و null = "…".
List<int?> _pageItems(int current, int total) {
  if (total <= 5) return [for (var i = 1; i <= total; i++) i];
  final set = <int>{1, total, current - 1, current, current + 1};
  if (current <= 2) set.add(3);
  if (current >= total - 1) set.add(total - 2);
  final pages = set.where((p) => p >= 1 && p <= total).toList()..sort();
  final out = <int?>[];
  for (var i = 0; i < pages.length; i++) {
    if (i > 0 && pages[i] - pages[i - 1] > 1) out.add(null);
    out.add(pages[i]);
  }
  return out;
}

class _Footer extends StatelessWidget {
  final ClientsTableState state;
  final ClientsTableCubit cubit;
  final bool busy;
  const _Footer({required this.state, required this.cubit, required this.busy});

  @override
  Widget build(BuildContext context) {
    final from = state.items.isEmpty
        ? 0
        : (state.pageNumber - 1) * state.pageSize + 1;
    final to = from == 0 ? 0 : from + state.items.length - 1;
    final totalPages = state.totalPages < 1 ? 1 : state.totalPages;
    final page = state.pageNumber;

    void go(int p) {
      if (busy || p < 1 || p > totalPages || p == page) return;
      cubit.loadPage(p);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.strokeDefault)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 12,
        children: [
          // بداية السطر (يمين في RTL): العدّاد + عدد الصفوف
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PageSizeMenu(
                size: state.pageSize,
                onSelected: cubit.changePageSize,
              ),
              horizontalSpace(12),
              Text(
                'عرض ${_n(from)} - ${_n(to)} من أصل ${_n(state.totalCount)} مشترك',
                style: AppTextStyle.caption,
              ),
            ],
          ),
          // نهاية السطر (شمال في RTL): أزرار الصفحات
          Wrap(
            spacing: 6,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // في RTL "السابق" ناحية اليمين
              _PageBtn.icon(
                Icons.chevron_right_rounded,
                enabled: page > 1,
                onTap: () => go(page - 1),
              ),
              for (final p in _pageItems(page, totalPages))
                if (p == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text('…', style: AppTextStyle.caption),
                  )
                else
                  _PageBtn.number(p, active: p == page, onTap: () => go(p)),
              _PageBtn.icon(
                Icons.chevron_left_rounded,
                enabled: page < totalPages,
                onTap: () => go(page + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageBtn extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final bool active;
  final bool enabled;
  final VoidCallback onTap;

  const _PageBtn.number(int page, {required this.active, required this.onTap})
    : label = '$page',
      icon = null,
      enabled = true;

  const _PageBtn.icon(this.icon, {required this.enabled, required this.onTap})
    : label = null,
      active = false;

  @override
  Widget build(BuildContext context) {
    final fg = active
        ? AppColors.textOnPrimary
        : enabled
        ? AppColors.textPrimary
        : AppColors.textTertiary;

    return Material(
      color: active ? AppColors.primary : AppColors.surfaceContainer,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: enabled ? onTap : null,
        child: Container(
          constraints: const BoxConstraints(minWidth: 36),
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: active ? AppColors.primary : AppColors.strokeDefault,
            ),
          ),
          child: label != null
              ? Text(
                  label!,
                  style: AppTextStyle.labelMedium.copyWith(
                    color: fg,
                    fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                  ),
                )
              : Icon(icon, size: 20, color: fg),
        ),
      ),
    );
  }
}

class _PageSizeMenu extends StatelessWidget {
  final int size;
  final ValueChanged<int> onSelected;
  const _PageSizeMenu({required this.size, required this.onSelected});

  static const _options = [5, 10, 20];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      initialValue: size,
      onSelected: onSelected,
      color: AppColors.surfaceContainer,
      position: PopupMenuPosition.under,
      itemBuilder: (_) => [
        for (final v in _options)
          PopupMenuItem<int>(
            value: v,
            child: Text(
              '$v في الصفحة',
              style: AppTextStyle.labelMedium.copyWith(
                color: v == size ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.strokeDefault),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$size في الصفحة',
              style: AppTextStyle.labelMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            horizontalSpace(6),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────── Loading / empty / error ─────────────────────────────

class _MessageBox extends StatelessWidget {
  final bool loading;
  final IconData? icon;
  final Color? color;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _MessageBox({
    this.loading = false,
    this.icon,
    this.color,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 48),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (loading)
            const SpinKitFadingCircle(color: AppColors.primary, size: 48)
          else
            Icon(icon, size: 52, color: color ?? AppColors.textTertiary),
          verticalSpace(12),
          Text(title, style: AppTextStyle.titleMedium),
          if (subtitle != null) ...[
            verticalSpace(4),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: AppTextStyle.caption,
            ),
          ],
          if (actionLabel != null) ...[
            verticalSpace(14),
            OutlinedButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    );
  }
}
