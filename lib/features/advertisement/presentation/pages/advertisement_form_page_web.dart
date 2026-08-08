// advertisement_form_page_web.dart
import 'dart:typed_data';

import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/advertisement/domain/entities/advertisement_entity.dart';
import 'package:car_care/features/advertisement/presentation/cubit/advertisement_cubit.dart';
import 'package:car_care/features/advertisement/presentation/cubit/advertisement_state.dart';
import 'package:car_care/features/advertisement/presentation/widgets/advertisement_widgets.dart';

import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AdvertisementFormPageWeb extends StatelessWidget {
  final int? advertisementId;

  const AdvertisementFormPageWeb({super.key, this.advertisementId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdvertisementCubit>(
      create: (_) {
        final cubit = getIt<AdvertisementCubit>();
        if (advertisementId != null) cubit.loadAdvertisementDetails(advertisementId!);
        return cubit;
      },
      child: _AdvertisementFormView(advertisementId: advertisementId),
    );
  }
}

class _AdvertisementFormView extends StatefulWidget {
  final int? advertisementId;
  const _AdvertisementFormView({this.advertisementId});

  @override
  State<_AdvertisementFormView> createState() => _AdvertisementFormViewState();
}

class _AdvertisementFormViewState extends State<_AdvertisementFormView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _linkController = TextEditingController();
  final _sortOrderController = TextEditingController();

  static const _fieldTextStyle = TextStyle(fontSize: 15);
  static const _labelStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  static const _fieldSpacing = SizedBox(height: 20);
  static const _labelSpacing = SizedBox(height: 8);

  String _placement = 'home';
  bool _isActive = true;
  DateTime? _startsAt;
  DateTime? _endsAt;
  XFile? _pickedImage;
  AdvertisementEntity? _loadedAd;
  bool _initialized = false;

  bool get isEdit => widget.advertisementId != null;

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    _sortOrderController.dispose();
    super.dispose();
  }

  void _fillFromEntity(AdvertisementEntity ad) {
    if (_initialized) return;
    _initialized = true;
    _loadedAd = ad;
    _titleController.text = ad.title ?? '';
    _linkController.text = ad.linkUrl ?? '';
    _sortOrderController.text = (ad.sortOrder ?? 0).toString();
    _placement = ad.placement ?? 'home';
    _isActive = ad.isActive ?? true;
    _startsAt = ad.startsAt != null ? DateTime.tryParse(ad.startsAt!) : null;
    _endsAt = ad.endsAt != null ? DateTime.tryParse(ad.endsAt!) : null;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (image != null) setState(() => _pickedImage = image);
  }

  Future<void> _pick(BuildContext context, DateTime? initial, ValueChanged<DateTime?> onChanged) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        final baseTheme = Theme.of(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Theme(
            data: baseTheme.copyWith(
              textTheme: Typography.material2021(platform: baseTheme.platform).black,
              colorScheme: baseTheme.colorScheme.copyWith(primary: AppColors.primary),
            ),
            child: child!,
          ),
        );
      },
    );
    if (picked != null) onChanged(picked);
  }

  Future<void> _submit() async {
    final strings = context.l10n;
    if (!_formKey.currentState!.validate()) return;
    if (!isEdit && _pickedImage == null) {
      AppSnackBar.error(context, strings.adFormImageRequired);
      return;
    }

    final cubit = context.read<AdvertisementCubit>();
    final sortOrder = int.tryParse(_sortOrderController.text.trim()) ?? 0;

    Uint8List? imageBytes;
    String? imageFileName;
    if (_pickedImage != null) {
      imageBytes = await _pickedImage!.readAsBytes();
      imageFileName = _pickedImage!.name;
    }

    if (isEdit) {
      cubit.updateAdvertisement(
        id: widget.advertisementId!,
        title: _titleController.text.trim(),
        placement: _placement,
        isActive: _isActive,
        sortOrder: sortOrder,
        imageBytes: imageBytes,
        imageFileName: imageFileName,
      );
    } else {
      cubit.createAdvertisement(
        title: _titleController.text.trim(),
        placement: _placement,
        linkUrl: _linkController.text.trim().isEmpty ? null : _linkController.text.trim(),
        startsAt: _startsAt?.toIso8601String(),
        endsAt: _endsAt?.toIso8601String(),
        sortOrder: sortOrder,
        imageBytes: imageBytes!,
        imageFileName: imageFileName!,
      );
    }
  }

  // Helper: fixed label as Text above the field (instead of floating label on the border)
  Widget _fieldLabel(String text) => Text(text, style: _labelStyle);

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AdminLayout(
      currentRoute: 'adminAdvertisements',
      title: isEdit ? strings.advertisementDetailsTitle : strings.adCreateNew,
      child: BlocConsumer<AdvertisementCubit, AdvertisementState>(
        listener: (context, state) {
          if (state is AdvertisementError) AppSnackBar.error(context, state.message);
          if (state is AdvertisementDetailsLoaded) _fillFromEntity(state.ad);
          if (state is AdvertisementActionSuccess) {
            AppSnackBar.success(context, state.message);
            if (context.canPop()) {
              context.pop();
            } else {
              context.goNamed('adminAdvertisements');
            }
          }
        },
        builder: (context, state) {
          if (isEdit && _loadedAd == null && state is! AdvertisementDetailsLoaded) {
            if (state is AdvertisementLoading || state is AdvertisementInitial) {
              return const Center(child: AppLoadingWidget());
            }
          }

          final isSubmitting = state is AdvertisementSubmitting;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AdvertisementImagePicker(
                        pickedImage: _pickedImage,
                        existingImageUrl: _loadedAd?.imageUrl,
                        onPick: _pickImage,
                      ),
                      const SizedBox(height: 24),

                      // ---- Title ----
                      _fieldLabel(strings.adFormTitleLabel),
                      _labelSpacing,
                      TextFormField(
                        controller: _titleController,
                        style: _fieldTextStyle,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty) ? strings.adFormRequiredField : null,
                      ),
                      _fieldSpacing,

                      // ---- Placement ----
                      _fieldLabel(strings.adFormPlacementLabel),
                      _labelSpacing,
                      DropdownButtonFormField<String>(
                        initialValue: _placement,
                        style: const TextStyle(fontSize: 15, color: Colors.black87),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'home',
                            child: Text('home', style: TextStyle(fontSize: 15)),
                          ),
                          DropdownMenuItem(
                            value: 'service  ',
                            child: Text('service ', style: TextStyle(fontSize: 15)),
                          ),
                           DropdownMenuItem(
                            value: 'general',
                            child: Text('general', style: TextStyle(fontSize: 15)),
                          ),
                           DropdownMenuItem(
                            value: 'dashboard ',
                            child: Text('dashboard', style: TextStyle(fontSize: 15)),
                          ),
                        ],
                        onChanged: (v) => setState(() => _placement = v ?? 'home'),
                      ),
                      _fieldSpacing,

                      // ---- Link ----
                      _fieldLabel(strings.adFormLinkLabel),
                      _labelSpacing,
                      TextFormField(
                        controller: _linkController,
                        style: _fieldTextStyle,
                        decoration: const InputDecoration(
                          hintText: 'https://example.com/sale',
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _fieldSpacing,

                      // ---- Dates ----
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _DateField(
                              label: strings.adFormStartsLabel,
                              value: _startsAt,
                              onTap: () => _pick(context, _startsAt, (v) => setState(() => _startsAt = v)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _DateField(
                              label: strings.adFormEndsLabel,
                              value: _endsAt,
                              onTap: () => _pick(context, _endsAt, (v) => setState(() => _endsAt = v)),
                            ),
                          ),
                        ],
                      ),
                      _fieldSpacing,

                      // ---- Sort order ----
                      _fieldLabel(strings.adFormSortOrderLabel),
                      _labelSpacing,
                      TextFormField(
                        controller: _sortOrderController,
                        keyboardType: TextInputType.number,
                        style: _fieldTextStyle,
                        decoration: InputDecoration(
                          hintText: strings.adRankingExplanation,
                          hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                          border: const OutlineInputBorder(),
                        ),
                      ),

                      if (isEdit) ...[
                        const SizedBox(height: 12),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(strings.adFormActiveLabel, style: _fieldTextStyle),
                          value: _isActive,
                          onChanged: (v) => setState(() => _isActive = v),
                        ),
                      ],
                      const SizedBox(height: 28),
                      SizedBox(
                        height: 48,
                        child: FilledButton(
                          onPressed: isSubmitting ? null : _submit,
                          child: isSubmitting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : Text(strings.adFormSave, style: const TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  const _DateField({required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final text = value == null
        ? ''
        : '${value!.year}-${value!.month.toString().padLeft(2, '0')}-${value!.day.toString().padLeft(2, '0')}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: InputDecorator(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              border: OutlineInputBorder(),
            ),
            child: Text(
              text.isEmpty ? '—' : text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}