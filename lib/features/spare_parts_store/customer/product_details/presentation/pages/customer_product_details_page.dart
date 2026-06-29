// شاشة UI Prototype لتفاصيل المنتج لعميل متجر قطع الغيار
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/features/spare_parts_store/customer/product_details/presentation/models/product_details_ui_model.dart';
import 'package:car_care/features/spare_parts_store/customer/product_details/presentation/widgets/add_to_cart_bar.dart';
import 'package:car_care/features/spare_parts_store/customer/product_details/presentation/widgets/product_image_gallery.dart';
import 'package:car_care/features/spare_parts_store/customer/product_details/presentation/widgets/product_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerProductDetailsPage extends StatefulWidget {
  const CustomerProductDetailsPage({super.key});

  @override
  State<CustomerProductDetailsPage> createState() =>
      _CustomerProductDetailsPageState();
}

class _CustomerProductDetailsPageState
    extends State<CustomerProductDetailsPage> {
  int _quantity = 1;

  static const _product = ProductDetailsUiModel.sample;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightSurface,
        appBar: const CustomAppBar(title: 'تفاصيل المنتج'),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImageGallery(
                imageCount: _product.images.length,
                isNew: _product.isNew,
              ),
              SizedBox(height: 16.h),
              ProductInfoSection(product: _product),
            ],
          ),
        ),
        bottomNavigationBar: AddToCartBar(
          quantity: _quantity,
          maxQuantity: _product.stock,
          totalPrice: _product.price * _quantity,
          onQuantityChanged: (value) => setState(() => _quantity = value),
          onAddToCart: () {},
        ),
      ),
    );
  }
}
