import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/helper/extensions.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/routing/routes.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/core/widgets/custom_button.dart';
import 'package:gymsystem/features/login/logic/login_cubit.dart';
import 'package:gymsystem/features/login/logic/login_state.dart';

/// ملاحظة: الـ LoginCubit لازم يتوفر فوق الشاشة دي (في الـ router أو الـ DI):
/// BlocProvider(create: (_) => getIt<LoginCubit>(), child: const LoginScreen())
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final pad = Responsive.value(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    final card = Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(pad),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isDesktop) ...[const _BrandHeader(), verticalSpace(24)],
              const _LoginCard(),
            ],
          ),
        ),
      ),
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: isDesktop
              ? Row(
                  children: [
                    Expanded(flex: 48, child: card),
                    const Expanded(flex: 52, child: _BrandPanel()),
                  ],
                )
              : card,
        ),
      ),
    );
  }
}

// ───────────────────────────── Card ─────────────────────────────

class _LoginCard extends StatefulWidget {
  const _LoginCard();

  @override
  State<_LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<_LoginCard> {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _hidePassword = true;
  bool _remember = true;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    context
        .read<LoginCubit>()
        .login(_userCtrl.text, _passCtrl.text)
        .then(
          (val) => context.pushNamedAndRemoveUntil(
            Routes.sideBarMenu,
            predicate: (r) => false,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final cardPad = Responsive.value(
      context,
      mobile: 20.0,
      tablet: 28.0,
      desktop: 32.0,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(cardPad),
      decoration: BoxDecoration(
        color: AppColors.surfaceDim,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Staff chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.strokeStrong),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.badge, size: 14, color: AppColors.primary),
                  horizontalSpace(6),
                  Flexible(
                    child: Text(
                      'خاص بالموظفين (الاستقبال والمدربين)',
                      style: AppTextStyle.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(12),
            Text('تسجيل الدخول للنظام', style: AppTextStyle.headlineMedium),
            verticalSpace(6),
            Text(
              'أدخل بيانات الاعتماد الخاصة بك للوصول إلى لوحة التشغيل وإدارة المتدربين',
              style: AppTextStyle.bodyMedium,
            ),
            verticalSpace(24),

            // TODO(logic): show _DisabledBanner here when the account is disabled.

            // Username
            _AppTextField(
              controller: _userCtrl,
              label: 'اسم المستخدم أو رقم الجوال',
              hint: 'مثال: omar.khaled أو 0501234567',
              prefixIcon: Icons.person,
              textInputAction: TextInputAction.next,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'أدخل اسم المستخدم' : null,
            ),
            verticalSpace(18),

            // Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('كلمة المرور', style: AppTextStyle.inputLabel),
                Text('مشفرة ومحمية', style: AppTextStyle.caption),
              ],
            ),
            verticalSpace(6),
            _AppTextField(
              controller: _passCtrl,
              hint: 'أدخل كلمة المرور',
              prefixIcon: Icons.key,
              obscure: _hidePassword,
              textInputAction: TextInputAction.done,
              onSubmitted: _submit,
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'أدخل كلمة المرور' : null,
              onToggleVisibility: () =>
                  setState(() => _hidePassword = !_hidePassword),
            ),
            verticalSpace(14),

            // Remember me
            GestureDetector(
              onTap: () => setState(() => _remember = !_remember),
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: _remember,
                      onChanged: (v) => setState(() => _remember = v ?? false),
                      activeColor: AppColors.primary,
                      checkColor: AppColors.textOnPrimary,
                      side: const BorderSide(color: AppColors.strokeStrong),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    child: Text(
                      'تذكر تسجيل دخولي على هذا الجهاز',
                      style: AppTextStyle.labelMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Error alert + login button (driven by LoginCubit)
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                state.whenOrNull(
                  success: () {
                    // TODO: navigate, e.g. context.go('/home');
                  },
                );
              },
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );
                final errorMessage = state.maybeWhen(
                  failure: (message) => message,
                  orElse: () => null,
                );

                return Column(
                  children: [
                    if (errorMessage != null) ...[
                      verticalSpace(14),
                      _InlineAlert(
                        color: AppColors.statusExpired,
                        bg: AppColors.statusExpired.withValues(alpha: 0.1),
                        border: AppColors.statusExpired.withValues(alpha: 0.3),
                        icon: Icons.error_outline,
                        title: 'فشل تسجيل الدخول',
                        message: errorMessage,
                      ),
                    ],
                    verticalSpace(20),
                    CustomButton(
                      text: 'تسجيل الدخول',
                      suffixIcon: const Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: AppColors.textOnPrimary,
                      ),
                      isLoading: isLoading,
                      onPressed: _submit,
                    ),
                  ],
                );
              },
            ),

            verticalSpace(28),
            const Divider(color: AppColors.strokeDefault, height: 1),
            verticalSpace(20),
            const _OwnerNote(),
            verticalSpace(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'مفتاح الإدخال السريع: Enter ↵',
                    style: AppTextStyle.caption,
                  ),
                ),
                horizontalSpace(8),
                Flexible(
                  child: Text(
                    'الإصدار 2.4.0 (Staff Build)',
                    style: AppTextStyle.caption,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────── Reusable pieces ─────────────────────────────

class _AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String hint;
  final IconData prefixIcon;
  final bool obscure;
  final bool hasError;
  final VoidCallback? onToggleVisibility;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final VoidCallback? onSubmitted;

  const _AppTextField({
    this.controller,
    this.label,
    required this.hint,
    required this.prefixIcon,
    this.obscure = false,
    this.hasError = false,
    this.onToggleVisibility,
    this.validator,
    this.textInputAction,
    this.onSubmitted,
  });

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,
      onFieldSubmitted: (_) => onSubmitted?.call(),
      obscureText: obscure,
      style: AppTextStyle.inputText.copyWith(fontSize: 14),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.inputHint.copyWith(fontSize: 14),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        prefixIcon: Icon(prefixIcon, size: 20, color: AppColors.textTertiary),
        suffixIcon: onToggleVisibility == null
            ? null
            : IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
        enabledBorder: _border(
          hasError ? AppColors.statusExpired : AppColors.strokeStrong,
        ),
        border: _border(AppColors.strokeStrong),
        focusedBorder: _border(
          hasError ? AppColors.statusExpired : AppColors.primary,
          1.5,
        ),
        errorBorder: _border(AppColors.statusExpired),
        focusedErrorBorder: _border(AppColors.statusExpired, 1.5),
        errorStyle: AppTextStyle.caption.copyWith(
          color: AppColors.statusExpired,
        ),
      ),
    );

    if (label == null) return field;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label!, style: AppTextStyle.inputLabel),
        verticalSpace(6),
        field,
      ],
    );
  }
}

/// Reusable alert box (error / info).
class _InlineAlert extends StatelessWidget {
  final Color color;
  final Color bg;
  final Color border;
  final IconData icon;
  final String? title;
  final String message;

  const _InlineAlert({
    required this.color,
    required this.bg,
    required this.border,
    required this.icon,
    required this.message,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          horizontalSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: AppTextStyle.labelMedium.copyWith(color: color),
                  ),
                Text(
                  message,
                  style: AppTextStyle.bodySmall.copyWith(color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Disabled-account banner. Not shown by default.
class _DisabledBanner extends StatelessWidget {
  const _DisabledBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.statusExpiringBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.statusExpiringBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.statusExpiringBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.lock_person,
              size: 20,
              color: AppColors.statusExpiring,
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تم تعطيل الحساب من قِبل إدارة النادي',
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.statusExpiring,
                  ),
                ),
                verticalSpace(4),
                Text(
                  'حسابك الوظيفي متوقف مؤقتاً أو غير مفعل. يُرجى مراجعة مالك الصالة أو المشرف العام لإعادة تفعيل الصلاحيات.',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.statusExpiring,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OwnerNote extends StatelessWidget {
  const _OwnerNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.admin_panel_settings,
            size: 18,
            color: AppColors.textSecondary,
          ),
          horizontalSpace(12),
          Expanded(
            child: Text(
              'الحسابات يتم إنشاؤها وإدارتها حصرياً بواسطة مالك النادي. تواصل مع مالك الصالة لإعادة تعيين كلمة المرور أو الحصول على صلاحيات الدخول.',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── Brand ─────────────────────────────

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: AppColors.glowActive, blurRadius: 20),
            ],
          ),
          child: const Icon(
            Icons.fitness_center,
            size: 24,
            color: AppColors.textOnPrimary,
          ),
        ),
        horizontalSpace(14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('داينامك جيم', style: AppTextStyle.titleLarge),
            Text(
              'DYNAMIC GYM CONSOLE',
              style: AppTextStyle.labelSmall.copyWith(
                color: AppColors.primary,
                letterSpacing: 1.5, // Latin text only, safe
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BrandPanel extends StatelessWidget {
  const _BrandPanel();

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.value(context, mobile: 24.0, desktop: 48.0);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0E1015),
        border: Border(right: BorderSide(color: AppColors.strokeDefault)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(pad),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - (pad * 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _BrandHeader(),
                  verticalSpace(32),
                  const _BrandMessage(),
                  verticalSpace(32),
                  const _BrandFooter(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BrandMessage extends StatelessWidget {
  const _BrandMessage();

  @override
  Widget build(BuildContext context) {
    final titleSize = 36 * context.scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.neonLimeBg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.bolt, size: 16, color: AppColors.primary),
              horizontalSpace(6),
              Flexible(
                child: Text(
                  'سرعة الإنجاز على كاونتر الاستقبال وأرضية التدريب',
                  style: AppTextStyle.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(20),
        Text(
          'قوة، انضباط، وأداء',
          style: AppTextStyle.displaySmall.copyWith(fontSize: titleSize),
        ),
        Text(
          'يتجدد في كل ثانية.',
          style: AppTextStyle.displaySmall.copyWith(
            fontSize: titleSize,
            color: AppColors.primary,
          ),
        ),
        verticalSpace(16),
        Text(
          'منصة سريعة ومصممة خصيصاً لتسهيل فحص وتمرير البطاقات في ثوانٍ معدودة، إدارة حصص التدريب الخاص فورياً، ومتابعة متدربيك دون أي تعقيد.',
          style: AppTextStyle.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        verticalSpace(20),
        LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 520;
            const tiles = [
              _FeatureTile(
                icon: Icons.qr_code_scanner,
                title: 'تمرير واستقبال فوري',
                subtitle: 'فحص باركود وبطاقات RFID في ثانية',
              ),
              _FeatureTile(
                icon: Icons.timer,
                title: 'خصم الجلسات بضغطة زر',
                subtitle: 'إثبات مباشر لحضور المتدرب الخاص',
              ),
            ];
            if (stacked) {
              return Column(children: [tiles[0], verticalSpace(12), tiles[1]]);
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: tiles[0]),
                horizontalSpace(14),
                Expanded(child: tiles[1]),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _BrandFooter extends StatelessWidget {
  const _BrandFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AppColors.strokeDefault, height: 1),
        verticalSpace(16),
        Wrap(
          spacing: 20,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const _FooterItem(
              icon: Icons.verified_user,
              iconColor: AppColors.primary,
              text: 'اتصال داخلي آمن ومشفر 256-bit',
            ),
            const _FooterItem(
              icon: Icons.schedule,
              iconColor: AppColors.textTertiary,
              text: 'تحديثات حية ومزامنة فورية',
            ),
            Text(
              'حقوق النظام محفوظة © داينامك جيم',
              style: AppTextStyle.caption,
            ),
          ],
        ),
      ],
    );
  }
}

class _FooterItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const _FooterItem({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: iconColor),
        horizontalSpace(6),
        Text(text, style: AppTextStyle.caption),
      ],
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF13161C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(subtitle, style: AppTextStyle.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
