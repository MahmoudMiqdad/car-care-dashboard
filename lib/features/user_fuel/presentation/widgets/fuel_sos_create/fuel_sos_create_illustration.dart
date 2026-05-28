import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FuelSosCreateIllustration extends StatelessWidget {
  const FuelSosCreateIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
          AppAssets.sosWarningRafiki,
          height: 180.h,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => Icon(
            Icons.local_gas_station_outlined,
            size: 120.sp,
            color: AppColors.primary,
          ),
        ),
      
    );
  }
}
