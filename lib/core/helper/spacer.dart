import 'package:flutter/material.dart';
import 'package:gymsystem/core/helper/responsive.dart';

class _ResponsiveGap extends StatelessWidget {
  final double? width;
  final double? height;
  const _ResponsiveGap({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    final s = Responsive.scale(context);
    return SizedBox(
      width: width == null ? null : width! * s,
      height: height == null ? null : height! * s,
    );
  }
}

Widget verticalSpace(double height) => _ResponsiveGap(height: height);
Widget horizontalSpace(double width) => _ResponsiveGap(width: width);
