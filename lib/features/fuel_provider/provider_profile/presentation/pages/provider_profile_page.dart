import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/widgets/provider_profile/provider_profile_body.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/widgets/provider_profile/provider_profile_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProviderProfilePage extends StatefulWidget {
  const ProviderProfilePage({super.key});

  @override
  State<ProviderProfilePage> createState() => _ProviderProfilePageState();
}

class _ProviderProfilePageState extends State<ProviderProfilePage> {
  bool _isAvailable = true;

  ProviderProfileUiModel _profile(BuildContext context) {
    final l10n = context.l10n;

    return ProviderProfileUiModel(
      name: l10n.providerProfileSampleName,
      phone: l10n.profileWasherSamplePhone,
      address: l10n.profileWasherSampleFullAddress,
      isAvailable: _isAvailable,
      fuelPrices: ProviderProfileUiModel.preview.fuelPrices,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final profile = _profile(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: l10n.providerProfilePageTitle,
          showBackButton: true,
          backgroundColor: AppColors.carWashTeal,
          onBackTapped: () => context.pop(),
        ),
        body: ImageBackground(
          child: ProviderProfileBody(
            profile: profile,
            onAvailabilityChanged: (value) {
              setState(() => _isAvailable = value);
            },
            onEditProfile: () async {
              await context.push(Routes.provider_edit_profile);
            },
          ),
        ),
      ),
    );
  }
}
