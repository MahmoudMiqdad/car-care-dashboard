import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/const.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/sos/presentation/widgets/create_sos/create_sos_body.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

const _kCreateSosVehicleOptions = <String>[
  'كيا ري',
  'هيونداي اكسنت ',
];

const _kCreateSosProvinceOptions = <String>[
  'دمشق',
  'حلب',
];

class CreateSosPage extends StatefulWidget {
  const CreateSosPage({super.key});

  @override
  State<CreateSosPage> createState() => _CreateSosPageState();
}

class _CreateSosPageState extends State<CreateSosPage> {
  late final TextEditingController _descriptionController;
  String _vehicleValue = '';
  String _provinceValue = '';

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickVehicle() async {
    final choice = await _showStringPicker(options: _kCreateSosVehicleOptions);
    if (choice != null && mounted) {
      setState(() => _vehicleValue = choice);
    }
  }

  Future<void> _pickProvince() async {
    final choice = await _showStringPicker(options: _kCreateSosProvinceOptions);
    if (choice != null && mounted) {
      setState(() => _provinceValue = choice);
    }
  }

  Future<String?> _showStringPicker({required List<String> options}) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final option in options)
                  ListTile(
                    title: Text(
                      option,
                      style: Theme.of(sheetContext).textTheme.titleMedium,
                    ),
                    onTap: () => Navigator.of(sheetContext).pop(option),
                  ),
              ],
            ),
          ),
        );
      },
    );
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
          title: l10n.createSosTitle,
          showBackButton: true,
          onBackTapped: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(Routes.home);
            }
          },
        ),

        body: ImageBackground(
          child: CreateSosBody(
            descriptionController: _descriptionController,
            vehicleValue: _vehicleValue,
            provinceValue: _provinceValue,
            onPickVehicle: _pickVehicle,
            onPickProvince: _pickProvince,
            onSubmit: _onSubmit,
          ),
        ),
      ),
    );
  }
}
