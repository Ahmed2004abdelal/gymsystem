// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gymsystem/core/helper/spacer.dart';
// import 'package:gymsystem/core/theme/app_colors.dart';
// import 'package:gymsystem/core/theme/app_spacing.dart';
// import 'package:gymsystem/core/theme/app_text_style.dart';
// import 'package:gymsystem/core/widgets/snakebar.dart';
// import 'package:gymsystem/features/activities/logic/activities_cubit.dart';
// import 'package:gymsystem/features/activities/logic/activities_state.dart';
// import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';

// // ───────────────────────────── Screen ─────────────────────────────

// /// الـ ActivitiesCubit لازم يكون متوفر فوق الشاشة دي.
// class ActivitiesScreen extends StatefulWidget {
//   const ActivitiesScreen({super.key});

//   @override
//   State<ActivitiesScreen> createState() => _ActivitiesScreenState();
// }

// class _ActivitiesScreenState extends State<ActivitiesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ActivitiesCubit>().loadActivities();
//   }

//   Future<void> _openSubscribeDialog() async {
//     final cubit = context.read<ActivitiesCubit>();
//     final message = await showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) =>
//           BlocProvider.value(value: cubit, child: const _SubscribeDialog()),
//     );
//     if (message != null && mounted) {
//       AppSnackBar.show(context, message: message);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<ActivitiesCubit>();

//     return Scaffold(
//       backgroundColor: AppColors.surface,
//       // الشاشة كلها بتتبني من جديد بس لما حالة التحميل تتغير،
//       // وكل قسم جواها بيسمع للجزء بتاعه من الـ state بس.
//       body: BlocBuilder<ActivitiesCubit, ActivitiesState>(
//         buildWhen: (p, c) =>
//             p.listStatus != c.listStatus ||
//             p.activities.isEmpty != c.activities.isEmpty,
//         builder: (context, state) {
//           final empty = state.activities.isEmpty;

//           if (state.listStatus == ActivitiesStatus.loading && empty) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state.listStatus == ActivitiesStatus.failure && empty) {
//             return _ErrorView(
//               message: state.errorMessage ?? 'حصل خطأ',
//               onRetry: cubit.loadActivities,
//             );
//           }

//           return RefreshIndicator(
//             color: AppColors.primary,
//             onRefresh: () => cubit.loadActivities(),
//             child: CustomScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               slivers: [
//                 SliverPadding(
//                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//                   sliver: SliverToBoxAdapter(
//                     child: _CheckinCard(onSubscribe: _openSubscribeDialog),
//                   ),
//                 ),
//                 SliverPadding(
//                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//                   sliver: SliverToBoxAdapter(
//                     child: Text(
//                       'الأنشطة المتاحة',
//                       style: AppTextStyle.titleMedium,
//                     ),
//                   ),
//                 ),
//                 const _ActivitiesSliver(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // ───────────────────────────── Check-in card ─────────────────────────────

// class _CheckinCard extends StatefulWidget {
//   final VoidCallback onSubscribe;
//   const _CheckinCard({required this.onSubscribe});

//   @override
//   State<_CheckinCard> createState() => _CheckinCardState();
// }

// class _CheckinCardState extends State<_CheckinCard> {
//   final _formKey = GlobalKey<FormState>();
//   final _codeController = TextEditingController();
//   final _codeFocus = FocusNode();

//   /// بنخزن الـ id مش الـ object، لأن الـ object بيتغير مع كل تحديث للقائمة
//   /// وده كان بيكسر الـ Dropdown.
//   int? _activityId;

//   @override
//   void dispose() {
//     _codeController.dispose();
//     _codeFocus.dispose();
//     super.dispose();
//   }

//   void _checkin() {
//     if (!_formKey.currentState!.validate()) return;
//     final cubit = context.read<ActivitiesCubit>();
//     if (cubit.state.checkinStatus == ActivitiesStatus.loading) return;
//     cubit.checkin(
//       memberCode: _codeController.text.trim(),
//       activityId: _activityId!,
//     );
//   }

//   void _onCheckinChanged(BuildContext context, ActivitiesState state) {
//     final cubit = context.read<ActivitiesCubit>();
//     if (state.checkinStatus == ActivitiesStatus.success) {
//       AppSnackBar.show(
//         context,
//         message: state.checkinData?.message ?? 'تم تسجيل الحضور',
//       );
//       _codeController.clear();
//       cubit.resetCheckin();
//       _codeFocus.requestFocus(); // جاهز للعضو اللي بعده
//     } else if (state.checkinStatus == ActivitiesStatus.failure) {
//       AppSnackBar.show(
//         context,
//         message: state.errorMessage ?? 'حصل خطأ',
//         type: SnackType.error,
//       );
//       cubit.resetCheckin();
//       _codeFocus.requestFocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ActivitiesCubit, ActivitiesState>(
//       listenWhen: (p, c) => p.checkinStatus != c.checkinStatus,
//       listener: _onCheckinChanged,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: AppColors.surfaceContainer,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: AppColors.strokeDefault),
//         ),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('تسجيل حضور في نشاط', style: AppTextStyle.titleMedium),
//               verticalSpace(12),
//               TextFormField(
//                 controller: _codeController,
//                 focusNode: _codeFocus,
//                 autofocus: true,
//                 textDirection: TextDirection.ltr,
//                 textInputAction: TextInputAction.done,
//                 decoration: const InputDecoration(
//                   labelText: 'كود العضو',
//                   prefixIcon: Icon(Icons.qr_code_scanner_rounded),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (v) =>
//                     (v == null || v.trim().isEmpty) ? 'أدخل كود العضو' : null,
//                 onFieldSubmitted: (_) => _checkin(),
//               ),
//               verticalSpace(12),
//               BlocSelector<
//                 ActivitiesCubit,
//                 ActivitiesState,
//                 List<ActivitiesModel>
//               >(
//                 selector: (s) => s.activities,
//                 builder: (context, activities) {
//                   // لو النشاط المختار اتشال من القائمة منسيبوش مختار.
//                   final valid = activities.any((a) => a.id == _activityId)
//                       ? _activityId
//                       : null;
//                   return DropdownButtonFormField<int>(
//                     key: ValueKey(valid),
//                     initialValue: valid,
//                     isExpanded: true,
//                     decoration: const InputDecoration(
//                       labelText: 'النشاط',
//                       border: OutlineInputBorder(),
//                     ),
//                     items: [
//                       for (final a in activities)
//                         DropdownMenuItem(value: a.id, child: Text(a.name)),
//                     ],
//                     validator: (v) => v == null ? 'اختر النشاط أولاً' : null,
//                     onChanged: (v) => setState(() => _activityId = v),
//                   );
//                 },
//               ),
//               verticalSpace(12),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: BlocSelector<ActivitiesCubit, ActivitiesState, bool>(
//                       selector: (s) =>
//                           s.checkinStatus == ActivitiesStatus.loading,
//                       builder: (context, isCheckingIn) => FilledButton.icon(
//                         onPressed: isCheckingIn ? null : _checkin,
//                         icon: isCheckingIn
//                             ? const SizedBox(
//                                 width: 16,
//                                 height: 16,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                             : const Icon(Icons.remove_circle_outline),
//                         label: Text(
//                           isCheckingIn
//                               ? 'جاري التسجيل...'
//                               : 'تسجيل حضور (خصم حصة)',
//                         ),
//                       ),
//                     ),
//                   ),
//                   horizontalSpace(10),
//                   Expanded(
//                     flex: 2,
//                     child: OutlinedButton.icon(
//                       onPressed: widget.onSubscribe,
//                       icon: const Icon(Icons.person_add_alt_1),
//                       label: const Text('تسجيل مشترك'),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ───────────────────────────── Activities list ─────────────────────────────

// class _ActivitiesSliver extends StatelessWidget {
//   const _ActivitiesSliver();

//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<
//       ActivitiesCubit,
//       ActivitiesState,
//       List<ActivitiesModel>
//     >(
//       selector: (s) => s.activities,
//       builder: (context, activities) {
//         if (activities.isEmpty) {
//           return SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(24),
//               child: Center(
//                 child: Text('لا توجد أنشطة متاحة', style: AppTextStyle.bodyMd),
//               ),
//             ),
//           );
//         }
//         // ListView كسول: بيبني الصفوف اللي على الشاشة بس.
//         return SliverPadding(
//           padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
//           sliver: SliverList.builder(
//             itemCount: activities.length,
//             itemBuilder: (context, i) => Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: _ActivityTile(activity: activities[i]),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _ActivityTile extends StatelessWidget {
//   final ActivitiesModel activity;
//   const _ActivityTile({required this.activity});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainer,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.strokeDefault),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(activity.name, style: AppTextStyle.labelLarge),
//                 verticalSpace(2),
//                 Text(
//                   '${activity.schedule} • ${activity.maxSessions} حصة • ${activity.durationDays} يوم',
//                   style: AppTextStyle.caption,
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             '${activity.price.toStringAsFixed(0)} ج.م',
//             style: AppTextStyle.titleMedium.copyWith(color: AppColors.primary),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ErrorView extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;
//   const _ErrorView({required this.message, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             message,
//             style: AppTextStyle.bodyMd.copyWith(color: AppColors.error),
//           ),
//           verticalSpace(8),
//           TextButton.icon(
//             onPressed: onRetry,
//             icon: const Icon(Icons.refresh_rounded),
//             label: const Text('إعادة المحاولة'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ───────────────────────────── Subscribe dialog ─────────────────────────────

// /// بترجّع رسالة النجاح (String) عند الاشتراك، أو null لو اتلغت.
// // ───────────────────────────── Subscribe dialog ─────────────────────────────

// /// بترجّع رسالة النجاح (String) عند الاشتراك، أو null لو اتلغت.
// class _SubscribeDialog extends StatefulWidget {
//   const _SubscribeDialog();

//   @override
//   State<_SubscribeDialog> createState() => _SubscribeDialogState();
// }

// class _SubscribeDialogState extends State<_SubscribeDialog> {
//   final _memberId = TextEditingController();
//   int? _activityId;
//   String? _localError;

//   @override
//   void dispose() {
//     _memberId.dispose();
//     super.dispose();
//   }

//   void _submit() {
//     final cubit = context.read<ActivitiesCubit>();
//     if (cubit.state.subscribeStatus == ActivitiesStatus.loading) return;

//     final memberId = int.tryParse(_memberId.text.trim());
//     if (memberId == null) {
//       setState(() => _localError = 'أدخل رقم العضو (ID) صحيح');
//       return;
//     }
//     if (_activityId == null) {
//       setState(() => _localError = 'اختر نشاطاً');
//       return;
//     }
//     setState(() => _localError = null);
//     cubit.subscribe(memberId: memberId, activityId: _activityId!);
//   }

//   void _onSubscribeChanged(BuildContext context, ActivitiesState state) {
//     final cubit = context.read<ActivitiesCubit>();
//     if (state.subscribeStatus == ActivitiesStatus.success) {
//       final sub = state.subscriptionData;
//       final message = sub == null
//           ? 'تم الاشتراك بنجاح'
//           : 'تم اشتراك ${sub.memberName} في ${sub.activityName}';
//       cubit.resetSubscribe();
//       // الرسالة بتتعرض من الشاشة الأم، عشان الـ context بتاع الـ dialog بيتقفل.
//       Navigator.of(context).pop(message);
//     } else if (state.subscribeStatus == ActivitiesStatus.failure) {
//       setState(() => _localError = state.errorMessage ?? 'حصل خطأ');
//       cubit.resetSubscribe();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final maxHeight = MediaQuery.sizeOf(context).height * 0.9;

//     return BlocListener<ActivitiesCubit, ActivitiesState>(
//       listenWhen: (p, c) => p.subscribeStatus != c.subscribeStatus,
//       listener: _onSubscribeChanged,
//       child: BlocSelector<ActivitiesCubit, ActivitiesState, bool>(
//         selector: (s) => s.subscribeStatus == ActivitiesStatus.loading,
//         builder: (context, loading) {
//           return Dialog(
//             backgroundColor: AppColors.surfaceContainer,
//             insetPadding: const EdgeInsets.all(24),
//             clipBehavior: Clip.antiAlias,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//               side: const BorderSide(color: AppColors.strokeDefault),
//             ),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: 760, maxHeight: maxHeight),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   _DialogHeader(
//                     onClose: loading ? null : () => Navigator.of(context).pop(),
//                   ),
//                   const Divider(height: 1, color: AppColors.strokeDefault),
//                   Flexible(
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.all(24),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           // 1) بيانات المشترك
//                           const _SectionTitle(
//                             number: 1,
//                             title: 'بيانات المشترك',
//                             icon: Icons.badge_outlined,
//                           ),
//                           verticalSpace(12),
//                           TextField(
//                             controller: _memberId,
//                             autofocus: true,
//                             enabled: !loading,
//                             textDirection: TextDirection.ltr,
//                             keyboardType: TextInputType.number,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             style: AppTextStyle.inputText,
//                             onSubmitted: (_) => _submit(),
//                             decoration: _fieldDecoration(
//                               label: 'رقم العضو (ID)',
//                               icon: Icons.tag_rounded,
//                             ),
//                           ),
//                           verticalSpace(28),

//                           // 2) اختيار النشاط
//                           const _SectionTitle(
//                             number: 2,
//                             title: 'اختيار النشاط',
//                             icon: Icons.fitness_center_rounded,
//                           ),
//                           verticalSpace(12),
//                           BlocSelector<
//                             ActivitiesCubit,
//                             ActivitiesState,
//                             List<ActivitiesModel>
//                           >(
//                             selector: (s) => s.activities,
//                             builder: (context, activities) {
//                               if (activities.isEmpty) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(16),
//                                   child: Center(
//                                     child: Text(
//                                       'لا توجد أنشطة متاحة',
//                                       style: AppTextStyle.bodyMd,
//                                     ),
//                                   ),
//                                 );
//                               }
//                               return _ActivityGrid(
//                                 activities: activities,
//                                 selectedId: _activityId,
//                                 enabled: !loading,
//                                 onSelected: (id) =>
//                                     setState(() => _activityId = id),
//                               );
//                             },
//                           ),
//                           verticalSpace(28),

//                           // 3) الملخص
//                           const _SectionTitle(
//                             number: 3,
//                             title: 'ملخص الاشتراك',
//                             icon: Icons.receipt_long_rounded,
//                           ),
//                           verticalSpace(12),
//                           BlocSelector<
//                             ActivitiesCubit,
//                             ActivitiesState,
//                             List<ActivitiesModel>
//                           >(
//                             selector: (s) => s.activities,
//                             builder: (context, activities) {
//                               ActivitiesModel? selected;
//                               for (final a in activities) {
//                                 if (a.id == _activityId) selected = a;
//                               }
//                               return _SummaryCard(activity: selected);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   if (_localError != null) _ErrorBanner(message: _localError!),
//                   const Divider(height: 1, color: AppColors.strokeDefault),
//                   _DialogFooter(
//                     loading: loading,
//                     onSubmit: _submit,
//                     onCancel: () => Navigator.of(context).pop(),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// InputDecoration _fieldDecoration({
//   required String label,
//   required IconData icon,
// }) {
//   OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
//     borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
//     borderSide: BorderSide(color: c, width: w),
//   );

//   return InputDecoration(
//     labelText: label,
//     labelStyle: AppTextStyle.inputLabel,
//     floatingLabelStyle: AppTextStyle.inputLabel.copyWith(
//       color: AppColors.neonLime,
//     ),
//     prefixIcon: Icon(icon, color: AppColors.textSecondary),
//     filled: true,
//     fillColor: AppColors.surface,
//     border: border(AppColors.strokeDefault),
//     enabledBorder: border(AppColors.strokeDefault),
//     disabledBorder: border(AppColors.strokeDefault),
//     focusedBorder: border(AppColors.neonLime, 2),
//   );
// }

// // ── Header ──────────────────────────────────────────────────────────────────

// class _DialogHeader extends StatelessWidget {
//   final VoidCallback? onClose;
//   const _DialogHeader({required this.onClose});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: AppColors.neonLimeBg,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: AppColors.neonLime.withValues(alpha: 0.4),
//               ),
//             ),
//             child: const Icon(
//               Icons.person_add_alt_1_rounded,
//               color: AppColors.neonLime,
//             ),
//           ),
//           horizontalSpace(14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('تسجيل مشترك في نشاط', style: AppTextStyle.headlineLg),
//                 verticalSpace(2),
//                 Text(
//                   'أدخل رقم العضو واختر النشاط لإتمام الاشتراك',
//                   style: AppTextStyle.bodyMd,
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: onClose,
//             icon: const Icon(Icons.close_rounded),
//             color: AppColors.textPrimary,
//             style: IconButton.styleFrom(
//               backgroundColor: AppColors.surface,
//               fixedSize: const Size(44, 44),
//               side: const BorderSide(color: AppColors.strokeDefault),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SectionTitle extends StatelessWidget {
//   final int number;
//   final String title;
//   final IconData icon;
//   const _SectionTitle({
//     required this.number,
//     required this.title,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 28,
//           height: 28,
//           alignment: Alignment.center,
//           decoration: const BoxDecoration(
//             color: AppColors.neonLimeBg,
//             shape: BoxShape.circle,
//           ),
//           child: Text(
//             '$number',
//             style: AppTextStyle.labelMd.copyWith(
//               color: AppColors.neonLime,
//               fontSize: 14,
//             ),
//           ),
//         ),
//         horizontalSpace(10),
//         Text(title, style: AppTextStyle.headlineMd),
//         const Spacer(),
//         Icon(icon, size: 20, color: AppColors.textSecondary),
//       ],
//     );
//   }
// }

// // ── Activity cards ─────────────────────────────────────────────────────────

// class _ActivityGrid extends StatelessWidget {
//   final List<ActivitiesModel> activities;
//   final int? selectedId;
//   final bool enabled;
//   final ValueChanged<int> onSelected;

//   const _ActivityGrid({
//     required this.activities,
//     required this.selectedId,
//     required this.enabled,
//     required this.onSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, c) {
//         const spacing = 12.0;
//         final cols = c.maxWidth >= 600 ? 3 : (c.maxWidth >= 380 ? 2 : 1);
//         final w = (c.maxWidth - spacing * (cols - 1)) / cols;

//         return Wrap(
//           spacing: spacing,
//           runSpacing: spacing,
//           children: [
//             for (final a in activities)
//               SizedBox(
//                 width: w,
//                 child: _ActivityChoiceCard(
//                   activity: a,
//                   selected: a.id == selectedId,
//                   onTap: enabled ? () => onSelected(a.id) : null,
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _ActivityChoiceCard extends StatelessWidget {
//   final ActivitiesModel activity;
//   final bool selected;
//   final VoidCallback? onTap;

//   const _ActivityChoiceCard({
//     required this.activity,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(14),
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 150),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: selected ? AppColors.neonLimeBg : AppColors.surface,
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(
//               color: selected ? AppColors.neonLime : AppColors.strokeDefault,
//               width: selected ? 2 : 1,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       activity.name,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: AppTextStyle.headlineMd,
//                     ),
//                   ),
//                   horizontalSpace(8),
//                   Icon(
//                     selected
//                         ? Icons.check_circle_rounded
//                         : Icons.radio_button_unchecked_rounded,
//                     size: 22,
//                     color: selected
//                         ? AppColors.neonLime
//                         : AppColors.textSecondary,
//                   ),
//                 ],
//               ),
//               verticalSpace(6),
//               Text(
//                 activity.schedule,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: AppTextStyle.bodyMd.copyWith(fontSize: 13),
//               ),
//               verticalSpace(10),
//               Wrap(
//                 spacing: 6,
//                 runSpacing: 6,
//                 children: [
//                   _InfoPill('${activity.maxSessions} حصة'),
//                   _InfoPill('${activity.durationDays} يوم'),
//                 ],
//               ),
//               verticalSpace(14),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.baseline,
//                 textBaseline: TextBaseline.alphabetic,
//                 children: [
//                   Text(
//                     activity.price.toStringAsFixed(0),
//                     style: AppTextStyle.headlineXl.copyWith(
//                       color: AppColors.neonLime,
//                     ),
//                   ),
//                   horizontalSpace(6),
//                   Text('ج.م', style: AppTextStyle.bodyMd),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _InfoPill extends StatelessWidget {
//   final String text;
//   const _InfoPill(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: AppColors.surfaceContainer,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: AppColors.strokeDefault),
//       ),
//       child: Text(
//         text,
//         style: AppTextStyle.labelMd.copyWith(color: AppColors.textSecondary),
//       ),
//     );
//   }
// }

// // ── Summary ────────────────────────────────────────────────────────────────

// class _SummaryCard extends StatelessWidget {
//   final ActivitiesModel? activity;
//   const _SummaryCard({required this.activity});

//   @override
//   Widget build(BuildContext context) {
//     final a = activity;

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.strokeDefault),
//       ),
//       child: a == null
//           ? Row(
//               children: [
//                 const Icon(
//                   Icons.info_outline_rounded,
//                   size: 20,
//                   color: AppColors.textSecondary,
//                 ),
//                 horizontalSpace(10),
//                 Expanded(
//                   child: Text(
//                     'اختر نشاطاً لعرض تفاصيل الاشتراك',
//                     style: AppTextStyle.bodyMd,
//                   ),
//                 ),
//               ],
//             )
//           : Column(
//               children: [
//                 _SummaryRow(label: 'النشاط', value: a.name),
//                 _SummaryRow(label: 'المواعيد', value: a.schedule),
//                 _SummaryRow(label: 'عدد الحصص', value: '${a.maxSessions}'),
//                 _SummaryRow(
//                   label: 'مدة الاشتراك',
//                   value: '${a.durationDays} يوم',
//                 ),
//                 verticalSpace(8),
//                 const Divider(height: 1, color: AppColors.strokeDefault),
//                 verticalSpace(12),
//                 Row(
//                   children: [
//                     Text('إجمالي المبلغ', style: AppTextStyle.headlineMd),
//                     const Spacer(),
//                     Text(
//                       '${a.price.toStringAsFixed(0)} ج.م',
//                       style: AppTextStyle.headlineXl.copyWith(
//                         color: AppColors.neonLime,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//     );
//   }
// }

// class _SummaryRow extends StatelessWidget {
//   final String label;
//   final String value;
//   const _SummaryRow({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         children: [
//           Text(label, style: AppTextStyle.bodyMd),
//           horizontalSpace(16),
//           Expanded(
//             child: Text(
//               value,
//               textAlign: TextAlign.end,
//               style: AppTextStyle.bodyMd.copyWith(
//                 color: AppColors.textPrimary,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Error + Footer ─────────────────────────────────────────────────────────

// class _ErrorBanner extends StatelessWidget {
//   final String message;
//   const _ErrorBanner({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.statusExpiredBg,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: AppColors.statusExpiredBorder),
//       ),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.error_outline_rounded,
//             size: 20,
//             color: AppColors.errorLight,
//           ),
//           horizontalSpace(8),
//           Expanded(
//             child: Text(
//               message,
//               style: AppTextStyle.bodyMd.copyWith(color: AppColors.errorLight),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DialogFooter extends StatelessWidget {
//   final bool loading;
//   final VoidCallback onSubmit;
//   final VoidCallback onCancel;

//   const _DialogFooter({
//     required this.loading,
//     required this.onSubmit,
//     required this.onCancel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final shape = RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
//     );
//     const size = Size.fromHeight(AppSpacing.buttonHeightLarge);

//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 3,
//             child: FilledButton.icon(
//               onPressed: loading ? null : onSubmit,
//               style: FilledButton.styleFrom(
//                 backgroundColor: AppColors.neonLime,
//                 foregroundColor: AppColors.onNeonLime,
//                 disabledBackgroundColor: AppColors.neonLimeDim.withValues(
//                   alpha: 0.5,
//                 ),
//                 minimumSize: size,
//                 shape: shape,
//               ),
//               icon: loading
//                   ? const SizedBox(
//                       width: 18,
//                       height: 18,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         color: AppColors.onNeonLime,
//                       ),
//                     )
//                   : const Icon(Icons.check_rounded),
//               label: Text(
//                 loading ? 'جاري الاشتراك...' : 'تأكيد الاشتراك',
//                 style: AppTextStyle.labelLg.copyWith(fontSize: 16),
//               ),
//             ),
//           ),
//           horizontalSpace(12),
//           Expanded(
//             flex: 1,
//             child: OutlinedButton(
//               onPressed: loading ? null : onCancel,
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: AppColors.textPrimary,
//                 side: const BorderSide(color: AppColors.strokeStrong),
//                 minimumSize: size,
//                 shape: shape,
//               ),
//               child: Text('إلغاء', style: AppTextStyle.buttonSecondary),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/helper/extensions.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/routing/routes.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_spacing.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/core/widgets/snakebar.dart';
import 'package:gymsystem/features/activities/logic/activities_cubit.dart';
import 'package:gymsystem/features/activities/logic/activities_state.dart';
import 'package:gymsystem/features/activities/data/models/member_activity_logedin_model.dart';
import 'package:gymsystem/features/activities/ui/widgets/member_details_card.dart';
import 'package:gymsystem/features/home/data/models/member_show_card_model.dart';
import 'package:gymsystem/features/register%20screen/data/models/activities_model.dart';
import 'package:intl/intl.dart' show DateFormat;

// ───────────────────────────── Screen ─────────────────────────────

/// الـ ActivitiesCubit لازم يكون متوفر فوق الشاشة دي.
class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ActivitiesCubit>().loadActivities();
  }

  /// تسجيل مشترك في نشاط/أكتر: بياخد العضو من نتيجة البحث بالكود (من غير ID يدوي).
  Future<void> _openSubscribeDialog() async {
    final member = context.read<ActivitiesCubit>().state.memberCard;
    if (member == null) {
      AppSnackBar.show(
        context,
        message: 'أدخل كود العضو واضغط بحث أولاً',
        type: SnackType.error,
      );
      return;
    }
    await _openAddActivitiesDialog(context, member);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActivitiesCubit>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      // الشاشة كلها بتتبني من جديد بس لما حالة التحميل تتغير،
      // وكل قسم جواها بيسمع للجزء بتاعه من الـ state بس.
      body: BlocBuilder<ActivitiesCubit, ActivitiesState>(
        buildWhen: (p, c) =>
            p.listStatus != c.listStatus ||
            p.activities.isEmpty != c.activities.isEmpty,
        builder: (context, state) {
          final empty = state.activities.isEmpty;

          if (state.listStatus == ActivitiesStatus.loading && empty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.listStatus == ActivitiesStatus.failure && empty) {
            return _ErrorView(
              message: state.errorMessage ?? 'حصل خطأ',
              onRetry: cubit.loadActivities,
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () => cubit.loadActivities(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: _CheckinCard(onSubscribe: _openSubscribeDialog),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'الأنشطة المتاحة',
                      style: AppTextStyle.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const _ActivitiesSliver(),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ───────────────────────────── Check-in card ─────────────────────────────

/// 1) كود العضو → بحث.
///    • مش مسجل (404) → شاشة تسجيل عضو جديد، ولو رجع بعد التسجيل بنبحث تاني.
///    • مسجل → بنعرض اشتراكاته في الأنشطة، وكل اشتراك ليه زرار "تسجيل حضور"
///      بيتفعّل بس لو فيه حصص متبقية والاشتراك لسه ما خلصش.
class _CheckinCard extends StatefulWidget {
  final VoidCallback onSubscribe;
  const _CheckinCard({required this.onSubscribe});

  @override
  State<_CheckinCard> createState() => _CheckinCardState();
}

class _CheckinCardState extends State<_CheckinCard> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _codeFocus = FocusNode();

  @override
  void dispose() {
    _codeController.dispose();
    _codeFocus.dispose();
    super.dispose();
  }

  void _lookup() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ActivitiesCubit>().lookupMember(_codeController.text.trim());
  }

  void _clear() {
    _codeController.clear();
    context.read<ActivitiesCubit>().clearLookup();
    _codeFocus.requestFocus();
  }

  Future<void> _onNotFound(BuildContext context, ActivitiesState state) async {
    final cubit = context.read<ActivitiesCubit>();
    final code = state.lookupCode ?? _codeController.text.trim();
    cubit.clearLookup();
    AppSnackBar.show(context, message: 'الكود غير مسجل، سجّل العضو الأول');

    // الـ router بيقرأ arguments كـ String? (زي شاشة الاستقبال)
    final done = await context.pushNamed(
      Routes.registerMember,
      arguments: code,
    );
    if (done == true && mounted) {
      cubit.lookupMember(code); // اتسجل: اعرض اشتراكاته
    }
  }

  void _onCheckinChanged(BuildContext context, ActivitiesState state) {
    final cubit = context.read<ActivitiesCubit>();
    if (state.checkinStatus == ActivitiesStatus.success) {
      AppSnackBar.show(
        context,
        message: state.checkinData?.message ?? 'تم تسجيل الحضور',
      );
      cubit.resetCheckin();
    } else if (state.checkinStatus == ActivitiesStatus.failure) {
      AppSnackBar.show(
        context,
        message: state.errorMessage ?? 'حصل خطأ',
        type: SnackType.error,
      );
      cubit.resetCheckin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // الكود مش متسجل → register
        BlocListener<ActivitiesCubit, ActivitiesState>(
          listenWhen: (p, c) => !p.memberNotFound && c.memberNotFound,
          listener: _onNotFound,
        ),
        // أي فشل تاني في البحث
        BlocListener<ActivitiesCubit, ActivitiesState>(
          listenWhen: (p, c) =>
              p.lookupStatus != c.lookupStatus &&
              c.lookupStatus == ActivitiesStatus.failure &&
              !c.memberNotFound,
          listener: (context, state) => AppSnackBar.show(
            context,
            message: state.errorMessage ?? 'حصل خطأ',
            type: SnackType.error,
          ),
        ),
        BlocListener<ActivitiesCubit, ActivitiesState>(
          listenWhen: (p, c) => p.checkinStatus != c.checkinStatus,
          listener: _onCheckinChanged,
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.strokeDefault),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تسجيل حضور في نشاط',
              style: AppTextStyle.titleMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            verticalSpace(12),
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _codeController,
                      focusNode: _codeFocus,
                      autofocus: true,
                      textDirection: TextDirection.ltr,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        labelText: 'كود العضو',
                        prefixIcon: const Icon(Icons.qr_code_scanner_rounded),
                        suffixIcon: IconButton(
                          tooltip: 'مسح',
                          icon: const Icon(Icons.close_rounded),
                          onPressed: _clear,
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'أدخل كود العضو'
                          : null,
                      onFieldSubmitted: (_) => _lookup(), // قارئ الباركود
                    ),
                  ),
                  horizontalSpace(10),
                  BlocSelector<ActivitiesCubit, ActivitiesState, bool>(
                    selector: (s) => s.lookupStatus == ActivitiesStatus.loading,
                    builder: (context, loading) => SizedBox(
                      height: 56,
                      child: FilledButton.icon(
                        onPressed: loading ? null : _lookup,
                        icon: loading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.search_rounded),
                        label: Text(loading ? 'جاري البحث...' : 'بحث'),
                      ),
                    ),
                  ),
                  horizontalSpace(10),
                  SizedBox(
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: widget.onSubscribe,
                      icon: const Icon(Icons.person_add_alt_1),
                      label: const Text('تسجيل مشترك'),
                    ),
                  ),
                ],
              ),
            ),
            const _MemberActivities(),
          ],
        ),
      ),
    );
  }
}

// ── اشتراكات العضو ──────────────────────────────────────────────────────────

class _MemberActivities extends StatelessWidget {
  const _MemberActivities();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      buildWhen: (p, c) =>
          p.lookupStatus != c.lookupStatus ||
          p.memberCard != c.memberCard ||
          p.memberActivities != c.memberActivities ||
          p.checkinStatus != c.checkinStatus ||
          p.checkinActivityId != c.checkinActivityId,
      builder: (context, state) {
        if (state.lookupStatus == ActivitiesStatus.loading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final member = state.memberCard;
        if (member == null) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: MemberDetailsCard(
            member: member,
            footer: _ActivitiesFooter(state: state),
          ),
        );
      },
    );
  }
}

/// اشتراكات العضو في الأنشطة + زرار الحضور لكل نشاط (جوه بطاقة العضو).
class _ActivitiesFooter extends StatelessWidget {
  final ActivitiesState state;
  const _ActivitiesFooter({required this.state});

  @override
  Widget build(BuildContext context) {
    final member = state.memberCard!;

    if (state.lookupStatus == ActivitiesStatus.failure) {
      return Text(
        'تعذر تحميل اشتراكات الأنشطة: ${state.errorMessage ?? ''}',
        style: AppTextStyle.bodyMd.copyWith(color: AppColors.statusExpired),
      );
    }

    // مش مشترك في أي نشاط → تسجيل مشترك
    if (state.memberActivities.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'العضو مسجل لكن ليس مشتركاً في أي نشاط.',
            style: AppTextStyle.bodyMd.copyWith(color: AppColors.textSecondary),
          ),
          verticalSpace(10),
          FilledButton.icon(
            onPressed: () => _openAddActivitiesDialog(context, member),
            icon: const Icon(Icons.person_add_alt_1),
            label: const Text('تسجيل مشترك'),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: [
            Text(
              'اشتراكات الأنشطة',
              style: AppTextStyle.labelLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => _openAddActivitiesDialog(context, member),
              icon: const Icon(Icons.add_rounded),
              label: const Text('إضافة نشاط جديد'),
            ),
          ],
        ),
        verticalSpace(10),
        for (final m in state.memberActivities)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _MemberActivityTile(
              item: m,
              busy:
                  state.checkinStatus == ActivitiesStatus.loading &&
                  state.checkinActivityId == m.activityId,
              anyBusy: state.checkinStatus == ActivitiesStatus.loading,
              onCheckin: () => context.read<ActivitiesCubit>().checkin(
                memberCode: state.lookupCode!,
                activityId: m.activityId,
              ),
              onRenew: () =>
                  _openRenewDialog(context, state.memberCard!, m.activityId),
            ),
          ),
      ],
    );
  }
}

/// لو الحصص كتير (أكتر من 24) بيتحول لشريط متصل بنسبة المتبقي.
class _SessionsBar extends StatelessWidget {
  final int total;
  final int remaining;
  final Color color;
  const _SessionsBar({
    required this.total,
    required this.remaining,
    required this.color,
  });

  static const _maxSegments = 24;

  @override
  Widget build(BuildContext context) {
    final left = remaining.clamp(0, total);

    if (total <= 0) return const SizedBox.shrink();

    if (total > _maxSegments) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: left / total,
          minHeight: 6,
          backgroundColor: AppColors.surfaceContainer,
          color: color,
        ),
      );
    }

    return Row(
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) const SizedBox(width: 4),
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                // أول خانات (من البداية) = المتبقي
                color: i < left ? color : AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _MemberActivityTile extends StatelessWidget {
  final MemberActivityLogedinModel item;
  final bool busy;
  final bool anyBusy;
  final VoidCallback onCheckin;
  final VoidCallback onRenew;

  const _MemberActivityTile({
    required this.item,
    required this.busy,
    required this.anyBusy,
    required this.onCheckin,
    required this.onRenew,
  });

  bool get _hasSessions => item.remainingSessions > 0;

  /// لسه ما خلصش: فيه أيام متبقية والحالة مش منتهية.
  bool get _notExpired =>
      item.remainingDays >= 0 && item.status.toLowerCase() != 'expired';

  bool get _canCheckin => _hasSessions && _notExpired;

  String? get _blockedReason {
    if (!_notExpired) return 'الاشتراك منتهي';
    if (!_hasSessions) return 'انتهت الحصص';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final okColor = _canCheckin ? AppColors.primary : AppColors.statusExpired;
    final reason = _blockedReason;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _canCheckin ? AppColors.strokeStrong : AppColors.strokeDefault,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.activityName,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                verticalSpace(4),
                Text(
                  'ينتهي ${DateFormat('yyyy-MM-dd').format(item.endDate)}'
                  ' • ${_notExpired ? 'متبقي ${item.remainingDays} يوم' : 'منتهي'}',
                  style: AppTextStyle.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                verticalSpace(8),
                Row(
                  children: [
                    Text(
                      'الحصص المتبقية: ${item.remainingSessions} من ${item.totalSessions}',
                      style: AppTextStyle.caption.copyWith(color: okColor),
                    ),
                  ],
                ),
                verticalSpace(6),
                _SessionsBar(
                  total: item.totalSessions,
                  remaining: item.remainingSessions,
                  color: okColor,
                ),
              ],
            ),
          ),
          horizontalSpace(14),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_canCheckin)
                FilledButton.icon(
                  onPressed: anyBusy ? null : onCheckin,
                  icon: busy
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.remove_circle_outline),
                  label: Text(
                    busy ? 'جاري التسجيل...' : 'تسجيل حضور (خصم حصة)',
                  ),
                )
              else ...[
                // الحصص خلصت أو الاشتراك انتهى → تجديد
                if (reason != null)
                  Text(
                    reason,
                    style: AppTextStyle.caption.copyWith(
                      color: AppColors.statusExpired,
                    ),
                  ),
                verticalSpace(6),
                FilledButton.icon(
                  onPressed: anyBusy ? null : onRenew,
                  icon: const Icon(Icons.autorenew_rounded),
                  label: const Text('تجديد الاشتراك'),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── Activities list ─────────────────────────────

class _ActivitiesSliver extends StatelessWidget {
  const _ActivitiesSliver();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ActivitiesCubit,
      ActivitiesState,
      List<ActivitiesModel>
    >(
      selector: (s) => s.activities,
      builder: (context, activities) {
        if (activities.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text('لا توجد أنشطة متاحة', style: AppTextStyle.bodyMd),
              ),
            ),
          );
        }
        // ListView كسول: بيبني الصفوف اللي على الشاشة بس.
        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverList.builder(
            itemCount: activities.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _ActivityTile(activity: activities[i]),
            ),
          ),
        );
      },
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final ActivitiesModel activity;
  const _ActivityTile({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.name,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                verticalSpace(2),
                Text(
                  '${activity.schedule} • ${activity.maxSessions} حصة • ${activity.durationDays} يوم',
                  style: AppTextStyle.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${activity.price.toStringAsFixed(0)} ج.م',
            style: AppTextStyle.titleMedium.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: AppTextStyle.bodyMd.copyWith(color: AppColors.error),
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

/// الأنشطة اللي العضو مشترك فيها حالياً واشتراكها لسه ساري
/// (فيه حصص متبقية ولسه ما انتهاش) → مينفعش تتجدد أو تتضاف تاني.
Set<int> _activeActivityIds(List<MemberActivityLogedinModel> list) => {
  for (final m in list)
    if (m.remainingSessions > 0 &&
        m.remainingDays >= 0 &&
        m.status.toLowerCase() != 'expired')
      m.activityId,
};

// ───────────────────────────── Add activities dialog ─────────────────────────────

/// تسجيل العضو (المعروض بالكود) في نشاط أو أكتر مرة واحدة.
Future<void> _openAddActivitiesDialog(
  BuildContext context,
  MemberShowCardModel member,
) async {
  final cubit = context.read<ActivitiesCubit>();
  final message = await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: _AddActivitiesDialog(
        memberId: member.id,
        memberName: member.name,
        // الأنشطة اللي مشترك فيها حالياً (سارية) مش بتتختار تاني
        activeIds: _activeActivityIds(cubit.state.memberActivities),
      ),
    ),
  );
  if (message != null && context.mounted) {
    AppSnackBar.show(context, message: message);
  }
}

class _AddActivitiesDialog extends StatefulWidget {
  final int memberId;
  final String memberName;
  final Set<int> activeIds;
  const _AddActivitiesDialog({
    required this.memberId,
    required this.memberName,
    required this.activeIds,
  });

  @override
  State<_AddActivitiesDialog> createState() => _AddActivitiesDialogState();
}

class _AddActivitiesDialogState extends State<_AddActivitiesDialog> {
  final Set<int> _ids = {};
  String? _localError;

  void _toggle(int id) => setState(() {
    _localError = null;
    _ids.contains(id) ? _ids.remove(id) : _ids.add(id);
  });

  void _submit() {
    final cubit = context.read<ActivitiesCubit>();
    if (cubit.state.subscribeStatus == ActivitiesStatus.loading) return;
    if (_ids.isEmpty) {
      setState(() => _localError = 'اختر نشاطاً واحداً على الأقل');
      return;
    }
    setState(() => _localError = null);
    cubit.subscribeMany(memberId: widget.memberId, activityIds: _ids.toList());
  }

  void _onSubscribeChanged(BuildContext context, ActivitiesState state) {
    final cubit = context.read<ActivitiesCubit>();
    if (state.subscribeStatus == ActivitiesStatus.success) {
      final message = state.subscribeMessage ?? 'تم الاشتراك بنجاح';
      cubit.resetSubscribe();
      Navigator.of(context).pop(message);
    } else if (state.subscribeStatus == ActivitiesStatus.failure) {
      setState(() => _localError = state.errorMessage ?? 'حصل خطأ');
      cubit.resetSubscribe();
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.9;

    return BlocListener<ActivitiesCubit, ActivitiesState>(
      listenWhen: (p, c) => p.subscribeStatus != c.subscribeStatus,
      listener: _onSubscribeChanged,
      child: BlocSelector<ActivitiesCubit, ActivitiesState, bool>(
        selector: (s) => s.subscribeStatus == ActivitiesStatus.loading,
        builder: (context, loading) {
          return Dialog(
            backgroundColor: AppColors.surfaceContainer,
            insetPadding: const EdgeInsets.all(24),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.strokeDefault),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 760, maxHeight: maxHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _DialogHeader(
                    title: 'تسجيل في الأنشطة',
                    subtitle:
                        'العضو: ${widget.memberName} — اختر نشاطاً أو أكتر',
                    onClose: loading ? null : () => Navigator.of(context).pop(),
                  ),
                  const Divider(height: 1, color: AppColors.strokeDefault),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _SectionTitle(
                            number: 1,
                            title: 'اختيار الأنشطة',
                            icon: Icons.fitness_center_rounded,
                          ),
                          verticalSpace(12),
                          BlocSelector<
                            ActivitiesCubit,
                            ActivitiesState,
                            List<ActivitiesModel>
                          >(
                            selector: (s) => s.activities,
                            builder: (context, activities) {
                              if (activities.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Text(
                                      'لا توجد أنشطة متاحة',
                                      style: AppTextStyle.bodyMd,
                                    ),
                                  ),
                                );
                              }
                              return _ActivityGrid(
                                activities: activities,
                                selectedIds: _ids,
                                disabledIds: widget.activeIds,
                                enabled: !loading,
                                onSelected: _toggle,
                              );
                            },
                          ),
                          verticalSpace(28),
                          const _SectionTitle(
                            number: 2,
                            title: 'ملخص الاشتراك',
                            icon: Icons.receipt_long_rounded,
                          ),
                          verticalSpace(12),
                          BlocSelector<
                            ActivitiesCubit,
                            ActivitiesState,
                            List<ActivitiesModel>
                          >(
                            selector: (s) => s.activities,
                            builder: (context, activities) => _MultiSummaryCard(
                              selected: [
                                for (final a in activities)
                                  if (_ids.contains(a.id)) a,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_localError != null) _ErrorBanner(message: _localError!),
                  const Divider(height: 1, color: AppColors.strokeDefault),
                  _DialogFooter(
                    loading: loading,
                    onSubmit: _submit,
                    onCancel: () => Navigator.of(context).pop(),
                    confirmLabel: _ids.isEmpty
                        ? 'تأكيد الاشتراك'
                        : 'تأكيد الاشتراك (${_ids.length})',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ملخص عدة أنشطة + الإجمالي.
class _MultiSummaryCard extends StatelessWidget {
  final List<ActivitiesModel> selected;
  const _MultiSummaryCard({required this.selected});

  @override
  Widget build(BuildContext context) {
    final total = selected.fold<double>(0, (sum, a) => sum + a.price);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: selected.isEmpty
          ? Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                horizontalSpace(10),
                Expanded(
                  child: Text(
                    'اختر نشاطاً أو أكتر لعرض ملخص الاشتراك',
                    style: AppTextStyle.bodyMd,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                for (final a in selected)
                  _SummaryRow(
                    label:
                        '${a.name} (${a.maxSessions} حصة • ${a.durationDays} يوم)',
                    value: '${a.price.toStringAsFixed(0)} ج.م',
                  ),
                verticalSpace(8),
                const Divider(height: 1, color: AppColors.strokeDefault),
                verticalSpace(12),
                Row(
                  children: [
                    Text('إجمالي المبلغ', style: AppTextStyle.headlineMd),
                    const Spacer(),
                    Text(
                      '${total.toStringAsFixed(0)} ج.م',
                      style: AppTextStyle.headlineXl.copyWith(
                        color: AppColors.neonLime,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

// ── Header ──────────────────────────────────────────────────────────────────

class _DialogHeader extends StatelessWidget {
  final VoidCallback? onClose;
  final String title;
  final String subtitle;
  const _DialogHeader({
    required this.onClose,
    this.title = 'تسجيل مشترك في نشاط',
    this.subtitle = 'أدخل رقم العضو واختر النشاط لإتمام الاشتراك',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.neonLimeBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.neonLime.withValues(alpha: 0.4),
              ),
            ),
            child: const Icon(
              Icons.person_add_alt_1_rounded,
              color: AppColors.neonLime,
            ),
          ),
          horizontalSpace(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.headlineLg),
                verticalSpace(2),
                Text(subtitle, style: AppTextStyle.bodyMd),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded),
            color: AppColors.textPrimary,
            style: IconButton.styleFrom(
              backgroundColor: AppColors.surface,
              fixedSize: const Size(44, 44),
              side: const BorderSide(color: AppColors.strokeDefault),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final int number;
  final String title;
  final IconData icon;
  const _SectionTitle({
    required this.number,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.neonLimeBg,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$number',
            style: AppTextStyle.labelMd.copyWith(
              color: AppColors.neonLime,
              fontSize: 14,
            ),
          ),
        ),
        horizontalSpace(10),
        Text(title, style: AppTextStyle.headlineMd),
        const Spacer(),
        Icon(icon, size: 20, color: AppColors.textSecondary),
      ],
    );
  }
}

// ── Activity cards ─────────────────────────────────────────────────────────

class _ActivityGrid extends StatelessWidget {
  final List<ActivitiesModel> activities;
  final Set<int> selectedIds;

  /// أنشطة مش قابلة للاختيار (العضو مشترك فيها حالياً).
  final Set<int> disabledIds;
  final bool enabled;
  final ValueChanged<int> onSelected;

  const _ActivityGrid({
    required this.activities,
    required this.selectedIds,
    required this.enabled,
    required this.onSelected,
    this.disabledIds = const {},
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        const spacing = 12.0;
        final cols = c.maxWidth >= 600 ? 3 : (c.maxWidth >= 380 ? 2 : 1);
        final w = (c.maxWidth - spacing * (cols - 1)) / cols;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final a in activities)
              SizedBox(
                width: w,
                child: _ActivityChoiceCard(
                  activity: a,
                  selected: selectedIds.contains(a.id),
                  disabled: disabledIds.contains(a.id),
                  onTap: (enabled && !disabledIds.contains(a.id))
                      ? () => onSelected(a.id)
                      : null,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ActivityChoiceCard extends StatelessWidget {
  final ActivitiesModel activity;
  final bool selected;
  final bool disabled;
  final VoidCallback? onTap;

  const _ActivityChoiceCard({
    required this.activity,
    required this.selected,
    required this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: selected ? AppColors.neonLimeBg : AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected ? AppColors.neonLime : AppColors.strokeDefault,
                width: selected ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        activity.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.headlineMd,
                      ),
                    ),
                    horizontalSpace(8),
                    Icon(
                      selected
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank_rounded,
                      size: 22,
                      color: selected
                          ? AppColors.neonLime
                          : AppColors.textSecondary,
                    ),
                  ],
                ),
                verticalSpace(6),
                Text(
                  activity.schedule,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.bodyMd.copyWith(fontSize: 13),
                ),
                verticalSpace(10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _InfoPill('${activity.maxSessions} حصة'),
                    _InfoPill('${activity.durationDays} يوم'),
                    if (disabled) const _InfoPill('مشترك حالياً'),
                  ],
                ),
                verticalSpace(14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      activity.price.toStringAsFixed(0),
                      style: AppTextStyle.headlineXl.copyWith(
                        color: AppColors.neonLime,
                      ),
                    ),
                    horizontalSpace(6),
                    Text('ج.م', style: AppTextStyle.bodyMd),
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

class _InfoPill extends StatelessWidget {
  final String text;
  const _InfoPill(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Text(
        text,
        style: AppTextStyle.labelMd.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}

// ── Summary ────────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  final ActivitiesModel? activity;
  const _SummaryCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    final a = activity;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: a == null
          ? Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                horizontalSpace(10),
                Expanded(
                  child: Text(
                    'اختر نشاطاً لعرض تفاصيل الاشتراك',
                    style: AppTextStyle.bodyMd,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                _SummaryRow(label: 'النشاط', value: a.name),
                _SummaryRow(label: 'المواعيد', value: a.schedule),
                _SummaryRow(label: 'عدد الحصص', value: '${a.maxSessions}'),
                _SummaryRow(
                  label: 'مدة الاشتراك',
                  value: '${a.durationDays} يوم',
                ),
                verticalSpace(8),
                const Divider(height: 1, color: AppColors.strokeDefault),
                verticalSpace(12),
                Row(
                  children: [
                    Text('إجمالي المبلغ', style: AppTextStyle.headlineMd),
                    const Spacer(),
                    Text(
                      '${a.price.toStringAsFixed(0)} ج.م',
                      style: AppTextStyle.headlineXl.copyWith(
                        color: AppColors.neonLime,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(label, style: AppTextStyle.bodyMd),
          horizontalSpace(16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyle.bodyMd.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Error + Footer ─────────────────────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.statusExpiredBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.statusExpiredBorder),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 20,
            color: AppColors.errorLight,
          ),
          horizontalSpace(8),
          Expanded(
            child: Text(
              message,
              style: AppTextStyle.bodyMd.copyWith(color: AppColors.errorLight),
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogFooter extends StatelessWidget {
  final bool loading;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final String confirmLabel;
  final String loadingLabel;

  const _DialogFooter({
    required this.loading,
    required this.onSubmit,
    required this.onCancel,
    this.confirmLabel = 'تأكيد الاشتراك',
    this.loadingLabel = 'جاري الاشتراك...',
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
    );
    const size = Size.fromHeight(AppSpacing.buttonHeightLarge);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: FilledButton.icon(
              onPressed: loading ? null : onSubmit,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.neonLime,
                foregroundColor: AppColors.onNeonLime,
                disabledBackgroundColor: AppColors.neonLimeDim.withValues(
                  alpha: 0.5,
                ),
                minimumSize: size,
                shape: shape,
              ),
              icon: loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.onNeonLime,
                      ),
                    )
                  : const Icon(Icons.check_rounded),
              label: Text(
                loading ? loadingLabel : confirmLabel,
                style: AppTextStyle.labelLg.copyWith(fontSize: 16),
              ),
            ),
          ),
          horizontalSpace(12),
          Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: loading ? null : onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.strokeStrong),
                minimumSize: size,
                shape: shape,
              ),
              child: Text('إلغاء', style: AppTextStyle.buttonSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────── Renew dialog ─────────────────────────────

/// بيفتح dialog فيه كل الأنشطة، المستخدم بيختار واحد ويجدد بيه.
/// [preselectedId] = النشاط اللي خلص (بيتحدد مبدئياً).
Future<void> _openRenewDialog(
  BuildContext context,
  MemberShowCardModel member,
  int? preselectedId,
) async {
  final cubit = context.read<ActivitiesCubit>();
  final message = await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: _RenewDialog(
        memberId: member.id,
        memberName: member.name,
        initialActivityId: preselectedId,
        activeIds: _activeActivityIds(cubit.state.memberActivities),
      ),
    ),
  );
  if (message != null && context.mounted) {
    AppSnackBar.show(context, message: message);
  }
}

class _RenewDialog extends StatefulWidget {
  final int memberId;
  final String memberName;
  final int? initialActivityId;
  final Set<int> activeIds;
  const _RenewDialog({
    required this.memberId,
    required this.memberName,
    required this.activeIds,
    this.initialActivityId,
  });

  @override
  State<_RenewDialog> createState() => _RenewDialogState();
}

class _RenewDialogState extends State<_RenewDialog> {
  int? _activityId;
  String? _localError;

  @override
  void initState() {
    super.initState();
    final id = widget.initialActivityId;
    _activityId = (id != null && !widget.activeIds.contains(id)) ? id : null;
  }

  void _submit() {
    final cubit = context.read<ActivitiesCubit>();
    if (cubit.state.subscribeStatus == ActivitiesStatus.loading) return;
    if (_activityId == null) {
      setState(() => _localError = 'اختر نشاطاً للتجديد');
      return;
    }
    if (widget.activeIds.contains(_activityId)) {
      setState(() => _localError = 'هذا النشاط اشتراكه ساري ولا يحتاج تجديد');
      return;
    }
    setState(() => _localError = null);
    cubit.subscribe(memberId: widget.memberId, activityId: _activityId!);
  }

  void _onSubscribeChanged(BuildContext context, ActivitiesState state) {
    final cubit = context.read<ActivitiesCubit>();
    if (state.subscribeStatus == ActivitiesStatus.success) {
      final sub = state.subscriptionData;
      final message = sub == null
          ? 'تم تجديد الاشتراك بنجاح'
          : 'تم تجديد اشتراك ${sub.memberName} في ${sub.activityName}';
      cubit.resetSubscribe();
      Navigator.of(context).pop(message);
    } else if (state.subscribeStatus == ActivitiesStatus.failure) {
      setState(() => _localError = state.errorMessage ?? 'حصل خطأ');
      cubit.resetSubscribe();
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.9;

    return BlocListener<ActivitiesCubit, ActivitiesState>(
      listenWhen: (p, c) => p.subscribeStatus != c.subscribeStatus,
      listener: _onSubscribeChanged,
      child: BlocSelector<ActivitiesCubit, ActivitiesState, bool>(
        selector: (s) => s.subscribeStatus == ActivitiesStatus.loading,
        builder: (context, loading) {
          return Dialog(
            backgroundColor: AppColors.surfaceContainer,
            insetPadding: const EdgeInsets.all(24),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.strokeDefault),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 760, maxHeight: maxHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _DialogHeader(
                    title: 'تجديد الاشتراك',
                    subtitle: 'العضو: ${widget.memberName}',
                    onClose: loading ? null : () => Navigator.of(context).pop(),
                  ),
                  const Divider(height: 1, color: AppColors.strokeDefault),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _SectionTitle(
                            number: 1,
                            title: 'اختر النشاط',
                            icon: Icons.fitness_center_rounded,
                          ),
                          verticalSpace(12),
                          BlocSelector<
                            ActivitiesCubit,
                            ActivitiesState,
                            List<ActivitiesModel>
                          >(
                            selector: (s) => s.activities,
                            builder: (context, activities) {
                              if (activities.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Text(
                                      'لا توجد أنشطة متاحة',
                                      style: AppTextStyle.bodyMd,
                                    ),
                                  ),
                                );
                              }
                              return _ActivityGrid(
                                activities: activities,
                                selectedIds: {
                                  if (_activityId != null) _activityId!,
                                },
                                disabledIds: widget.activeIds,
                                enabled: !loading,
                                onSelected: (id) =>
                                    setState(() => _activityId = id),
                              );
                            },
                          ),
                          verticalSpace(28),
                          const _SectionTitle(
                            number: 2,
                            title: 'ملخص التجديد',
                            icon: Icons.receipt_long_rounded,
                          ),
                          verticalSpace(12),
                          BlocSelector<
                            ActivitiesCubit,
                            ActivitiesState,
                            List<ActivitiesModel>
                          >(
                            selector: (s) => s.activities,
                            builder: (context, activities) {
                              ActivitiesModel? selected;
                              for (final a in activities) {
                                if (a.id == _activityId) selected = a;
                              }
                              return _SummaryCard(activity: selected);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_localError != null) _ErrorBanner(message: _localError!),
                  const Divider(height: 1, color: AppColors.strokeDefault),
                  _DialogFooter(
                    loading: loading,
                    onSubmit: _submit,
                    onCancel: () => Navigator.of(context).pop(),
                    confirmLabel: 'تأكيد التجديد',
                    loadingLabel: 'جاري التجديد...',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
