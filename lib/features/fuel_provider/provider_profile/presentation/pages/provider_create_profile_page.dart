import 'package:car_care/core/constants/list_province.dart';
import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/widgets/provider_edit_profile/provider_edit_profile_body.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/widgets/provider_edit_profile/provider_edit_profile_fuel_section.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProviderCreateProfilePage extends StatefulWidget {
  const ProviderCreateProfilePage({super.key});

  @override
  State<ProviderCreateProfilePage> createState() =>
      _ProviderCreateProfilePageState();
}

class _ProviderCreateProfilePageState extends State<ProviderCreateProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  String? _governorateValue;
  final Map<String, String> _fuelPrices = {};

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  Future<void> _onFuelTypeTap(String fuelType) async {
    final price = await showProviderFuelPriceDialog(
      context,
      fuelType: fuelType,
      initialPrice: _fuelPrices[fuelType],
    );
    if (!mounted || price == null) return;
    setState(() => _fuelPrices[fuelType] = price);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickGovernorate() async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) {
              return ListView(
                controller: scrollController,
                children: kCreateSosProvinceOptions.map((e) {
                  return ListTile(
                    title: Text(e),
                    onTap: () => Navigator.pop(context, e),
                  );
                }).toList(),
              );
            },
          ),
        );
      },
    );

    if (!mounted || choice == null) return;
    setState(() => _governorateValue = choice);
  }

  void _onCreate() {
    FocusScope.of(context).unfocus();
    context.go(Routes.provider_profile);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: l10n.providerCreateProfilePageTitle,
          showBackButton: true,
          backgroundColor: AppColors.carWashTeal,
          onBackTapped: () => context.pop(),
        ),
        body: ImageBackground(
          child: ProviderEditProfileBody(
            nameController: _nameController,
            phoneController: _phoneController,
            addressController: _addressController,
            governorateValue: _governorateValue,
            onPickGovernorate: _pickGovernorate,
            fuelPrices: _fuelPrices,
            onSave: _onCreate,
            onCancel: () => context.pop(),
            saveLabel: l10n.providerCreateProfileSave,
            onFuelTypeTap: _onFuelTypeTap,
          ),
        ),
      ),
    );
  }
}
