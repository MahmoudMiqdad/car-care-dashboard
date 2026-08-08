import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/features/billing/domain/entities/billing_entity.dart';
import 'package:car_care/features/billing/presentation/constsnts/billing_setting_params.dart';
import 'package:car_care/features/billing/presentation/cubit/billing_cubit.dart';
import 'package:car_care/features/billing/presentation/cubit/billing_state.dart';

import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// صفحة تعديل إعداد فوترة موجود (Edit Only).
/// بتاخد الـ id بس من الراوت (pathParameters)، وبتجيب التفاصيل من السيرفر
/// عبر loadBillingSettingDetails، وبعدين تعبي الفورم فيها.
class BillingSettingEditPageWeb extends StatelessWidget {
  final int billingSettingId;

  const BillingSettingEditPageWeb({super.key, required this.billingSettingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BillingSettingCubit>(
      create: (_) =>
          getIt<BillingSettingCubit>()..loadBillingSettingDetails(billingSettingId),
      child: const _BillingSettingEditView(),
    );
  }
}

class _BillingSettingEditView extends StatefulWidget {
  const _BillingSettingEditView();

  @override
  State<_BillingSettingEditView> createState() => _BillingSettingEditViewState();
}

class _BillingSettingEditViewState extends State<_BillingSettingEditView> {
  BillingSettingEntity? _loadedSetting;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AdminLayout(
      currentRoute: 'adminBillingSettings',
      title: strings.billingFormTitleEdit,
      child: BlocConsumer<BillingSettingCubit, BillingSettingState>(
        listener: (context, state) {
          if (state is BillingSettingError) {
            AppSnackBar.error(context, state.message);
          }
          if (state is BillingSettingDetailsLoaded) {
            _loadedSetting = state.setting;
          }
          if (state is BillingSettingFormSuccess) {
            AppSnackBar.success(context, state.message);
            _backToList(context, state.setting);
          }
        },
        builder: (context, state) {
          if (_loadedSetting == null) {
            if (state is BillingSettingError) {
              return Center(
                child: Text(state.message, style: const TextStyle(fontSize: 15)),
              );
            }
            return const Center(child: AppLoadingWidget());
          }

          final isSubmitting = state is BillingSettingFormSubmitting;

          return KeyedSubtree(
            key: ValueKey('billing_edit_form_${_loadedSetting!.id}'),
            child: _BillingEditForm(
              setting: _loadedSetting!,
              isSubmitting: isSubmitting,
            ),
          );
        },
      ),
    );
  }

  void _backToList(BuildContext context, BillingSettingEntity setting) {
    context.goNamed(
      'adminBillingSettings',
      queryParameters: {
        'provider_type': setting.providerType,
        'provider_id': setting.providerId.toString(),
      },
    );
  }
}

class _BillingEditForm extends StatefulWidget {
  final BillingSettingEntity setting;
  final bool isSubmitting;

  const _BillingEditForm({
    required this.setting,
    required this.isSubmitting,
  });

  @override
  State<_BillingEditForm> createState() => _BillingEditFormState();
}

class _BillingEditFormState extends State<_BillingEditForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _providerTypeCtrl;
  late final TextEditingController _providerIdCtrl;
  late final TextEditingController _monthlyFeeCtrl;
  late final TextEditingController _commissionCtrl;
  late final TextEditingController _freeTrialCtrl;
  late final TextEditingController _paymentDueCtrl;
  late final TextEditingController _notesCtrl;

  late String _billingType;
  DateTime? _startsAt;
  late bool _isActive;

  static const _fieldTextStyle = TextStyle(fontSize: 15);
  static const _labelStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  static const _fieldSpacing = SizedBox(height: 20);
  static const _labelSpacing = SizedBox(height: 8);
  static const _fieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    border: OutlineInputBorder(),
  );

  @override
  void initState() {
    super.initState();
    final s = widget.setting;

    _providerTypeCtrl = TextEditingController(text: s.providerType);
    _providerIdCtrl = TextEditingController(text: s.providerId.toString());
    _monthlyFeeCtrl = TextEditingController(text: s.monthlyFee?.toString() ?? '');
    _commissionCtrl = TextEditingController(text: s.commissionPercent?.toString() ?? '');
    _freeTrialCtrl = TextEditingController(text: (s.freeTrialDays ?? 0).toString());
    _paymentDueCtrl = TextEditingController(text: (s.paymentDueDays ?? 7).toString());
    _notesCtrl = TextEditingController(text: s.notes ?? '');

    _billingType = s.billingType ?? kBillingTypes.first;
    _isActive = s.isActive!;
    _startsAt = s.startsAt != null && s.startsAt!.isNotEmpty
        ? DateTime.tryParse(s.startsAt!)
        : null;
  }

  Future<void> _pick(
    BuildContext context,
    DateTime? initial,
    ValueChanged<DateTime?> onChanged,
  ) async {
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

  String _formatDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final params = BillingSettingParams(
      providerType: _providerTypeCtrl.text.trim(),
      providerId: int.tryParse(_providerIdCtrl.text.trim()),
      billingType: _billingType,
      monthlyFee: billingTypeShowsMonthlyFee(_billingType)
          ? num.tryParse(_monthlyFeeCtrl.text.trim())
          : null,
      commissionPercent: billingTypeShowsCommission(_billingType)
          ? num.tryParse(_commissionCtrl.text.trim())
          : null,
      freeTrialDays: int.tryParse(_freeTrialCtrl.text.trim()) ?? 0,
      paymentDueDays: int.tryParse(_paymentDueCtrl.text.trim()) ?? 7,
      startsAt: _startsAt != null ? _formatDate(_startsAt!) : null,
      isActive: _isActive,
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
    );

    context.read<BillingSettingCubit>().updateBillingSetting(widget.setting.id!, params);
  }

  @override
  void dispose() {
    _providerTypeCtrl.dispose();
    _providerIdCtrl.dispose();
    _monthlyFeeCtrl.dispose();
    _commissionCtrl.dispose();
    _freeTrialCtrl.dispose();
    _paymentDueCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Widget _fieldLabel(String text) => Text(text, style: _labelStyle);

  String _billingTypeLabel(BuildContext context, String type) {
    final strings = context.l10n;
    switch (type) {
      case 'monthly_subscription':
        return strings.billingTypeMonthly;
      case 'commission_per_order':
        return strings.billingTypeCommission;
      case 'subscription_plus_commission':
        return strings.billingTypeSubscriptionPlusCommission;
      case 'exempt':
        return strings.billingTypeExempt;
      default:
        return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.goNamed(
                        'adminBillingSettings',
                        queryParameters: {
                          'provider_type': widget.setting.providerType,
                          'provider_id': widget.setting.providerId.toString(),
                        },
                      ),
                      icon: const Icon(Icons.arrow_back_rounded, size: 20),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        strings.billingFormTitleEdit,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel(strings.billingFieldProviderType),
                          _labelSpacing,
                          TextFormField(
                            controller: _providerTypeCtrl,
                            enabled: false,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel(strings.billingFieldProviderId),
                          _labelSpacing,
                          TextFormField(
                            controller: _providerIdCtrl,
                            enabled: false,
                            keyboardType: TextInputType.number,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _fieldSpacing,

                _fieldLabel(strings.billingFieldBillingType),
                _labelSpacing,
                DropdownButtonFormField<String>(
                  initialValue: _billingType,
                  style: _fieldTextStyle.copyWith(color: Colors.black87),
                  decoration: _fieldDecoration,
                  items: kBillingTypes
                      .map((t) => DropdownMenuItem(
                            value: t,
                            child: Text(_billingTypeLabel(context, t), style: _fieldTextStyle),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      _billingType = v;
                      if (!billingTypeShowsMonthlyFee(v)) {
                        _monthlyFeeCtrl.clear();
                      }
                      if (!billingTypeShowsCommission(v)) {
                        _commissionCtrl.clear();
                      }
                    });
                  },
                ),
                _fieldSpacing,

                if (billingTypeShowsMonthlyFee(_billingType)) ...[
                  _fieldLabel(strings.billingFieldMonthlyFee),
                  _labelSpacing,
                  TextFormField(
                    controller: _monthlyFeeCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: _fieldTextStyle,
                    decoration: _fieldDecoration,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? strings.fieldRequired : null,
                  ),
                  _fieldSpacing,
                ],

                if (billingTypeShowsCommission(_billingType)) ...[
                  _fieldLabel(strings.billingFieldCommissionPercent),
                  _labelSpacing,
                  TextFormField(
                    controller: _commissionCtrl,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: _fieldTextStyle,
                    decoration: _fieldDecoration,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? strings.fieldRequired : null,
                  ),
                  _fieldSpacing,
                ],

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel(strings.billingFieldFreeTrialDays),
                          _labelSpacing,
                          TextFormField(
                            controller: _freeTrialCtrl,
                            keyboardType: TextInputType.number,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel(strings.billingFieldPaymentDueDays),
                          _labelSpacing,
                          TextFormField(
                            controller: _paymentDueCtrl,
                            keyboardType: TextInputType.number,
                            style: _fieldTextStyle,
                            decoration: _fieldDecoration,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _fieldSpacing,

                _fieldLabel(strings.billingFieldStartsAt),
                _labelSpacing,
                InkWell(
                  onTap: () => _pick(
                    context,
                    _startsAt,
                    (picked) => setState(() => _startsAt = picked),
                  ),
                  child: InputDecorator(
                    decoration: _fieldDecoration,
                    child: Text(
                      _startsAt != null ? _formatDate(_startsAt!) : strings.billingPickDate,
                      style: _fieldTextStyle,
                    ),
                  ),
                ),
                _fieldSpacing,

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(strings.billingFieldIsActive, style: _fieldTextStyle),
                  value: _isActive,
                  onChanged: (v) => setState(() => _isActive = v),
                ),
                const SizedBox(height: 6),

                _fieldLabel(
                  billingTypeIsExempt(_billingType)
                      ? strings.billingFieldExemptMethod
                      : strings.billingFieldNotes,
                ),
                _labelSpacing,
                TextFormField(
                  controller: _notesCtrl,
                  maxLines: 3,
                  style: _fieldTextStyle,
                  decoration: _fieldDecoration,
                  validator: billingTypeIsExempt(_billingType)
                      ? (v) => (v == null || v.trim().isEmpty)
                          ? strings.fieldRequired
                          : null
                      : null,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  height: 48,
                  child: FilledButton(
                    onPressed: widget.isSubmitting ? null : () => _submit(context),
                    child: widget.isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(strings.save, style: const TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}