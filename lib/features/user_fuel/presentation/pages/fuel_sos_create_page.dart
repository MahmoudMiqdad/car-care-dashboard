import 'package:car_care/core/constants/list_province.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/user_fuel/presentation/widgets/fuel_sos_create/fuel_sos_create_body.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _kMockVehicles = [
  (label: 'تويوتا كامري'),
  (label: 'هوندا أكورد'),
  (label: 'نيسان التيما'),
];

class FuelSosCreatePage extends StatefulWidget {
  const FuelSosCreatePage({super.key});

  @override
  State<FuelSosCreatePage> createState() => _FuelSosCreatePageState();
}

class _FuelSosCreatePageState extends State<FuelSosCreatePage> {
  late final TextEditingController _quantityController;
  late final TextEditingController _notesController;

  String? _vehicleValue;
  String? _fuelTypeValue;
  String? _provinceValue;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickVehicle() async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _kMockVehicles.map((v) {
            return ListTile(
              leading: const CircleAvatar(
                radius: 20,
                child: Icon(Icons.directions_car, size: 18),
              ),
              title: Text(v.label),
              onTap: () => Navigator.pop(context, v.label),
            );
          }).toList(),
        );
      },
    );

    if (!mounted || choice == null) return;
    setState(() => _vehicleValue = choice);
  }

  Future<void> _pickFuelType() async {
    final l10n = context.l10n;
    final options = [l10n.gasoline91, l10n.gasoline95, l10n.diesel];

    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((e) {
            return ListTile(
              title: Text(e),
              onTap: () => Navigator.pop(context, e),
            );
          }).toList(),
        );
      },
    );

    if (!mounted || choice == null) return;
    setState(() => _fuelTypeValue = choice);
  }

  Future<void> _pickProvince() async {
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
    setState(() => _provinceValue = choice);
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: l10n.fuelSosCreateTitle,
          showBackButton: true,
          onBackTapped: () => context.pop(),
        ),
        body: ImageBackground(
          child: FuelSosCreateBody(
            vehicleValue: _vehicleValue,
            fuelTypeValue: _fuelTypeValue,
            provinceValue: _provinceValue,
            quantityController: _quantityController,
            notesController: _notesController,
            onPickVehicle: _pickVehicle,
            onPickFuelType: _pickFuelType,
            onPickProvince: _pickProvince,
            onSubmit: _onSubmit,
          ),
        ),
      ),
    );
  }
}
