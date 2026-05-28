import 'package:car_care/core/constants/app_constants.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/theme/buttons/app_button_widget.dart';
import 'package:car_care/features/fuel_provider/provider_order/presentation/widgets/provider_order_details/provider_order_details_cards.dart';
import 'package:car_care/features/fuel_provider/provider_order/presentation/widgets/provider_order_details/provider_order_details_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderOrderDetailsBody extends StatefulWidget {
  const ProviderOrderDetailsBody({
    super.key,
    required this.order,
    this.onAcceptOrder,
  });

  final ProviderOrderDetailsUiModel order;
  final VoidCallback? onAcceptOrder;

  @override
  State<ProviderOrderDetailsBody> createState() =>
      _ProviderOrderDetailsBodyState();
}

class _ProviderOrderDetailsBodyState extends State<ProviderOrderDetailsBody> {
  bool _isSharingLocation = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          AppConstants.pageHorizontal,
          16.h,
          AppConstants.pageHorizontal,
          24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProviderOrderDetailsPendingBanner(
              label: l10n.providerOrderDetailsPendingAcceptance,
            ),
            SizedBox(height: 14.h),
            ProviderOrderDetailsOrderCard(order: widget.order),
            SizedBox(height: 14.h),
            ProviderOrderDetailsCustomerCard(order: widget.order),
            SizedBox(height: 14.h),
            ProviderOrderDetailsLocationCard(
              order: widget.order,
              isSharingLocation: _isSharingLocation,
              onSharingChanged: (value) {
                setState(() => _isSharingLocation = value);
              },
            ),
            SizedBox(height: 22.h),
            AppButton(
              onPressed: widget.onAcceptOrder ?? () {},
              text: l10n.providerOrderDetailsAcceptOrder,
              backgroundColor: AppColors.orange,
              textColor: AppColors.white,
              borderRadius: 14.r,
              height: 52.h,
            ),
          ],
        ),
      ),
    );
  }
}
