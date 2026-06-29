// قسم عرض اسم المنتج، السعر، الخصم، التوفر، والوصف
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:car_care/features/spare_parts_store/customer/product_details/presentation/models/product_details_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.product});

  final ProductDetailsUiModel product;

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.oldPrice > product.price;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: AppTypography.headlineSmall.copyWith(
            color: AppColors.lightTextPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 6.h,
          children: [
            _InfoChip(label: 'الفئة: ${product.category}'),
            _InfoChip(label: 'ماركة السيارة: ${product.carBrand}'),
          ],
        ),
        SizedBox(height: 14.h),
        Text(
          '${product.price.toStringAsFixed(0)} ل.س',
          style: AppTypography.headlineMedium.copyWith(
            color: AppColors.primary,
          ),
        ),
        if (hasDiscount) ...[
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                '${product.oldPrice.toStringAsFixed(0)} ل.س',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.lightTextSecondary,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'خصم ${product.discountPercent}%',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ],
        SizedBox(height: 6.h),
        Text(
          product.stock > 0 ? 'متوفر (${product.stock} قطعة)' : 'غير متوفر حاليًا',
          style: AppTypography.labelMedium.copyWith(
            color: product.stock > 0 ? AppColors.success : AppColors.error,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'الوصف',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.lightTextPrimary,
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
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}
