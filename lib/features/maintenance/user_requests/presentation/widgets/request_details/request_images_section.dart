import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/maintenance_request_details_entity.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_details/sos_details_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestImagesSection extends StatelessWidget {
  const RequestImagesSection({super.key, required this.images});

  final List<RequestImageEntity> images;

  @override
  Widget build(BuildContext context) {
    return SosDetailsSectionCard(
      title: 'صور الطلب',
      child: SizedBox(
        height: 100.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          separatorBuilder: (_, __) => SizedBox(width: 8.w),
          itemBuilder: (_, i) => ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              images[i].url,
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100.w,
                color: AppColors.lightSurface,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.carWashTeal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}