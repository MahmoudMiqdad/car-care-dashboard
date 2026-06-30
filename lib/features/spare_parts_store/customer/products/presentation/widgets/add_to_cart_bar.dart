// شريط سفلي ثابت يحتوي على محدد الكمية وزر إضافة المنتج إلى السلة
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:car_care/features/spare_parts_store/customer/products/presentation/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCartBar extends StatelessWidget {
  const AddToCartBar({
    super.key,
    required this.quantity,
    required this.maxQuantity,
    required this.totalPrice,
    required this.onQuantityChanged,
    required this.onAddToCart,
    this.isLoading = false,
  });

  final int quantity;
  final int maxQuantity;
  final double totalPrice;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onAddToCart;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الكمية',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.lightTextSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                QuantitySelector(
                  quantity: quantity,
                  maxQuantity: maxQuantity,
                  onChanged: onQuantityChanged,
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: (maxQuantity > 0 && !isLoading) ? onAddToCart : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        'أضف إلى السلة — ${totalPrice.toStringAsFixed(0)} ل.س',
                        style: AppTypography.labelLarge.copyWith(color: AppColors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
