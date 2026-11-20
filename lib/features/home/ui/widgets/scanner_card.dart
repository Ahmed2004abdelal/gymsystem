import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/features/home/logic/reception_cubit.dart';
import 'package:gymsystem/features/home/logic/reception_state.dart';

class ScannerCard extends StatelessWidget {
  const ScannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = Responsive.value(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.strokeDefault),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const _TopRow(),
          // verticalSpace(16),
          _ScanField(pad: pad),
          // verticalSpace(16),
          // const _BottomRow(),
        ],
      ),
    );
  }
}

// ───────────────────────────── Top row ─────────────────────────────

// class _TopRow extends StatelessWidget {
//   const _TopRow();

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       alignment: WrapAlignment.spaceBetween,
//       crossAxisAlignment: WrapCrossAlignment.center,
//       spacing: 12,
//       runSpacing: 8,
//       children: [
// Start side (right in RTL): title + barcode icon
// Row(
//   mainAxisSize: MainAxisSize.min,
//   children: [
//     const Icon(
//       Icons.document_scanner_outlined,
//       size: 22,
//       color: AppColors.primary,
//     ),
// horizontalSpace(8),
// Text(
//   'محطة الفحص الآلي للبوابة',
//   style: AppTextStyle.labelLarge.copyWith(color: AppColors.primary),
// ),
// ],
// ),
// End side (left in RTL): ready chip
// Container(
//   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//   decoration: BoxDecoration(
//     color: AppColors.surfaceContainerLow,
//     borderRadius: BorderRadius.circular(999),
//     border: Border.all(color: AppColors.strokeDefault),
//   ),
//   child: Text(
//     'جاهز للمسح الضوئي الفوري',
//     style: AppTextStyle.labelMedium.copyWith(
//       color: AppColors.textPrimary,
//     ),
//   ),
// ),
//       ],
//     );
//   }
// }

// ───────────────────────────── Scan field ─────────────────────────────

class _ScanField extends StatefulWidget {
  final double pad;
  _ScanField({required this.pad});

  @override
  State<_ScanField> createState() => _ScanFieldState();
}

class _ScanFieldState extends State<_ScanField> {
  final _ctrl = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _submit() {
    final code = _ctrl.text.trim();
    if (code.isEmpty) return;
    context.read<ReceptionCubit>().memberCheckin(code);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceptionCubit, ReceptionState>(
      listenWhen: (p, c) =>
          p.memberCheckinStatus != c.memberCheckinStatus &&
          c.memberCheckinStatus == ReceptionStatus.success,
      listener: (_, state) {
        _ctrl.clear();
        _focus.requestFocus();
      },
      buildWhen: (p, c) => p.memberCheckinStatus != c.memberCheckinStatus,
      builder: (context, state) {
        final isLoading = state.memberCheckinStatus == ReceptionStatus.loading;

        return Container(
          constraints: const BoxConstraints(minHeight: 72),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.strokeStrong),
            boxShadow: const [
              BoxShadow(
                color: AppColors.glowActive,
                blurRadius: 24,
                spreadRadius: -6,
              ),
            ],
          ),
          child: Row(
            children: [
              // Start (right in RTL): big QR icon
              Icon(
                Icons.qr_code_scanner_rounded,
                // size: context.isDesktop ? context.scale(36) : context.scale(28),
                size: context.isDesktop ? context.rs(36) : context.rs(28),
                color: AppColors.primary,
              ),
              horizontalSpace(14),
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  focusNode: _focus,
                  autofocus: true,
                  enabled: !isLoading,
                  maxLines: 1,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _submit(),
                  style: AppTextStyle.inputText.copyWith(
                    fontSize: context.rs(18),
                  ),
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration.collapsed(
                    hintText: 'امسح بطاقة العضو عبر الباركود أو أدخل كود العضو',
                    hintStyle: AppTextStyle.inputHint.copyWith(
                      fontSize: context.isDesktop
                          ? context.rs(18)
                          : context.rs(14),
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              horizontalSpace(14),
              _ScanButton(
                isLoading: isLoading,
                onTap: _submit,
                pad: widget.pad,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScanButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;
  final double pad;

  const _ScanButton({
    required this.isLoading,
    required this.onTap,
    required this.pad,
  });

  @override
  Widget build(BuildContext context) {
    // final pad = Responsive.value(
    //   context,
    //   mobile: 16.0,
    //   tablet: 24.0,
    //   desktop: 32.0,
    // );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: AppColors.glowActive,
            blurRadius: 18,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Material(
        color: AppColors.primary.withValues(alpha: isLoading ? 0.85 : 1),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: isLoading ? null : onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: pad,
              vertical: pad * 0.625,
            ),
            child: isLoading
                ? SpinKitThreeBounce(
                    color: AppColors.textOnPrimary,
                    size: context.rs(20),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('فحص', style: AppTextStyle.buttonLarge),
                      horizontalSpace(context.rs(8)),
                      Icon(
                        Icons.arrow_back,
                        size: context.rs(20),
                        color: AppColors.textOnPrimary,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────── Bottom row ─────────────────────────────

// class _BottomRow extends StatelessWidget {
//   const _BottomRow();

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       alignment: WrapAlignment.spaceBetween,
//       crossAxisAlignment: WrapCrossAlignment.center,
//       spacing: 20,
//       runSpacing: 8,
//       children: [
//         // Start (right in RTL): status indicators
//         // const Wrap(
//         //   spacing: 20,
//         //   runSpacing: 8,
//         //   crossAxisAlignment: WrapCrossAlignment.center,
//         //   children: [
//         //     _Indicator('قارئ الليزر متصل'),
//         //     _Indicator('البوابة الإلكترونية 01 نشطة'),
//         //   ],
//         // ),
//         // End (left in RTL): device id
//         // Text(
//         //   'DEVICE_ID: TRNSTL-NORTH-A',
//         //   textDirection: TextDirection.ltr,
//         //   style: AppTextStyle.caption.copyWith(
//         //     fontFamily: 'monospace',
//         //     color: AppColors.primaryLight,
//         //   ),
//         // ),
//       ],
//     );
//   }
// }

// // class _Indicator extends StatelessWidget {
// //   final String text;
// //   const _Indicator(this.text);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         Container(
// //           width: 7,
// //           height: 7,
// //           decoration: const BoxDecoration(
// //             color: AppColors.primary,
// //             shape: BoxShape.circle,
// //             boxShadow: [BoxShadow(color: AppColors.glowActive, blurRadius: 8)],
// //           ),
// //         ),
// //         horizontalSpace(8),
// //         Text(
// //           text,
// //           style: AppTextStyle.caption.copyWith(color: AppColors.textSecondary),
// //         ),
// //       ],
// //     );
// //   }
// // }
