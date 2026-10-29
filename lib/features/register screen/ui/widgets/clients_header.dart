import 'package:flutter/material.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/routing/routes.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';

class ClientsHeader extends StatelessWidget {
  const ClientsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'قائمة المشتركين',
          style: AppTextStyle.displaySmall.scaled(context),
        ),
        verticalSpace(4),
        Text(
          'إدارة وتحديث بيانات العضويات، التحقق السريع، تجديد الاشتراكات، ومراقبة حالة الوصول الفوري.',
          style: AppTextStyle.bodyMedium,
        ),
      ],
    );

    // final actions = Wrap(
    //   spacing: 12,
    //   runSpacing: 12,
    //   crossAxisAlignment: WrapCrossAlignment.center,
    //   children: [
    //     _SecondaryButton(
    //       label: 'طباعة الباركود السريع',
    //       icon: Icons.qr_code_scanner_rounded,
    //     ),
    //     _PrimaryButton(
    //       onTap: () {
    //         Navigator.of(context).pushNamed(Routes.registerMember);
    //       },
    //       label: 'تسجيل مشترك جديد',
    //       icon: Icons.person_add_alt_1_rounded,
    //     ),
    //   ],
    // );

    if (context.isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // First child = right side in RTL
          Expanded(child: titleBlock),
          horizontalSpace(16),
          // actions,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleBlock, verticalSpace(16), // actions
      ],
    );
  }
}
