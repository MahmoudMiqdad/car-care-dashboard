// حقل ملاحظة العنوان (إلزامي) في شاشة Checkout — مع AnimatedContainer لتأثير Focus
//إلزامي بناء عالباك
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutAddressNoteField extends StatefulWidget {
  const CheckoutAddressNoteField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  State<CheckoutAddressNoteField> createState() =>
      _CheckoutAddressNoteFieldState();
}

class _CheckoutAddressNoteFieldState extends State<CheckoutAddressNoteField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() {
        if (mounted) setState(() => _isFocused = _focusNode.hasFocus);
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.edit_note_outlined, color: AppColors.primary, size: 18.sp),
            SizedBox(width: 6.w),
            Text(
              'ملاحظة العنوان',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              '*',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.18),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            onChanged: (_) => widget.onChanged(),
            maxLines: 3,
            minLines: 2,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'مثال: بصرى الشام - الحي الغربي - قرب الصيدلية',
              hintStyle: AppTypography.labelSmall.copyWith(
                color: AppColors.lightTextSecondary,
              ),
              filled: true,
              fillColor: AppColors.secondary,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.35),
                  width: 1.5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
            ),
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.lightTextPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
