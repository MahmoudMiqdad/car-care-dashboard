import 'dart:io';

import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/buttons/app_button_widget.dart';
import 'package:car_care/features/car_washer/profile_washer/presentation/cubit/profile_washer_cubit.dart';
import 'package:car_care/features/car_washer/profile_washer/presentation/cubit/profile_washer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileWasherPage extends StatefulWidget {
  const CreateProfileWasherPage({super.key});

  @override
  State<CreateProfileWasherPage> createState() =>
      _CreateProfileWasherPageState();
}

class _CreateProfileWasherPageState extends State<CreateProfileWasherPage> {
  final _shop = TextEditingController();
  final _phone = TextEditingController();
  final _city = TextEditingController();
  final _address = TextEditingController();
  final _desc = TextEditingController();
  final _basic = TextEditingController();
  final _vip = TextEditingController();
  final _premium = TextEditingController();
  final _services =
      TextEditingController(text: 'غسيل عادي, غسيل ممتاز, تلميع');
  final _sat = TextEditingController(text: '11:00-15:00');
  final _sun = TextEditingController(text: '10:00-16:00');

  String? _logoPath;

  bool _waitingForSave = false;

  @override
  void dispose() {
    _shop.dispose();
    _phone.dispose();
    _city.dispose();
    _address.dispose();
    _desc.dispose();
    _basic.dispose();
    _vip.dispose();
    _premium.dispose();
    _services.dispose();
    _sat.dispose();
    _sun.dispose();
    super.dispose();
  }

  // ── Helpers ──

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  List<String> _parseServices() => _services.text
      .split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList(growable: false);

  Map<String, int> _parsePrices() {
    int p(TextEditingController c) => int.tryParse(c.text.trim()) ?? 0;
    return {'basic': p(_basic), 'vip': p(_vip), 'premium': p(_premium)};
  }

  Map<String, String> _parseHours() => {
        'sat': _sat.text.trim(),
        'sun': _sun.text.trim(),
      };


  Future<void> _pickLogo() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null || !mounted) return;
    setState(() => _logoPath = file.path);
  }

  /// حفظ الـ profile
  void _save() {
    if (_shop.text.trim().isEmpty) {
      _snack('يرجى إدخال اسم المغسلة');
      return;
    }
    if (_phone.text.trim().isEmpty) {
      _snack('يرجى إدخال رقم الهاتف');
      return;
    }
    if (_city.text.trim().isEmpty) {
      _snack('يرجى إدخال المدينة');
      return;
    }

    _waitingForSave = true;

    context.read<ProfileWasherCubit>().saveProfile(
          shopName: _shop.text.trim(),
          phone: _phone.text.trim(),
          city: _city.text.trim(),
          address: _address.text.trim(),
          description: _desc.text.trim(),
          services: _parseServices(),
          servicePrices: _parsePrices(),
          workingHours: _parseHours(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileWasherCubit, ProfileWasherState>(
      listener: (context, state) {
        if (state is ProfileWasherLoaded && _waitingForSave) {
          _waitingForSave = false;

          if (_logoPath != null) {
            context.read<ProfileWasherCubit>().uploadLogo(_logoPath!);
          }
         
        }

        if (state is ProfileWasherError) {
          _waitingForSave = false;
        }
      },
      child: _buildForm(),
    );
  }

  Widget _buildForm() {
    final state = context.watch<ProfileWasherCubit>().state;
    final loading =
        state is ProfileWasherSaving || state is ProfileWasherLoading;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
    
            Text(
              'إنشاء بروفايل المغسلة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 16.h),

            // ── الحقول ──
            _Field(
              controller: _shop,
              hint: 'اسم المغسلة *',
              enabled: !loading,
            ),
            SizedBox(height: 10.h),
            _Field(
              controller: _phone,
              hint: 'رقم الهاتف *',
              enabled: !loading,
              keyboard: TextInputType.phone,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: _Field(
                    controller: _city,
                    hint: 'المدينة *',
                    enabled: !loading,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _Field(
                    controller: _address,
                    hint: 'العنوان',
                    enabled: !loading,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _Field(
              controller: _desc,
              hint: 'وصف المغسلة',
              enabled: !loading,
              maxLines: 2,
            ),
            SizedBox(height: 10.h),
            _Field(
              controller: _services,
              hint: 'الخدمات (افصل بفاصلة ,)',
              enabled: !loading,
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Expanded(
                  child: _Field(
                    controller: _basic,
                    hint: 'Basic \$',
                    enabled: !loading,
                    keyboard: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _Field(
                    controller: _vip,
                    hint: 'VIP \$',
                    enabled: !loading,
                    keyboard: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _Field(
                    controller: _premium,
                    hint: 'Premium \$',
                    enabled: !loading,
                    keyboard: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Expanded(
                  child: _Field(
                    controller: _sat,
                    hint: 'السبت 11:00-15:00',
                    enabled: !loading,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _Field(
                    controller: _sun,
                    hint: 'الأحد 10:00-16:00',
                    enabled: !loading,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            GestureDetector(
              onTap: loading ? null : _pickLogo,
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: _logoPath != null
                        ? AppColors.carWashTeal
                        : Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
                child: _logoPath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(11.r),
                        child: Image.file(
                          File(_logoPath!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 36.sp,
                            color: AppColors.carWashTeal,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'رفع الشعار ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            SizedBox(height: 16.h),

            // ── زرين: حفظ + إلغاء ──
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: loading ? () {} : _save,
                    text: loading ? '...' : 'حفظ البروفايل',
                    backgroundColor: AppColors.orange,
                    height: 54.h,
                    borderRadius: 18.r,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppButton(
                    onPressed: loading
                        ? () {}
                        : () {
                            if (context.canPop()) {
                              context.pop();
                            }
                          },
                    text: 'إلغاء',
                    isOutline: true,
                    backgroundColor: AppColors.carWashTeal,
                    outlineSurfaceColor: AppColors.white,
                    textColor: AppColors.carWashTeal,
                    height: 54.h,
                    borderRadius: 18.r,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── حقل إدخال موحد ──
class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.hint,
    this.enabled = true,
    this.keyboard,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final bool enabled;
  final TextInputType? keyboard;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboard,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              const BorderSide(color: AppColors.carWashTeal, width: 1.5),
        ),
      ),
    );
  }
}