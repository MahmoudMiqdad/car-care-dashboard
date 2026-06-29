// معرض صور المنتج بصورة رئيسية وصور مصغّرة، مع شارة الحالة فوق الصورة الرئيسية
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:car_care/features/spare_parts_store/customer/product_details/presentation/widgets/condition_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageGallery extends StatefulWidget {
  const ProductImageGallery({
    super.key,
    required this.imageCount,
    required this.isNew,
  });

  final int imageCount;
  final bool isNew;

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ConditionBadge(isNew: widget.isNew),
        ),
        SizedBox(height: 8.h),
        _ImagePlaceholder(
          width: double.infinity,
          height: 200.h,
          borderRadius: 16.r,
          iconSize: 72.sp,
          label: 'صورة المنتج',
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 68.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.imageCount,
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final isSelected = index == _selectedIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                child: _ImagePlaceholder(
                  width: 60.w,
                  height: 60.h,
                  borderRadius: 8.r,
                  iconSize: 22.sp,
                  borderColor: isSelected ? AppColors.primary : AppColors.lightBorder,
                  borderWidth: isSelected ? 2 : 1,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({
    this.width,
    required this.height,
    required this.borderRadius,
    required this.iconSize,
    this.label,
    this.borderColor,
    this.borderWidth = 1,
  });

  final double? width;
  final double height;
  final double borderRadius;
  final double iconSize;
  final String? label;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final iconColor = AppColors.primary.withOpacity(0.55);

    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      child: label == null
          ? Icon(Icons.build_circle_outlined, size: iconSize, color: iconColor)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.build_circle_outlined, size: iconSize, color: iconColor),
                SizedBox(height: 8.h),
                Text(
                  label!,
                  style: AppTypography.labelSmall.copyWith(color: iconColor),
                ),
              ],
            ),
    );
  }
}
