import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/maintenance_request_details_entity.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_info_row.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key, required this.vehicle});

  final  RequestVehicleEntity vehicle;

  @override
  Widget build(BuildContext context) {
    return SosDetailsSectionCard(
      title: 'المركبة',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${vehicle.brand ?? ''} ${vehicle.model ?? ''} ${vehicle.year ?? ''}'
                      .trim(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                SosDetailsInfoRow(
                  iconAsset: AppAssets.plateNumberIcon,
                  label: 'رقم اللوحة',
                  value: vehicle.plateNumber ?? '-',
                ),
                SosDetailsInfoRow(
                  iconAsset: AppAssets.technicianJobNotesIcon,
                  label: 'الكيلومترات',
                  value: vehicle.currentKm != null
                      ? '${vehicle.currentKm} كم'
                      : '-',
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          CircleAvatar(
            radius: 40.r,
            backgroundColor: AppColors.lightSurface,
            backgroundImage:
                const AssetImage(AppAssets.technicianJobVehicleIcon),
          ),
        ],
      ),
    );
  }
}