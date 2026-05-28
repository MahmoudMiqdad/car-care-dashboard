import 'package:car_care/core/constants/list_province.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/widgets/provider_edit_profile/provider_edit_profile_body.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/widgets/provider_edit_profile/provider_edit_profile_fuel_section.dart';
import 'package:car_care/features/fuel_provider/provider_profile/presentation/widgets/provider_profile/provider_profile_ui_model.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProviderEditProfilePage extends StatefulWidget {
  const ProviderEditProfilePage({super.key});

  @override
  State<ProviderEditProfilePage> createState() => _ProviderEditProfilePageState();
}

class _ProviderEditProfilePageState extends State<ProviderEditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  String? _governorateValue;
  late Map<String, String> _fuelPrices;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _governorateValue = kCreateSosProvinceOptions.first;
    _fuelPrices = ProviderProfileUiModel.previewFuelPricesMap();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_nameController.text.isNotEmpty) return;

    final l10n = context.l10n;
    _nameController.text = l10n.providerProfileSampleName;
    _phoneController.text = l10n.profileWasherSamplePhone;
    _addressController.text = l10n.providerEditProfileSampleAddress;
    _governorateValue ??= kCreateSosProvinceOptions.first;
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

  Future<void> _onFuelTypeTap(String fuelType) async {
    final price = await showProviderFuelPriceDialog(
      context,
      fuelType: fuelType,
      initialPrice: _fuelPrices[fuelType],
    );
    if (!mounted || price == null) return;
    setState(() => _fuelPrices[fuelType] = price);
  }

  void _onSave() {
    FocusScope.of(context).unfocus();
    context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: l10n.providerEditProfilePageTitle,
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
            onSave: _onSave,
            onCancel: () => context.pop(),
            onFuelTypeTap: _onFuelTypeTap,
          ),
        ),
      ),
    );
  }
}
