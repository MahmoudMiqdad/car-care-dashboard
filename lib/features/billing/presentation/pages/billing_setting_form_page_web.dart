import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/features/billing/presentation/constsnts/billing_setting_params.dart';
import 'package:car_care/features/billing/presentation/cubit/billing_cubit.dart';
import 'package:car_care/features/billing/presentation/cubit/billing_state.dart';

import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class BillingSettingFormPageWeb extends StatelessWidget {
  final String? providerType;
  final int? providerId;

  const BillingSettingFormPageWeb({
    super.key,
    this.providerType,
    this.providerId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BillingSettingCubit>(
      create: (_) => getIt<BillingSettingCubit>(),
      child: _BillingSettingFormView(
        providerType: providerType,
        providerId: providerId,
      ),
    );
  }
}

class _BillingSettingFormView extends StatefulWidget {
  final String? providerType;
  final int? providerId;

  const _BillingSettingFormView({
    this.providerType,
    this.providerId,
  });

  @override
  State<_BillingSettingFormView> createState() => _BillingSettingFormViewState();
}

class _BillingSettingFormViewState extends State<_BillingSettingFormView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _providerTypeCtrl;
  late final TextEditingController _providerIdCtrl;
  final _monthlyFeeCtrl = TextEditingController();
  final _commissionCtrl = TextEditingController();
  final _freeTrialCtrl = TextEditingController(text: '0');
  final _paymentDueCtrl = TextEditingController(text: '7');
  final _notesCtrl = TextEditingController();

  String _billingType = kBillingTypes.first;
  DateTime? _startsAt;
  bool _isActive = true;

  static const _fieldTextStyle = TextStyle(fontSize: 15);
  static const _labelStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  static const _fieldSpacing = SizedBox(height: 20);
  static const _labelSpacing = SizedBox(height: 8);
  static const _fieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    border: OutlineInputBorder(),
  );

  bool get providerFieldsLocked => widget.providerType != null;

  @override
  void initState() {
    super.initState();
    _providerTypeCtrl = TextEditingController(text: widget.providerType ?? '');
    _providerIdCtrl = TextEditingController(text: widget.providerId?.toString() ?? '');
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

    context.read<BillingSettingCubit>().createBillingSetting(params);
  }

  void _backToList(BuildContext context) {
    context.goNamed(
      'adminBillingSettings',
      queryParameters: {
        if (widget.providerType != null) 'provider_type': widget.providerType!,
        if (widget.providerId != null) 'provider_id': widget.providerId!.toString(),
      },
    );
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

    return AdminLayout(
      currentRoute: 'adminBillingSettings',
      title: strings.billingFormTitleCreate,
      child: BlocConsumer<BillingSettingCubit, BillingSettingState>(
        listener: (context, state) {
          if (state is BillingSettingError) {
            AppSnackBar.error(context, state.message);
          }
          if (state is BillingSettingFormSuccess) {
            AppSnackBar.success(context, state.message);
            _backToList(context);
          }
        },
        builder: (context, state) {
          final isSubmitting = state is BillingSettingFormSubmitting;

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
                            onPressed: () => _backToList(context),
                            icon: const Icon(Icons.arrow_back_rounded, size: 20),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              strings.billingFormTitleCreate,
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
                                  enabled: !providerFieldsLocked,
                                  style: _fieldTextStyle,
                                  decoration: _fieldDecoration,
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty) ? strings.fieldRequired : null,
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
                                  enabled: !providerFieldsLocked,
                                  keyboardType: TextInputType.number,
                                  style: _fieldTextStyle,
                                  decoration: _fieldDecoration,
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty) ? strings.fieldRequired : null,
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
                          onPressed: isSubmitting ? null : () => _submit(context),
                          child: isSubmitting
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
        },
      ),
    );
  }
}