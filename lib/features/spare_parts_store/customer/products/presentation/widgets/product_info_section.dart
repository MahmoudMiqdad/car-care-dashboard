// قسم عرض اسم المنتج، السعر، الخصم، التوفر، والوصف
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:car_care/features/spare_parts_store/customer/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final showDiscount = product.discountPrice != null && product.hasDiscount;

    final tags = <Widget>[
      _InfoChip(
        label: 'الحالة: ${product.isNew ? 'جديد' : 'مستعمل'}',
        backgroundColor: AppColors.accent.withOpacity(0.14),
        textColor: AppColors.accent,
      ),
      if (product.partCategoryName != null)
        _InfoChip(
          label: 'الفئة: ${product.partCategoryName}',
          backgroundColor: AppColors.secondary,
          textColor: AppColors.lightTextPrimary,
        ),
      if (product.carBrandName != null)
        _InfoChip(
          label: 'ماركة السيارة: ${product.carBrandName}',
          backgroundColor: AppColors.white,
          textColor: AppColors.lightTextSecondary,
          borderColor: AppColors.lightBorder,
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: AppTypography.headlineMedium.copyWith(
            color: AppColors.lightTextPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 6.h,
          children: tags,
        ),
        SizedBox(height: 16.h),
        Text(
          '${product.finalPrice.toStringAsFixed(0)} ل.س',
          style: AppTypography.headlineLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (showDiscount) ...[
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                '${product.price.toStringAsFixed(0)} ل.س',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.lightTextSecondary,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'خصم ${product.discountPercent}%',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
        SizedBox(height: 10.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: product.stockQuantity > 0 ? AppColors.success : AppColors.error,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              product.stockQuantity > 0
                  ? 'متوفر (${product.stockQuantity} قطعة)'
                  : 'غير متوفر حاليًا',
              style: AppTypography.labelSmall.copyWith(
                color: product.stockQuantity > 0 ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        Divider(color: AppColors.lightBorder, height: 1),
        SizedBox(height: 14.h),
        Text(
          'الوصف',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          product.description,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
