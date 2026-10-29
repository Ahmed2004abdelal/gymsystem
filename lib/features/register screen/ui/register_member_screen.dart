// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:gymsystem/core/helper/responsive.dart';
// import 'package:gymsystem/core/helper/spacer.dart';
// import 'package:gymsystem/core/helper/timezone_helper.dart' show EgyptTime;
// import 'package:gymsystem/core/theme/app_colors.dart';
// import 'package:gymsystem/core/theme/app_text_style.dart';
// import 'package:gymsystem/core/widgets/custom_button.dart';
// import 'package:gymsystem/core/widgets/custom_textform.dart';
// import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
// import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';
// import 'package:gymsystem/features/register%20screen/logic/register/register_member_cubit.dart';
// import 'package:gymsystem/features/register%20screen/logic/register/register_member_state.dart';
// import 'package:intl/intl.dart' show DateFormat;

// const _currency = 'ج.م';

// String _money(num v) => v.toStringAsFixed(2);

// /// يقبل DateTime أو String (ISO 8601) ويرجّع تاريخ بتوقيت مصر.
// String _egyptDate(dynamic v) {
//   final d = v is DateTime ? v : DateTime.parse(v as String);
//   return DateFormat('yyyy-MM-dd').format(EgyptTime.from(d));
// }

// // ───────────────────────────── Screen ─────────────────────────────

// class RegisterMemberScreen extends StatefulWidget {
//   final String? memberCode;
//   const RegisterMemberScreen({this.memberCode, super.key});

//   @override
//   State<RegisterMemberScreen> createState() => _RegisterMemberScreenState();
// }

// class _RegisterMemberScreenState extends State<RegisterMemberScreen> {
//   void _snack(String message, {bool error = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: error ? AppColors.statusExpired : null,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pad = Responsive.value(
//       context,
//       mobile: 16.0,
//       tablet: 24.0,
//       desktop: 32.0,
//     );

//     final form = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const _LookupsErrorBanner(),
//         _PersonalSection(
//           initialCode: widget.memberCode,
//           onSubmit: (model) =>
//               context.read<RegisterMemberCubit>().createMember(model),
//         ),
//         verticalSpace(20),
//         const _PlansSection(),
//       ],
//     );

//     return MultiBlocListener(
//       listeners: [
//         BlocListener<RegisterMemberCubit, RegisterMemberState>(
//           listenWhen: (p, c) => p.createMemberStatus != c.createMemberStatus,
//           listener: (context, state) {
//             if (state.createMemberStatus == RegisterStatus.failure) {
//               _snack(state.errorMessage ?? 'تعذر تسجيل العضو', error: true);
//             }
//             if (state.createMemberStatus == RegisterStatus.success) {
//               _snack('تم تسجيل العضو، اختر الباقة للمتابعة');
//             }
//           },
//         ),
//         BlocListener<RegisterMemberCubit, RegisterMemberState>(
//           listenWhen: (p, c) => p.subscriptionStatus != c.subscriptionStatus,
//           listener: (context, state) {
//             if (state.subscriptionStatus == RegisterStatus.failure) {
//               _snack(state.errorMessage ?? 'تعذر إنشاء الاشتراك', error: true);
//             }
//             if (state.subscriptionStatus == RegisterStatus.success) {
//               _snack('تم تسجيل الاشتراك بنجاح');
//             }
//           },
//         ),
//       ],
//       child: Scaffold(
//         backgroundColor: AppColors.background,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(pad),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const _Header(),
//                 verticalSpace(20),
//                 context.isDesktop
//                     ? Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(flex: 7, child: form),
//                           horizontalSpace(20),
//                           const Expanded(flex: 3, child: _ReceiptSummary()),
//                         ],
//                       )
//                     : Column(
//                         children: [
//                           form,
//                           verticalSpace(20),
//                           const _ReceiptSummary(),
//                         ],
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ───────────────────────────── Header ─────────────────────────────

// class _Header extends StatelessWidget {
//   const _Header();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         IconButton(
//           onPressed: () => Navigator.of(context).maybePop(),
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//         ),
//         verticalSpace(4),
//         Text(
//           'تسجيل مشترك جديد',
//           style: AppTextStyle.displaySmall.scaled(context),
//         ),
//       ],
//     );
//   }
// }

// // ───────────────────────────── Shared pieces ─────────────────────────────

// class _Section extends StatelessWidget {
//   final int number;
//   final String title;
//   final String? trailing;
//   final Widget child;
//   const _Section({
//     required this.number,
//     required this.title,
//     required this.child,
//     this.trailing,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.strokeDefault),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 28,
//                 height: 28,
//                 alignment: Alignment.center,
//                 decoration: const BoxDecoration(
//                   color: AppColors.primary,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   '$number',
//                   style: AppTextStyle.labelLarge.copyWith(
//                     color: AppColors.textOnPrimary,
//                   ),
//                 ),
//               ),
//               horizontalSpace(10),
//               Expanded(child: Text(title, style: AppTextStyle.titleLarge)),
//               if (trailing != null)
//                 Text(trailing!, style: AppTextStyle.caption),
//             ],
//           ),
//           verticalSpace(18),
//           child,
//         ],
//       ),
//     );
//   }
// }

// /// حقلين جنب بعض في الشاشات العريضة، وتحت بعض في الضيقة.
// class _TwoCol extends StatelessWidget {
//   final Widget a;
//   final Widget b;
//   const _TwoCol(this.a, this.b);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, c) {
//         if (c.maxWidth < 480) {
//           return Column(children: [a, verticalSpace(14), b]);
//         }
//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(child: a),
//             horizontalSpace(14),
//             Expanded(child: b),
//           ],
//         );
//       },
//     );
//   }
// }

// class _LookupsErrorBanner extends StatelessWidget {
//   const _LookupsErrorBanner();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
//       buildWhen: (p, c) => p.lookupsError != c.lookupsError,
//       builder: (context, state) {
//         final error = state.lookupsError;
//         if (error == null) return const SizedBox.shrink();
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 16),
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               color: AppColors.statusExpired.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: AppColors.statusExpired.withValues(alpha: 0.3),
//               ),
//             ),
//             child: Row(
//               children: [
//                 const Icon(
//                   Icons.error_outline,
//                   size: 18,
//                   color: AppColors.statusExpired,
//                 ),
//                 horizontalSpace(10),
//                 Expanded(
//                   child: Text(
//                     'تعذر تحميل البيانات: $error',
//                     style: AppTextStyle.bodySmall.copyWith(
//                       color: AppColors.statusExpired,
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () =>
//                       context.read<RegisterMemberCubit>().loadLookups(),
//                   child: const Text('إعادة المحاولة'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // ───────────────────────────── 1. Personal ─────────────────────────────

// class _PersonalSection extends StatefulWidget {
//   final String? initialCode;
//   final ValueChanged<CreateMemberModel> onSubmit;
//   const _PersonalSection({required this.onSubmit, this.initialCode});

//   @override
//   State<_PersonalSection> createState() => _PersonalSectionState();
// }

// class _PersonalSectionState extends State<_PersonalSection> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _code = TextEditingController(
//     text: widget.initialCode,
//   );
//   final _name = TextEditingController();
//   final _phone = TextEditingController();
//   final _emergency = TextEditingController();
//   final _email = TextEditingController();
//   final _dobText = TextEditingController();
//   DateTime? _dob;

//   static final _phoneRegex = RegExp(r'^01[0125]\d{8}$');
//   static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

//   @override
//   void dispose() {
//     _code.dispose();
//     _name.dispose();
//     _phone.dispose();
//     _emergency.dispose();
//     _email.dispose();
//     _dobText.dispose();
//     super.dispose();
//   }

//   Future<void> _pickDob() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _dob ?? DateTime(2000),
//       firstDate: DateTime(1940),
//       lastDate: DateTime.now(),
//     );
//     if (picked == null) return;
//     setState(() {
//       // UTC عشان اليوم ما يتغيرش بفرق التوقيت
//       _dob = DateTime.utc(picked.year, picked.month, picked.day);
//       _dobText.text = DateFormat('yyyy-MM-dd').format(_dob!);
//     });
//   }

//   void _submit(int gender) {
//     if (!_formKey.currentState!.validate()) return;
//     FocusScope.of(context).unfocus();
//     widget.onSubmit(
//       CreateMemberModel(
//         code: _code.text.trim(),
//         name: _name.text.trim(),
//         gender: gender,
//         phone: _phone.text.trim(),
//         emergencyPhone: _emergency.text.trim(),
//         email: _email.text.trim(),
//         dateOfBirth: _dob!.toIso8601String(),
//       ),
//     );
//   }

//   String? _required(String? v, String msg) =>
//       (v == null || v.trim().isEmpty) ? msg : null;

//   String? _phoneValidator(String? v, {bool optional = false}) {
//     final t = v?.trim() ?? '';
//     if (t.isEmpty) return optional ? null : 'أدخل رقم الموبايل';
//     return _phoneRegex.hasMatch(t) ? null : 'رقم موبايل مصري غير صحيح (11 رقم)';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
//       buildWhen: (p, c) =>
//           p.gender != c.gender ||
//           p.createMemberStatus != c.createMemberStatus ||
//           p.createdMember != c.createdMember,
//       builder: (context, state) {
//         final locked = state.isMemberCreated;
//         final loading = state.createMemberStatus == RegisterStatus.loading;

//         return _Section(
//           number: 1,
//           title: 'بيانات العضو الشخصية',
//           trailing: 'الخطوة 1 من 2',
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 _TwoCol(
//                   CustomTextFormField(
//                     controller: _code,
//                     label: 'كود العضو',
//                     hint: 'M1001',
//                     prefixIcon: Icons.qr_code_2_rounded,
//                     readOnly: locked || widget.initialCode != null,
//                     textInputAction: TextInputAction.next,
//                     validator: (v) => _required(v, 'أدخل كود العضو'),
//                   ),
//                   CustomTextFormField(
//                     controller: _name,
//                     label: 'الاسم الكامل',
//                     hint: 'أحمد مصطفى السعيد',
//                     prefixIcon: Icons.person_outline,
//                     readOnly: locked,
//                     textInputAction: TextInputAction.next,
//                     validator: (v) => _required(v, 'أدخل اسم العضو'),
//                   ),
//                 ),
//                 verticalSpace(14),
//                 _TwoCol(
//                   CustomTextFormField(
//                     controller: _phone,
//                     label: 'رقم الموبايل',
//                     hint: '01012345678',
//                     prefixIcon: Icons.phone_outlined,
//                     keyboardType: TextInputType.phone,
//                     readOnly: locked,
//                     maxLength: 11,
//                     textInputAction: TextInputAction.next,
//                     validator: _phoneValidator,
//                   ),
//                   CustomTextFormField(
//                     controller: _emergency,
//                     label: 'رقم الطوارئ (اختياري)',
//                     hint: '01112345678',
//                     prefixIcon: Icons.emergency_outlined,
//                     keyboardType: TextInputType.phone,
//                     readOnly: locked,
//                     maxLength: 11,
//                     textInputAction: TextInputAction.next,
//                     validator: (v) => _phoneValidator(v, optional: true),
//                   ),
//                 ),
//                 verticalSpace(14),
//                 _TwoCol(
//                   CustomTextFormField(
//                     controller: _dobText,
//                     label: 'تاريخ الميلاد',
//                     hint: 'اختر التاريخ',
//                     prefixIcon: Icons.calendar_today_outlined,
//                     readOnly: true,
//                     onTap: locked ? null : _pickDob,
//                     validator: (_) =>
//                         _dob == null ? 'اختر تاريخ الميلاد' : null,
//                   ),
//                   CustomTextFormField(
//                     controller: _email,
//                     label: 'البريد الإلكتروني (اختياري)',
//                     hint: 'name@example.com',
//                     prefixIcon: Icons.mail_outline,
//                     keyboardType: TextInputType.emailAddress,
//                     readOnly: locked,
//                     textInputAction: TextInputAction.done,
//                     validator: (v) {
//                       final t = v?.trim() ?? '';
//                       if (t.isEmpty) return null;
//                       return _emailRegex.hasMatch(t)
//                           ? null
//                           : 'بريد إلكتروني غير صحيح';
//                     },
//                   ),
//                 ),
//                 verticalSpace(14),
//                 Align(
//                   alignment: AlignmentDirectional.centerStart,
//                   child: _Gender(
//                     gender: state.gender,
//                     locked: locked,
//                     onChanged: (g) =>
//                         context.read<RegisterMemberCubit>().changeGender(g),
//                   ),
//                 ),
//                 verticalSpace(20),
//                 if (locked)
//                   const _DoneChip('تم تسجيل العضو بنجاح')
//                 else
//                   CustomButton(
//                     text: 'تسجيل العضو والمتابعة',
//                     prefixIcon: const Icon(
//                       Icons.person_add_alt_1_rounded,
//                       size: 18,
//                       color: AppColors.textOnPrimary,
//                     ),
//                     isLoading: loading,
//                     onPressed: () => _submit(state.gender),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _DoneChip extends StatelessWidget {
//   final String text;
//   const _DoneChip(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 14),
//       decoration: BoxDecoration(
//         color: AppColors.statusActiveBg,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.statusActiveBorder),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(
//             Icons.check_circle_outline_rounded,
//             size: 18,
//             color: AppColors.statusActive,
//           ),
//           horizontalSpace(8),
//           Text(
//             text,
//             style: AppTextStyle.labelLarge.copyWith(
//               color: AppColors.statusActive,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _Gender extends StatelessWidget {
//   final int gender; // 1 = ذكر, 2 = أنثى
//   final bool locked;
//   final ValueChanged<int> onChanged;
//   const _Gender({
//     required this.gender,
//     required this.locked,
//     required this.onChanged,
//   });

//   Widget _opt(String label, int value) {
//     final on = gender == value;
//     return Expanded(
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: locked ? null : () => onChanged(value),
//         child: Container(
//           height: 48,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: on ? AppColors.neonLimeBg : AppColors.surfaceContainer,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: on ? AppColors.primary : AppColors.strokeStrong,
//             ),
//           ),
//           child: Text(
//             label,
//             style: AppTextStyle.labelLarge.copyWith(
//               color: on ? AppColors.primary : AppColors.textSecondary,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(maxWidth: 320),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('الجنس', style: AppTextStyle.inputLabel),
//           verticalSpace(6),
//           Row(children: [_opt('ذكر', 1), horizontalSpace(10), _opt('أنثى', 2)]),
//         ],
//       ),
//     );
//   }
// }

// // ───────────────────────────── 2. Plans ─────────────────────────────

// class _PlansSection extends StatelessWidget {
//   const _PlansSection();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
//       buildWhen: (p, c) =>
//           p.packages != c.packages ||
//           p.packagesStatus != c.packagesStatus ||
//           p.selectedPackage != c.selectedPackage ||
//           p.createdMember != c.createdMember ||
//           p.subscription != c.subscription,
//       builder: (context, state) {
//         final enabled = state.isMemberCreated && !state.isSubscribed;

//         return Opacity(
//           opacity: state.isMemberCreated ? 1 : 0.45,
//           child: IgnorePointer(
//             ignoring: !enabled,
//             child: _Section(
//               number: 2,
//               title: 'اختيار الباقة والمدرب',
//               trailing: 'الخطوة 2 من 2',
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (!state.isMemberCreated) ...[
//                     Text(
//                       'سجّل بيانات العضو أولاً لتفعيل هذه الخطوة',
//                       style: AppTextStyle.caption,
//                     ),
//                     verticalSpace(14),
//                   ],
//                   _PackagesGrid(state: state),
//                   verticalSpace(18),
//                   const _TrainerPicker(),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _PackagesGrid extends StatelessWidget {
//   final RegisterMemberState state;
//   const _PackagesGrid({required this.state});

//   @override
//   Widget build(BuildContext context) {
//     switch (state.packagesStatus) {
//       case RegisterStatus.initial:
//         return const SizedBox.shrink(); // لسه ما اتسجلش عضو
//       case RegisterStatus.loading:
//         return const Padding(
//           padding: EdgeInsets.symmetric(vertical: 24),
//           child: Center(
//             child: SpinKitFadingCircle(color: AppColors.primary, size: 36),
//           ),
//         );
//       case RegisterStatus.failure:
//         return Text('تعذر تحميل الباقات', style: AppTextStyle.caption);
//       case RegisterStatus.success:
//         if (state.packages.isEmpty) {
//           return Text('لا توجد باقات متاحة', style: AppTextStyle.caption);
//         }
//         return LayoutBuilder(
//           builder: (context, c) {
//             final cols = c.maxWidth >= 560 ? 2 : 1;
//             const gap = 14.0;
//             final w = (c.maxWidth - gap * (cols - 1)) / cols;
//             return Wrap(
//               spacing: gap,
//               runSpacing: gap,
//               children: [
//                 for (final p in state.packages)
//                   SizedBox(
//                     width: w,
//                     child: _PlanCard(
//                       plan: p,
//                       selected: state.selectedPackage?.id == p.id,
//                       onTap: () =>
//                           context.read<RegisterMemberCubit>().selectPackage(p),
//                     ),
//                   ),
//               ],
//             );
//           },
//         );
//     }
//   }
// }

// class _PlanCard extends StatelessWidget {
//   final PackageModel plan;
//   final bool selected;
//   final VoidCallback onTap;
//   const _PlanCard({
//     required this.plan,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final description = (plan.description ?? '').trim();

//     return InkWell(
//       borderRadius: BorderRadius.circular(14),
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: selected ? AppColors.neonLimeBg : AppColors.surfaceContainer,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//             color: selected ? AppColors.primary : AppColors.strokeStrong,
//             width: selected ? 1.5 : 1,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     plan.name,
//                     style: AppTextStyle.labelLarge.copyWith(
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   selected ? Icons.check_circle : Icons.radio_button_unchecked,
//                   size: 20,
//                   color: selected ? AppColors.primary : AppColors.textTertiary,
//                 ),
//               ],
//             ),
//             verticalSpace(8),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   _money(plan.price),
//                   style: AppTextStyle.headlineMedium.copyWith(
//                     color: AppColors.primary,
//                   ),
//                 ),
//                 horizontalSpace(6),
//                 Text(_currency, style: AppTextStyle.caption),
//                 const Spacer(),
//                 Text(
//                   '${plan.durationDays} يوم'
//                   '${plan.maxSessions != null ? ' • ${plan.maxSessions} جلسة' : ''}',
//                   style: AppTextStyle.caption,
//                 ),
//               ],
//             ),
//             if (description.isNotEmpty) ...[
//               verticalSpace(10),
//               Text(description, style: AppTextStyle.bodySmall),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// اختيار المدرب اختياري. "بدون مدرب" هو الافتراضي.
// class _TrainerPicker extends StatelessWidget {
//   const _TrainerPicker();

//   OutlineInputBorder _b() => OutlineInputBorder(
//     borderRadius: BorderRadius.circular(12),
//     borderSide: const BorderSide(color: AppColors.strokeStrong),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
//       buildWhen: (p, c) =>
//           p.trainers != c.trainers ||
//           p.trainersStatus != c.trainersStatus ||
//           p.selectedTrainer != c.selectedTrainer,
//       builder: (context, state) {
//         final loading = state.trainersStatus == RegisterStatus.loading;
//         final TrainersModel? selected = state.selectedTrainer;
//         final noTrainers = state.trainers.isEmpty;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('المدرب المخصص (اختياري)', style: AppTextStyle.inputLabel),
//             verticalSpace(6),
//             InputDecorator(
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: AppColors.surfaceContainer,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 4,
//                 ),
//                 prefixIcon: const Icon(
//                   Icons.sports_gymnastics_outlined,
//                   size: 18,
//                   color: AppColors.textTertiary,
//                 ),
//                 border: _b(),
//                 enabledBorder: _b(),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<int?>(
//                   isExpanded: true,
//                   value: selected?.id,
//                   dropdownColor: AppColors.surfaceContainer,
//                   style: AppTextStyle.inputText.copyWith(fontSize: 14),
//                   hint: Text(
//                     loading
//                         ? 'جاري تحميل المدربين...'
//                         : noTrainers
//                         ? 'لا يوجد مدربون متاحون'
//                         : 'بدون مدرب',
//                     style: AppTextStyle.inputHint.copyWith(fontSize: 14),
//                   ),
//                   items: [
//                     const DropdownMenuItem<int?>(
//                       value: null,
//                       child: Text('بدون مدرب'),
//                     ),
//                     for (final t in state.trainers)
//                       DropdownMenuItem<int?>(value: t.id, child: Text(t.name)),
//                   ],
//                   onChanged: loading || noTrainers
//                       ? null
//                       : (id) {
//                           final trainer = id == null
//                               ? null
//                               : state.trainers.firstWhere((t) => t.id == id);
//                           context.read<RegisterMemberCubit>().selectTrainer(
//                             trainer,
//                           );
//                         },
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// // ───────────────────────────── Receipt summary ─────────────────────────────

// class _ReceiptSummary extends StatelessWidget {
//   const _ReceiptSummary();

//   Widget _line(String k, String v, {bool ltr = false}) => Padding(
//     padding: const EdgeInsets.symmetric(vertical: 5),
//     child: Row(
//       children: [
//         Expanded(child: Text(k, style: AppTextStyle.caption)),
//         Flexible(
//           child: Text(
//             v,
//             textDirection: ltr ? TextDirection.ltr : null,
//             textAlign: TextAlign.end,
//             style: AppTextStyle.labelMedium.copyWith(
//               color: AppColors.textPrimary,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
//       builder: (context, state) {
//         final package = state.selectedPackage;
//         final sub = state.subscription;
//         final member = state.createdMember;
//         final total = sub?.paidAmount ?? package?.price;
//         final submitting = state.subscriptionStatus == RegisterStatus.loading;

//         return Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             color: AppColors.surface,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: AppColors.strokeDefault),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   const Icon(
//                     Icons.receipt_long_rounded,
//                     size: 18,
//                     color: AppColors.primary,
//                   ),
//                   horizontalSpace(8),
//                   Text('ملخص الإيصال', style: AppTextStyle.titleMedium),
//                 ],
//               ),
//               verticalSpace(12),
//               _line(
//                 'تاريخ الإصدار',
//                 DateFormat('yyyy-MM-dd').format(EgyptTime.now()),
//                 ltr: true,
//               ),
//               _line('العضو', member?.name ?? '—'),
//               _line('الباقة', package?.name ?? '—'),
//               _line(
//                 'المدة',
//                 package == null ? '—' : '${package.durationDays} يوم',
//               ),
//               _line('المدرب', state.selectedTrainer?.name ?? 'بدون مدرب'),
//               _line('طريقة الدفع', 'نقدي'),
//               if (sub != null) ...[
//                 _line('بداية الاشتراك', _egyptDate(sub.startDate), ltr: true),
//                 _line('نهاية الاشتراك', _egyptDate(sub.endDate), ltr: true),
//               ],
//               const Divider(color: AppColors.strokeDefault),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       sub == null ? 'الإجمالي:' : 'المبلغ المدفوع:',
//                       style: AppTextStyle.titleMedium,
//                     ),
//                   ),
//                   Text(
//                     total == null ? '—' : _money(total),
//                     textDirection: TextDirection.ltr,
//                     style: AppTextStyle.headlineLarge.copyWith(
//                       color: AppColors.primary,
//                     ),
//                   ),
//                   horizontalSpace(6),
//                   Text(_currency, style: AppTextStyle.caption),
//                 ],
//               ),
//               verticalSpace(14),
//               if (sub != null)
//                 CustomButton(
//                   text: 'إنهاء والعودة',
//                   prefixIcon: const Icon(
//                     Icons.check_rounded,
//                     size: 18,
//                     color: AppColors.textOnPrimary,
//                   ),
//                   onPressed: () => Navigator.of(context).pop(true),
//                 )
//               else
//                 CustomButton(
//                   text: 'تأكيد الاشتراك',
//                   prefixIcon: const Icon(
//                     Icons.badge_outlined,
//                     size: 18,
//                     color: AppColors.textOnPrimary,
//                   ),
//                   isLoading: submitting,
//                   onPressed: state.canSubmitSubscription
//                       ? () => context
//                             .read<RegisterMemberCubit>()
//                             .createSubscription()
//                       : null,
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/helper/timezone_helper.dart' show EgyptTime;
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/core/widgets/custom_button.dart';
import 'package:gymsystem/core/widgets/custom_textform.dart';
import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/create_member_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/package_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/trainers_model.dart';
import 'package:gymsystem/features/register%20screen/logic/register/register_member_cubit.dart';
import 'package:gymsystem/features/register%20screen/logic/register/register_member_state.dart';
import 'package:intl/intl.dart' show DateFormat;

const _currency = 'ج.م';

String _money(num v) => v.toStringAsFixed(2);

/// يقبل DateTime أو String (ISO 8601) ويرجّع تاريخ بتوقيت مصر.
String _egyptDate(dynamic v) {
  final d = v is DateTime ? v : DateTime.parse(v as String);
  return DateFormat('yyyy-MM-dd').format(EgyptTime.from(d));
}

// ───────────────────────────── Screen ─────────────────────────────

class RegisterMemberScreen extends StatefulWidget {
  final String? memberCode;
  const RegisterMemberScreen({this.memberCode, super.key});

  @override
  State<RegisterMemberScreen> createState() => _RegisterMemberScreenState();
}

class _RegisterMemberScreenState extends State<RegisterMemberScreen> {
  void _snack(String message, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? AppColors.statusExpired : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.value(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    final form = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _LookupsErrorBanner(),
        _PersonalSection(
          initialCode: widget.memberCode,
          onSubmit: (model) =>
              context.read<RegisterMemberCubit>().createMember(model),
        ),
        verticalSpace(20),
        const _PlansSection(),
        verticalSpace(20),
        const _ActivitiesSection(),
      ],
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterMemberCubit, RegisterMemberState>(
          listenWhen: (p, c) => p.createMemberStatus != c.createMemberStatus,
          listener: (context, state) {
            if (state.createMemberStatus == RegisterStatus.failure) {
              _snack(state.errorMessage ?? 'تعذر تسجيل العضو', error: true);
            }
            if (state.createMemberStatus == RegisterStatus.success) {
              _snack('تم تسجيل العضو، اختر باقة أو نشاط (أو الاتنين) للمتابعة');
            }
          },
        ),
        BlocListener<RegisterMemberCubit, RegisterMemberState>(
          listenWhen: (p, c) => p.subscriptionStatus != c.subscriptionStatus,
          listener: (context, state) {
            if (state.subscriptionStatus == RegisterStatus.failure) {
              _snack(state.errorMessage ?? 'تعذر إنشاء الاشتراك', error: true);
            }
            if (state.subscriptionStatus == RegisterStatus.success) {
              _snack('تم الاشتراك في الباقة بنجاح');
            }
          },
        ),
        BlocListener<RegisterMemberCubit, RegisterMemberState>(
          listenWhen: (p, c) => p.activitySubStatus != c.activitySubStatus,
          listener: (context, state) {
            if (state.activitySubStatus == RegisterStatus.failure) {
              _snack(
                state.activityError ?? 'تعذر الاشتراك في النشاط',
                error: true,
              );
            }
            if (state.activitySubStatus == RegisterStatus.success) {
              _snack('تم الاشتراك في النشاط بنجاح');
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(pad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Header(),
                verticalSpace(20),
                context.isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 7, child: form),
                          horizontalSpace(20),
                          const Expanded(flex: 3, child: _ReceiptSummary()),
                        ],
                      )
                    : Column(
                        children: [
                          form,
                          verticalSpace(20),
                          const _ReceiptSummary(),
                        ],
                      ),
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
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        verticalSpace(4),
        Text(
          'تسجيل مشترك جديد',
          style: AppTextStyle.displaySmall.scaled(context),
        ),
      ],
    );
  }
}

// ───────────────────────────── Shared pieces ─────────────────────────────

class _Section extends StatelessWidget {
  final int number;
  final String title;
  final String? trailing;
  final Widget child;
  const _Section({
    required this.number,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.textOnPrimary,
                  ),
                ),
              ),
              horizontalSpace(10),
              Expanded(child: Text(title, style: AppTextStyle.titleLarge)),
              if (trailing != null)
                Text(trailing!, style: AppTextStyle.caption),
            ],
          ),
          verticalSpace(18),
          child,
        ],
      ),
    );
  }
}

/// حقلين جنب بعض في الشاشات العريضة، وتحت بعض في الضيقة.
class _TwoCol extends StatelessWidget {
  final Widget a;
  final Widget b;
  const _TwoCol(this.a, this.b);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 480) {
          return Column(children: [a, verticalSpace(14), b]);
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: a),
            horizontalSpace(14),
            Expanded(child: b),
          ],
        );
      },
    );
  }
}

class _LookupsErrorBanner extends StatelessWidget {
  const _LookupsErrorBanner();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
      buildWhen: (p, c) => p.lookupsError != c.lookupsError,
      builder: (context, state) {
        final error = state.lookupsError;
        if (error == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.statusExpired.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.statusExpired.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 18,
                  color: AppColors.statusExpired,
                ),
                horizontalSpace(10),
                Expanded(
                  child: Text(
                    'تعذر تحميل البيانات: $error',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.statusExpired,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      context.read<RegisterMemberCubit>().loadLookups(),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ───────────────────────────── 1. Personal ─────────────────────────────

class _PersonalSection extends StatefulWidget {
  final String? initialCode;
  final ValueChanged<CreateMemberModel> onSubmit;
  const _PersonalSection({required this.onSubmit, this.initialCode});

  @override
  State<_PersonalSection> createState() => _PersonalSectionState();
}

class _PersonalSectionState extends State<_PersonalSection> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _code = TextEditingController(
    text: widget.initialCode,
  );
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _emergency = TextEditingController();
  final _email = TextEditingController();
  final _dobText = TextEditingController();
  DateTime? _dob;

  static final _phoneRegex = RegExp(r'^01[0125]\d{8}$');
  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    _phone.dispose();
    _emergency.dispose();
    _email.dispose();
    _dobText.dispose();
    super.dispose();
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(2000),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );
    if (picked == null) return;
    setState(() {
      // UTC عشان اليوم ما يتغيرش بفرق التوقيت
      _dob = DateTime.utc(picked.year, picked.month, picked.day);
      _dobText.text = DateFormat('yyyy-MM-dd').format(_dob!);
    });
  }

  void _submit(int gender) {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    widget.onSubmit(
      CreateMemberModel(
        code: _code.text.trim(),
        name: _name.text.trim(),
        gender: gender,
        phone: _phone.text.trim(),
        emergencyPhone: _emergency.text.trim(),
        email: _email.text.trim(),
        dateOfBirth: _dob!.toIso8601String(),
      ),
    );
  }

  String? _required(String? v, String msg) =>
      (v == null || v.trim().isEmpty) ? msg : null;

  String? _phoneValidator(String? v, {bool optional = false}) {
    final t = v?.trim() ?? '';
    if (t.isEmpty) return optional ? null : 'أدخل رقم الموبايل';
    return _phoneRegex.hasMatch(t) ? null : 'رقم موبايل مصري غير صحيح (11 رقم)';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
      buildWhen: (p, c) =>
          p.gender != c.gender ||
          p.createMemberStatus != c.createMemberStatus ||
          p.createdMember != c.createdMember,
      builder: (context, state) {
        final locked = state.isMemberCreated;
        final loading = state.createMemberStatus == RegisterStatus.loading;

        return _Section(
          number: 1,
          title: 'بيانات العضو الشخصية',
          trailing: 'الخطوة 1 من 2',
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _TwoCol(
                  CustomTextFormField(
                    controller: _code,
                    label: 'كود العضو',
                    hint: 'M1001',
                    prefixIcon: Icons.qr_code_2_rounded,
                    readOnly: locked || widget.initialCode != null,
                    textInputAction: TextInputAction.next,
                    validator: (v) => _required(v, 'أدخل كود العضو'),
                  ),
                  CustomTextFormField(
                    controller: _name,
                    label: 'الاسم الكامل',
                    hint: 'أحمد مصطفى السعيد',
                    prefixIcon: Icons.person_outline,
                    readOnly: locked,
                    textInputAction: TextInputAction.next,
                    validator: (v) => _required(v, 'أدخل اسم العضو'),
                  ),
                ),
                verticalSpace(14),
                _TwoCol(
                  CustomTextFormField(
                    controller: _phone,
                    label: 'رقم الموبايل',
                    hint: '01012345678',
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    readOnly: locked,
                    maxLength: 11,
                    textInputAction: TextInputAction.next,
                    validator: _phoneValidator,
                  ),
                  CustomTextFormField(
                    controller: _emergency,
                    label: 'رقم الطوارئ (اختياري)',
                    hint: '01112345678',
                    prefixIcon: Icons.emergency_outlined,
                    keyboardType: TextInputType.phone,
                    readOnly: locked,
                    maxLength: 11,
                    textInputAction: TextInputAction.next,
                    validator: (v) => _phoneValidator(v, optional: true),
                  ),
                ),
                verticalSpace(14),
                _TwoCol(
                  CustomTextFormField(
                    controller: _dobText,
                    label: 'تاريخ الميلاد',
                    hint: 'اختر التاريخ',
                    prefixIcon: Icons.calendar_today_outlined,
                    readOnly: true,
                    onTap: locked ? null : _pickDob,
                    validator: (_) =>
                        _dob == null ? 'اختر تاريخ الميلاد' : null,
                  ),
                  CustomTextFormField(
                    controller: _email,
                    label: 'البريد الإلكتروني (اختياري)',
                    hint: 'name@example.com',
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: locked,
                    textInputAction: TextInputAction.done,
                    validator: (v) {
                      final t = v?.trim() ?? '';
                      if (t.isEmpty) return null;
                      return _emailRegex.hasMatch(t)
                          ? null
                          : 'بريد إلكتروني غير صحيح';
                    },
                  ),
                ),
                verticalSpace(14),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: _Gender(
                    gender: state.gender,
                    locked: locked,
                    onChanged: (g) =>
                        context.read<RegisterMemberCubit>().changeGender(g),
                  ),
                ),
                verticalSpace(20),
                if (locked)
                  const _DoneChip('تم تسجيل العضو بنجاح')
                else
                  CustomButton(
                    text: 'تسجيل العضو والمتابعة',
                    prefixIcon: const Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 18,
                      color: AppColors.textOnPrimary,
                    ),
                    isLoading: loading,
                    onPressed: () => _submit(state.gender),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DoneChip extends StatelessWidget {
  final String text;
  const _DoneChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.statusActiveBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.statusActiveBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            size: 18,
            color: AppColors.statusActive,
          ),
          horizontalSpace(8),
          Text(
            text,
            style: AppTextStyle.labelLarge.copyWith(
              color: AppColors.statusActive,
            ),
          ),
        ],
      ),
    );
  }
}

class _Gender extends StatelessWidget {
  final int gender; // 1 = ذكر, 2 = أنثى
  final bool locked;
  final ValueChanged<int> onChanged;
  const _Gender({
    required this.gender,
    required this.locked,
    required this.onChanged,
  });

  Widget _opt(String label, int value) {
    final on = gender == value;
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: locked ? null : () => onChanged(value),
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: on ? AppColors.neonLimeBg : AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: on ? AppColors.primary : AppColors.strokeStrong,
            ),
          ),
          child: Text(
            label,
            style: AppTextStyle.labelLarge.copyWith(
              color: on ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الجنس', style: AppTextStyle.inputLabel),
          verticalSpace(6),
          Row(children: [_opt('ذكر', 1), horizontalSpace(10), _opt('أنثى', 2)]),
        ],
      ),
    );
  }
}

// ───────────────────────────── 2. Plans ─────────────────────────────

class _PlansSection extends StatelessWidget {
  const _PlansSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
      buildWhen: (p, c) =>
          p.packages != c.packages ||
          p.packagesStatus != c.packagesStatus ||
          p.selectedPackage != c.selectedPackage ||
          p.createdMember != c.createdMember ||
          p.subscription != c.subscription,
      builder: (context, state) {
        final enabled = state.isMemberCreated && !state.isGymDone;

        return Opacity(
          opacity: state.isMemberCreated ? 1 : 0.45,
          child: IgnorePointer(
            ignoring: !enabled,
            child: _Section(
              number: 2,
              title: 'اشتراك الجيم: الباقة والمدرب',
              trailing: 'اختياري',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!state.isMemberCreated) ...[
                    Text(
                      'سجّل بيانات العضو أولاً لتفعيل هذه الخطوة',
                      style: AppTextStyle.caption,
                    ),
                    verticalSpace(14),
                  ] else if (state.isGymDone) ...[
                    const _DoneChip('تم الاشتراك في الباقة'),
                    verticalSpace(14),
                  ] else ...[
                    Text(
                      'اختر باقة أو نشاط أو الاتنين. اضغط على الباقة المختارة لإلغائها.',
                      style: AppTextStyle.caption,
                    ),
                    verticalSpace(14),
                  ],
                  _PackagesGrid(state: state),
                  verticalSpace(18),
                  const _TrainerPicker(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PackagesGrid extends StatelessWidget {
  final RegisterMemberState state;
  const _PackagesGrid({required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state.packagesStatus) {
      case RegisterStatus.initial:
        return const SizedBox.shrink(); // لسه ما اتسجلش عضو
      case RegisterStatus.loading:
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: SpinKitFadingCircle(color: AppColors.primary, size: 36),
          ),
        );
      case RegisterStatus.failure:
        return Text('تعذر تحميل الباقات', style: AppTextStyle.caption);
      case RegisterStatus.success:
        if (state.packages.isEmpty) {
          return Text('لا توجد باقات متاحة', style: AppTextStyle.caption);
        }
        return LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth >= 560 ? 2 : 1;
            const gap = 14.0;
            final w = (c.maxWidth - gap * (cols - 1)) / cols;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final p in state.packages)
                  SizedBox(
                    width: w,
                    child: _PlanCard(
                      plan: p,
                      selected: state.selectedPackage?.id == p.id,
                      onTap: () =>
                          context.read<RegisterMemberCubit>().selectPackage(p),
                    ),
                  ),
              ],
            );
          },
        );
    }
  }
}

class _PlanCard extends StatelessWidget {
  final PackageModel plan;
  final bool selected;
  final VoidCallback onTap;
  const _PlanCard({
    required this.plan,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final description = (plan.description ?? '').trim();

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppColors.neonLimeBg : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.strokeStrong,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    plan.name,
                    style: AppTextStyle.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  selected ? Icons.check_circle : Icons.radio_button_unchecked,
                  size: 20,
                  color: selected ? AppColors.primary : AppColors.textTertiary,
                ),
              ],
            ),
            verticalSpace(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _money(plan.price),
                  style: AppTextStyle.headlineMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                horizontalSpace(6),
                Text(_currency, style: AppTextStyle.caption),
                const Spacer(),
                Text(
                  '${plan.durationDays} يوم'
                  '${plan.maxSessions != null ? ' • ${plan.maxSessions} جلسة' : ''}',
                  style: AppTextStyle.caption,
                ),
              ],
            ),
            if (description.isNotEmpty) ...[
              verticalSpace(10),
              Text(description, style: AppTextStyle.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────── 3. Activities ─────────────────────────────

class _ActivitiesSection extends StatelessWidget {
  const _ActivitiesSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
      buildWhen: (p, c) =>
          p.activities != c.activities ||
          p.activitiesStatus != c.activitiesStatus ||
          p.selectedActivity != c.selectedActivity ||
          p.createdMember != c.createdMember ||
          p.activitySubscription != c.activitySubscription,
      builder: (context, state) {
        final enabled = state.isMemberCreated && !state.isActivityDone;

        return Opacity(
          opacity: state.isMemberCreated ? 1 : 0.45,
          child: IgnorePointer(
            ignoring: !enabled,
            child: _Section(
              number: 3,
              title: 'اشتراك الأنشطة',
              trailing: 'اختياري',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.isActivityDone) ...[
                    const _DoneChip('تم الاشتراك في النشاط'),
                    verticalSpace(14),
                  ],
                  _ActivitiesGrid(state: state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ActivitiesGrid extends StatelessWidget {
  final RegisterMemberState state;
  const _ActivitiesGrid({required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state.activitiesStatus) {
      case RegisterStatus.initial:
        return Text(
          'هتظهر الأنشطة بعد تسجيل العضو',
          style: AppTextStyle.caption,
        );
      case RegisterStatus.loading:
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: SpinKitFadingCircle(color: AppColors.primary, size: 36),
          ),
        );
      case RegisterStatus.failure:
        return Text('تعذر تحميل الأنشطة', style: AppTextStyle.caption);
      case RegisterStatus.success:
        if (state.activities.isEmpty) {
          return Text('لا توجد أنشطة متاحة', style: AppTextStyle.caption);
        }
        return LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth >= 560 ? 2 : 1;
            const gap = 14.0;
            final w = (c.maxWidth - gap * (cols - 1)) / cols;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final a in state.activities)
                  SizedBox(
                    width: w,
                    child: _ActivityCard(
                      activity: a,
                      selected: state.selectedActivity?.id == a.id,
                      onTap: () =>
                          context.read<RegisterMemberCubit>().selectActivity(a),
                    ),
                  ),
              ],
            );
          },
        );
    }
  }
}

class _ActivityCard extends StatelessWidget {
  final ActivitiesModel activity;
  final bool selected;
  final VoidCallback onTap;
  const _ActivityCard({
    required this.activity,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final schedule = activity.schedule.trim();
    final description = activity.description.trim();

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppColors.neonLimeBg : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.strokeStrong,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    activity.name,
                    style: AppTextStyle.labelLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  selected ? Icons.check_circle : Icons.radio_button_unchecked,
                  size: 20,
                  color: selected ? AppColors.primary : AppColors.textTertiary,
                ),
              ],
            ),
            if (schedule.isNotEmpty) ...[
              verticalSpace(4),
              Text(schedule, style: AppTextStyle.caption),
            ],
            verticalSpace(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _money(activity.price),
                  style: AppTextStyle.headlineMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                horizontalSpace(6),
                Text(_currency, style: AppTextStyle.caption),
                const Spacer(),
                Text(
                  '${activity.durationDays} يوم • ${activity.maxSessions} حصة',
                  style: AppTextStyle.caption,
                ),
              ],
            ),
            if (description.isNotEmpty) ...[
              verticalSpace(10),
              Text(description, style: AppTextStyle.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}

/// اختيار المدرب اختياري. "بدون مدرب" هو الافتراضي.
class _TrainerPicker extends StatelessWidget {
  const _TrainerPicker();

  OutlineInputBorder _b() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.strokeStrong),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
      buildWhen: (p, c) =>
          p.trainers != c.trainers ||
          p.trainersStatus != c.trainersStatus ||
          p.selectedTrainer != c.selectedTrainer,
      builder: (context, state) {
        final loading = state.trainersStatus == RegisterStatus.loading;
        final TrainersModel? selected = state.selectedTrainer;
        final noTrainers = state.trainers.isEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('المدرب المخصص (اختياري)', style: AppTextStyle.inputLabel),
            verticalSpace(6),
            InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.surfaceContainer,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                prefixIcon: const Icon(
                  Icons.sports_gymnastics_outlined,
                  size: 18,
                  color: AppColors.textTertiary,
                ),
                border: _b(),
                enabledBorder: _b(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int?>(
                  isExpanded: true,
                  value: selected?.id,
                  dropdownColor: AppColors.surfaceContainer,
                  style: AppTextStyle.inputText.copyWith(fontSize: 14),
                  hint: Text(
                    loading
                        ? 'جاري تحميل المدربين...'
                        : noTrainers
                        ? 'لا يوجد مدربون متاحون'
                        : 'بدون مدرب',
                    style: AppTextStyle.inputHint.copyWith(fontSize: 14),
                  ),
                  items: [
                    const DropdownMenuItem<int?>(
                      value: null,
                      child: Text('بدون مدرب'),
                    ),
                    for (final t in state.trainers)
                      DropdownMenuItem<int?>(value: t.id, child: Text(t.name)),
                  ],
                  onChanged: loading || noTrainers
                      ? null
                      : (id) {
                          final trainer = id == null
                              ? null
                              : state.trainers.firstWhere((t) => t.id == id);
                          context.read<RegisterMemberCubit>().selectTrainer(
                            trainer,
                          );
                        },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ───────────────────────────── Receipt summary ─────────────────────────────

class _ReceiptSummary extends StatelessWidget {
  const _ReceiptSummary();

  Widget _line(String k, String v, {bool ltr = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Expanded(child: Text(k, style: AppTextStyle.caption)),
        Flexible(
          child: Text(
            v,
            textDirection: ltr ? TextDirection.ltr : null,
            textAlign: TextAlign.end,
            style: AppTextStyle.labelMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _heading(String t) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 2),
    child: Text(
      t,
      style: AppTextStyle.labelMedium.copyWith(color: AppColors.primary),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterMemberCubit, RegisterMemberState>(
      builder: (context, state) {
        final package = state.selectedPackage;
        final activity = state.selectedActivity;
        final gymSub = state.subscription;
        final actSub = state.activitySubscription;
        final member = state.createdMember;

        // المدفوع فعلاً لو اتنفذ، وإلا السعر المتوقع
        final gymAmount = gymSub?.paidAmount ?? package?.price;
        final actAmount = actSub?.paidAmount ?? activity?.price;
        final num? total = (gymAmount == null && actAmount == null)
            ? null
            : (gymAmount ?? 0) + (actAmount ?? 0);
        final anyDone = state.isGymDone || state.isActivityDone;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.strokeDefault),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.receipt_long_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  horizontalSpace(8),
                  Text('ملخص الإيصال', style: AppTextStyle.titleMedium),
                ],
              ),
              verticalSpace(12),
              _line(
                'تاريخ الإصدار',
                DateFormat('yyyy-MM-dd').format(EgyptTime.now()),
                ltr: true,
              ),
              _line('العضو', member?.name ?? '—'),
              _line('طريقة الدفع', 'نقدي'),

              if (package != null) ...[
                _heading('اشتراك الجيم'),
                _line('الباقة', package.name),
                _line('المدة', '${package.durationDays} يوم'),
                _line('المدرب', state.selectedTrainer?.name ?? 'بدون مدرب'),
                if (gymSub != null) ...[
                  _line(
                    'بداية الاشتراك',
                    _egyptDate(gymSub.startDate),
                    ltr: true,
                  ),
                  _line(
                    'نهاية الاشتراك',
                    _egyptDate(gymSub.endDate),
                    ltr: true,
                  ),
                ],
                _line(
                  gymSub == null ? 'السعر' : 'المدفوع',
                  '${_money(gymAmount!)} $_currency',
                ),
              ],

              if (activity != null) ...[
                _heading('اشتراك النشاط'),
                _line('النشاط', activity.name),
                _line('المدة', '${activity.durationDays} يوم'),
                _line('الحصص', '${activity.maxSessions}'),
                if (actSub != null) ...[
                  _line(
                    'بداية الاشتراك',
                    _egyptDate(actSub.startDate),
                    ltr: true,
                  ),
                  _line(
                    'نهاية الاشتراك',
                    _egyptDate(actSub.endDate),
                    ltr: true,
                  ),
                ],
                _line(
                  actSub == null ? 'السعر' : 'المدفوع',
                  '${_money(actAmount!)} $_currency',
                ),
              ],

              if (package == null && activity == null) ...[
                verticalSpace(8),
                Text(
                  member == null
                      ? 'سجّل العضو أولاً'
                      : 'اختر باقة أو نشاط على الأقل',
                  style: AppTextStyle.caption,
                ),
              ],

              const Divider(color: AppColors.strokeDefault),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      state.isCompleted ? 'المبلغ المدفوع:' : 'الإجمالي:',
                      style: AppTextStyle.titleMedium,
                    ),
                  ),
                  Text(
                    total == null ? '—' : _money(total),
                    textDirection: TextDirection.ltr,
                    style: AppTextStyle.headlineLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  horizontalSpace(6),
                  Text(_currency, style: AppTextStyle.caption),
                ],
              ),
              verticalSpace(14),
              if (state.isCompleted)
                CustomButton(
                  text: 'إنهاء والعودة',
                  prefixIcon: const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: AppColors.textOnPrimary,
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                )
              else
                CustomButton(
                  text: anyDone ? 'تأكيد المتبقي' : 'تأكيد الاشتراك',
                  prefixIcon: const Icon(
                    Icons.badge_outlined,
                    size: 18,
                    color: AppColors.textOnPrimary,
                  ),
                  isLoading: state.isSubmitting,
                  onPressed: state.canSubmit
                      ? () => context
                            .read<RegisterMemberCubit>()
                            .createSubscription()
                      : null,
                ),
            ],
          ),
        );
      },
    );
  }
}
