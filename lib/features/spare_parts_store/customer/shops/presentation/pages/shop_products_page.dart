// شاشة عرض منتجات متجر قطع غيار محدّد (الصفحة الأولى فقط حاليًا، بدون Pagination)
import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/widgets/Empty_state.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/error_state_widget.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/spare_parts_store/customer/products/presentation/widgets/product_card.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/presentation/cubit/shop_products/shop_products_cubit.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/presentation/cubit/shop_products/shop_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ShopProductsPage extends StatefulWidget {
  const ShopProductsPage({super.key, required this.shopId});

  final int shopId;

  @override
  State<ShopProductsPage> createState() => _ShopProductsPageState();
}

class _ShopProductsPageState extends State<ShopProductsPage> {
  late final ShopProductsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ShopProductsCubit>()..fetchShopProducts(widget.shopId);
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
          appBar: const CustomAppBar(title: 'منتجات المتجر'),
          body: ImageBackground(
            child: BlocBuilder<ShopProductsCubit, ShopProductsState>(
              builder: (context, state) {
                if (state is ShopProductsLoading) {
                  return const AppLoadingWidget();
                }
                if (state is ShopProductsError) {
                  return ErrorStateWidget(
                    message: state.message,
                    onRetry: () => _cubit.fetchShopProducts(widget.shopId),
                  );
                }
                if (state is ShopProductsEmpty) {
                  return const EmptyStateWidget();
                }
                if (state is ShopProductsLoaded) {
                  return GridView.builder(
                    padding: EdgeInsets.all(16.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      mainAxisExtent: 232.h,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => context.push(
                          Routes.customerProductDetailsPreviewPath(product.id),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
