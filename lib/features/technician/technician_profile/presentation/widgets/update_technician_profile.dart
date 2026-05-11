import 'dart:io';

import 'package:car_care/core/constants/app_constants.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/buttons/app_button_widget.dart';
import 'package:car_care/features/auth/presentation/widgets/login/login_text_field.dart';
import 'package:car_care/features/technician/technician_profile/domain/entities/technician_profile_entity.dart';
import 'package:car_care/features/technician/technician_profile/presentation/cubit/technician_profile_cubit.dart';
import 'package:car_care/features/technician/technician_profile/presentation/cubit/technician_profile_state.dart';
import 'package:car_care/features/technician/technician_profile/presentation/widgets/technician_location_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';

class TechnicianProfileEditBodyContent extends StatefulWidget {
  final TechnicianDataEntity? initialData;

  const TechnicianProfileEditBodyContent({
    super.key,
    this.initialData,
  });

  @override
  State<TechnicianProfileEditBodyContent> createState() =>
      _TechnicianProfileEditBodyContentState();
}

class _TechnicianProfileEditBodyContentState
    extends State<TechnicianProfileEditBodyContent> {
  late final TextEditingController _specializationController;
  late final TextEditingController _experienceController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;
  late final TextEditingController _hourlyRateController;

  final List<XFile> _certificationImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // ← تملى الحقول بالبيانات الموجودة تلقائياً
    final d = widget.initialData;
    _specializationController =
        TextEditingController(text: d?.specialization ?? '');
    _experienceController =
        TextEditingController(text: d?.experienceYears?.toString() ?? '');
    _phoneController = TextEditingController(text: d?.phone ?? '');
    _cityController = TextEditingController(text: d?.city ?? '');
    _hourlyRateController =
        TextEditingController(text: d?.hourlyRate?.toString() ?? '');
  }

  @override
  void dispose() {
    _specializationController.dispose();
    _experienceController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _hourlyRateController.dispose();
    super.dispose();
  }

  Future<void> _pickCertificationImages() async {
    final List<XFile> images = await _picker.pickMultiImage(imageQuality: 80);
    if (images.isEmpty) return;

    if (images.length + _certificationImages.length > 3) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يمكنك اختيار 3 صور كحد أقصى'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _certificationImages.addAll(images));
  }

  void _submit() {
    final params = <String, dynamic>{
      "specialization": _specializationController.text.trim(),
      "experience_years": _experienceController.text.trim(),
      "phone": _phoneController.text.trim(),
      "city": _cityController.text.trim(),
      "hourly_rate": _hourlyRateController.text.trim(),
    };

    for (int i = 0; i < _certificationImages.length; i++) {
      params["certifications[$i]"] = File(_certificationImages[i].path).path;
    }

    context.read<TechnicianProfileCubit>().updateTechnicianProfile(params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechnicianProfileCubit, TechnicianProfileState>(
      listener: (context, state) {
        if (state is TechnicianProfileLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تحديث الملف الشخصي بنجاح ✓'),
              backgroundColor: Colors.green,
            ),
          );
        }
        if (state is TechnicianProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is TechnicianProfileLoading;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10.h),

                // ─── حقول البيانات ───────────────────────────────────────
                LoginTextField(
                  controller: _specializationController,
                  hintText: 'التخصص',
                  iconPath: 'assets/images/icons8-work-50.png',
                ),
                SizedBox(height: 12.h),

                LoginTextField(
                  controller: _experienceController,
                  hintText: 'سنوات الخبرة',
                  iconPath: 'assets/images/icons8-certificate-72.png',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12.h),

                LoginTextField(
                  controller: _phoneController,
                  hintText: 'رقم الهاتف',
                  icon: IconsaxPlusLinear.call,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 12.h),

                LoginTextField(
                  controller: _cityController,
                  hintText: 'المدينة',
                  iconPath: 'assets/images/icons8-location-50.png',
                ),
                SizedBox(height: 12.h),

                LoginTextField(
                  controller: _hourlyRateController,
                  hintText: 'الأجر بالساعة',
                  iconPath: 'assets/images/icons8-money-64.png',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                SizedBox(height: 16.h),

                // ─── كارد الموقع ──────────────────────────────────────────
                const LocationUpdateCard(),
                SizedBox(height: 20.h),

                // ─── الشهادات ─────────────────────────────────────────────
                Text(
                  'الشهادات (حد أقصى 3 صور)',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ..._certificationImages.map((image) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.file(
                              File(image.path),
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => setState(
                                () => _certificationImages.remove(image),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16.r,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),

                    if (_certificationImages.length < 3)
                      GestureDetector(
                        onTap: _pickCertificationImages,
                        child: Container(
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Colors.grey.shade500,
                                size: 24.r,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'إضافة',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 24.h),

                // ─── زر الحفظ ─────────────────────────────────────────────
                SizedBox(
                  height: AppConstants.buttonHeight.h,
                  child: AppButton(
                    text: isLoading ? 'جارٍ الحفظ...' : 'حفظ التعديلات',
                    backgroundColor: AppColors.orange,
                    borderRadius: 20.r,
                    onPressed: isLoading ? null : _submit,
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
