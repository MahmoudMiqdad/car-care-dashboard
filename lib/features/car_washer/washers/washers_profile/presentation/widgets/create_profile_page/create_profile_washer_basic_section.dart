import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/car_washer/washers/washers_profile/presentation/widgets/edit_profile_page/edit_profile_washer_labeled_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateProfileWasherBasicSection extends StatelessWidget {
  const CreateProfileWasherBasicSection({
    super.key,
    required this.shopNameLabel,
    required this.shopNameHint,
    required this.phoneLabel,
    required this.phoneHint,
    required this.cityLabel,
    required this.cityHint,
    required this.addressLabel,
    required this.addressHint,
    this.shopController,
    this.phoneController,
    this.cityController,
    this.addressController,
  });

  final String shopNameLabel;
  final String shopNameHint;
  final String phoneLabel;
  final String phoneHint;
  final String cityLabel;
  final String cityHint;
  final String addressLabel;
  final String addressHint;
  final TextEditingController? shopController;
  final TextEditingController? phoneController;
  final TextEditingController? cityController;
  final TextEditingController? addressController;

  @override
  Widget build(BuildContext context) {
    final nameIcon = Icon(
      Icons.storefront_outlined,
      color: AppColors.carWashTeal,
      size: 24.sp,
    );
    final phoneIcon = Icon(
      Icons.phone_outlined,
      color: AppColors.carWashTeal,
      size: 22.sp,
    );
    final locationIcon = Icon(
      Icons.location_on_outlined,
      color: AppColors.carWashTeal,
      size: 22.sp,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EditProfileWasherLabeledField(
          label: shopNameLabel,
          hint: shopNameHint,
          controller: shopController,
          leadingIcon: nameIcon,
        ),
        SizedBox(height: 8.h),
        EditProfileWasherLabeledField(
          label: phoneLabel,
          hint: phoneHint,
          controller: phoneController,
          keyboardType: TextInputType.phone,
          leadingIcon: phoneIcon,
        ),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: EditProfileWasherLabeledField(
                label: cityLabel,
                hint: cityHint,
                controller: cityController,
                leadingIcon: locationIcon,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: EditProfileWasherLabeledField(
                label: addressLabel,
                hint: addressHint,
                controller: addressController,
                leadingIcon: locationIcon,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
