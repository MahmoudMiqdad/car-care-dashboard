import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/car_washer/washers/washers_profile/presentation/widgets/edit_profile_page/edit_profile_washer_labeled_field.dart';
import 'package:car_care/features/car_washer/washers/washers_profile/presentation/widgets/edit_profile_page/edit_profile_washer_services_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateProfileWasherServicesSection extends StatelessWidget {
  const CreateProfileWasherServicesSection({
    super.key,
    required this.servicesLabel,
    required this.servicesHint,
    required this.sectionTitle,
    required this.descriptionLabel,
    required this.descriptionHint,
    required this.basicTitle,
    required this.vipTitle,
    required this.premiumTitle,
    required this.priceLabel,
    required this.priceHint,
    this.servicesController,
    this.descriptionController,
    this.basicPriceController,
    this.vipPriceController,
    this.premiumPriceController,
  });

  final String servicesLabel;
  final String servicesHint;
  final String sectionTitle;
  final String descriptionLabel;
  final String descriptionHint;
  final String basicTitle;
  final String vipTitle;
  final String premiumTitle;
  final String priceLabel;
  final String priceHint;
  final TextEditingController? servicesController;
  final TextEditingController? descriptionController;
  final TextEditingController? basicPriceController;
  final TextEditingController? vipPriceController;
  final TextEditingController? premiumPriceController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EditProfileWasherLabeledField(
          label: servicesLabel,
          hint: servicesHint,
          controller: servicesController,
          leadingIcon: Icon(
            Icons.local_car_wash_outlined,
            color: AppColors.carWashTeal,
            size: 22.sp,
          ),
        ),
        SizedBox(height: 8.h),
        EditProfileWasherServicesSection(
          sectionTitle: sectionTitle,
          descriptionLabel: descriptionLabel,
          descriptionHint: descriptionHint,
          basicTitle: basicTitle,
          vipTitle: vipTitle,
          premiumTitle: premiumTitle,
          priceLabel: priceLabel,
          priceHint: priceHint,
          descriptionController: descriptionController,
          basicPriceController: basicPriceController,
          vipPriceController: vipPriceController,
          premiumPriceController: premiumPriceController,
        ),
      ],
    );
  }
}
