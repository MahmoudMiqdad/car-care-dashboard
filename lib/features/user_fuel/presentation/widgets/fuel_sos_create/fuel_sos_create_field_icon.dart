import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FuelSosCreateFieldIcon extends StatelessWidget {
  const FuelSosCreateFieldIcon({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: 28.w,
      height: 28.w,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => SizedBox(width: 28.w, height: 28.w),
    );
  }
}
