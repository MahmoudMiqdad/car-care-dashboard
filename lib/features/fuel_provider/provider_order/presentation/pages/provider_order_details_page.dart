import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/fuel_provider/provider_order/presentation/widgets/provider_order_details/provider_accept_order_dialog.dart';
import 'package:car_care/features/fuel_provider/provider_order/presentation/widgets/provider_order_details/provider_order_details_body.dart';
import 'package:car_care/features/fuel_provider/provider_order/presentation/widgets/provider_order_details/provider_order_details_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProviderOrderDetailsPage extends StatelessWidget {
  const ProviderOrderDetailsPage({super.key, this.order});

  final ProviderOrderDetailsUiModel? order;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final details = order ?? ProviderOrderDetailsUiModel.preview;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: l10n.providerOrderDetailsTitle,
          showBackButton: true,
          backgroundColor: AppColors.carWashTeal,
          onBackTapped: () => context.pop(),
        ),
        body: ImageBackground(
          child: ProviderOrderDetailsBody(
            order: details,
            onAcceptOrder: () => showProviderAcceptOrderDialog(context),
          ),
        ),
      ),
    );
  }
}
