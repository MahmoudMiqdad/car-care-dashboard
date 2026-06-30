// شاشة تفاصيل متجر قطع غيار محدّد
import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/app_typography.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/error_state_widget.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/domain/entities/shop_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/presentation/cubit/shop_details/shop_details_cubit.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/presentation/cubit/shop_details/shop_details_state.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/presentation/widgets/shop_info_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ShopDetailsPage extends StatefulWidget {
  const ShopDetailsPage({super.key, required this.shopId});

  final int shopId;

  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  late final ShopDetailsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ShopDetailsCubit>()..fetchShopDetails(widget.shopId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider.value(
        value: _cubit,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(title: 'تفاصيل المتجر'),
          body: ImageBackground(
            child: BlocBuilder<ShopDetailsCubit, ShopDetailsState>(
              builder: (context, state) {
                if (state is ShopDetailsLoading) {
                  return const AppLoadingWidget();
                }
                if (state is ShopDetailsError) {
                  return ErrorStateWidget(
                    message: state.message,
                    onRetry: () => _cubit.fetchShopDetails(widget.shopId),
                  );
                }
                if (state is ShopDetailsLoaded) {
                  return _buildLoaded(context, state.shop);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, ShopEntity shop) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  shop.name,
                  style: AppTypography.headlineMedium.copyWith(
                    color: AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: (shop.isActive ? AppColors.success : AppColors.error)
                      .withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  shop.isActive ? 'نشط' : 'غير نشط',
                  style: AppTypography.labelSmall.copyWith(
                    color: shop.isActive ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          if (shop.city != null)
            _InfoLine(icon: Icons.location_on_outlined, text: shop.city!),
          if (shop.phone != null)
            _InfoLine(icon: Icons.phone_outlined, text: shop.phone!),
          if (shop.owner?.name != null)
            _InfoLine(icon: Icons.person_outline, text: shop.owner!.name!),
          SizedBox(height: 18.h),
          ShopInfoChips(
            title: 'نوع النشاط',
            values: shop.businessTypes,
            titleIcon: Icons.storefront_outlined,
            chipColor: AppColors.accent,
          ),
          if (shop.businessTypes.isNotEmpty) SizedBox(height: 18.h),
          ShopInfoChips(
            title: 'ماركات السيارات',
            values: shop.carBrands,
            titleIcon: Icons.directions_car_outlined,
            chipColor: AppColors.success,
          ),
          if (shop.carBrands.isNotEmpty) SizedBox(height: 18.h),
          ShopInfoChips(
            title: 'فئات القطع',
            values: shop.partCategories,
            titleIcon: Icons.build_outlined,
            chipColor: AppColors.primary,
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.push(
                Routes.customerShopProductsPath(shop.id),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'عرض منتجات المتجر',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: AppColors.lightTextSecondary),
          SizedBox(width: 6.w),
          Text(
            text,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
