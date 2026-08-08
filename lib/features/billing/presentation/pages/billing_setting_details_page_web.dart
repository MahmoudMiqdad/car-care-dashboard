import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/features/billing/presentation/cubit/billing_cubit.dart';
import 'package:car_care/features/billing/presentation/cubit/billing_state.dart';
import 'package:car_care/features/billing/presentation/widgets/billing_setting_widgets.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BillingSettingDetailsPageWeb extends StatelessWidget {
  final int billingSettingId;

  const BillingSettingDetailsPageWeb({super.key, required this.billingSettingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BillingSettingCubit>(
      create: (_) => getIt<BillingSettingCubit>()..loadBillingSettingDetails(billingSettingId),
      child: _BillingSettingDetailsView(billingSettingId: billingSettingId),
    );
  }
}

class _BillingSettingDetailsView extends StatelessWidget {
  final int billingSettingId;
  const _BillingSettingDetailsView({required this.billingSettingId});

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '—';
    try {
      final d = DateTime.parse(iso);
      return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }

  String _billingTypeLabel(BuildContext context, String? type) {
    final strings = context.l10n;
    if (type == 'monthly_subscription') return strings.billingTypeMonthly;
    if (type == 'commission_based') return strings.billingTypeCommission;
    return type ?? '—';
  }

  Future<void> _delete(BuildContext context) async {
    final confirmed = await showBillingSettingDeleteDialog(context);
    if (confirmed) {
      context.read<BillingSettingCubit>().deleteBillingSetting(billingSettingId);
    }
  }

  void _backToList(BuildContext context, {String? providerType, int? providerId}) {
    context.goNamed(
      'adminBillingSettings',
      queryParameters: {
        if (providerType != null) 'provider_type': providerType,
        if (providerId != null) 'provider_id': providerId.toString(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AdminLayout(
      currentRoute: 'adminBillingSettings',
      title: strings.billingDetailsTitle,
      child: BlocConsumer<BillingSettingCubit, BillingSettingState>(
        listener: (context, state) {
          if (state is BillingSettingError) {
            AppSnackBar.error(context, state.message);
          }
          if (state is BillingSettingActionSuccess) {
            AppSnackBar.success(context, state.message);
            _backToList(
              context,
              providerType: state.settings.isNotEmpty ? state.settings.first.providerType : null,
            );
          }
        },
        builder: (context, state) {
          if (state is BillingSettingLoading || state is BillingSettingInitial) {
            return const Center(child: AppLoadingWidget());
          }
          if (state is BillingSettingError) {
            return Center(child: Text(state.message));
          }
          if (state is BillingSettingListActionLoading) {
            return const Center(child: AppLoadingWidget());
          }
          if (state is BillingSettingDetailsLoaded) {
            final s = state.setting;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => _backToList(
                              context,
                              providerType: s.providerType,
                              providerId: s.providerId,
                            ),
                            icon: const Icon(Icons.arrow_back_rounded, size: 20),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${s.providerType ?? '—'} ${s.providerId ?? '-'}',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          BillingSettingStatusBadge(isActive: s.isActive),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _InfoCard(
                        rows: [
                          MapEntry(strings.billingFieldProviderType, s.providerType),
                          MapEntry(strings.billingFieldProviderId, s.providerId?.toString()),
                          MapEntry(strings.billingFieldBillingType, _billingTypeLabel(context, s.billingType)),
                          if (s.billingType == 'monthly_subscription' && s.monthlyFee != null)
                            MapEntry(strings.billingFieldMonthlyFee, s.monthlyFee.toString()),
                          if (s.billingType == 'commission_based' && s.commissionPercent != null)
                            MapEntry(strings.billingFieldCommissionPercent, '${s.commissionPercent}%'),
                          MapEntry(strings.billingFieldFreeTrialDays, '${s.freeTrialDays ?? 0}'),
                          MapEntry(strings.billingFieldPaymentDueDays, '${s.paymentDueDays ?? 0}'),
                          MapEntry(strings.billingFieldStartsAt, _formatDate(s.startsAt)),
                        ],
                      ),

                      if (s.notes != null && s.notes!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        _Card(
                          title: strings.billingFieldNotes,
                          child: Text(
                            s.notes!,
                            style: const TextStyle(fontSize: 15, color: AppColors.black),
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                  
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
                          ],
                        ),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: [
                          SizedBox(
  height: 46,
  child: OutlinedButton.icon(
    onPressed: () => context.goNamed(
      'adminBillingSettingEdit',
      pathParameters: {'id': billingSettingId.toString()},
    ),
    icon: const Icon(Icons.edit_outlined, size: 18),
    label: Text(strings.actionEdit,style: TextStyle(fontSize: 20),),
  ),
),     SizedBox(
        height: 46,
        child: OutlinedButton.icon(
          onPressed: () => context.goNamed(
            'adminInvoices',
            queryParameters: {
              'provider_type': s.providerType ?? '',
              'provider_id': s.providerId?.toString() ?? '',
            },
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1565C0),
            side: const BorderSide(color: Color(0xFF1565C0)),
          ),
          icon: const Icon(Icons.receipt_long_outlined, size: 18),
          label: Text(strings.invoiceViewInvoices, style: const TextStyle(fontSize: 20)),
        ),
      ),
                            SizedBox(
                              height: 46,
                              child: OutlinedButton.icon(
                                onPressed: () => _delete(context),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFC62828),
                                  side: const BorderSide(color: Color(0xFFC62828)),
                                ),
                                icon: const Icon(Icons.delete_outline_rounded, size: 18),
                                label: Text(strings.actionDelete,style: TextStyle(fontSize: 20),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<MapEntry<String, String?>> rows;

  const _InfoCard({required this.rows});

  @override
  Widget build(BuildContext context) {
    final filtered = rows.where((e) => e.value != null && e.value!.isNotEmpty).toList();

    return _Card(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 480;
          return Wrap(
            runSpacing: 10,
            children: filtered.map((e) {
              return SizedBox(
                width: isWide ? constraints.maxWidth / 2 - 8 : constraints.maxWidth,
                child: _InfoRow(label: e.key, value: e.value!),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label :',
              style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String? title;
  final Widget child;

  const _Card({this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black)),
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );
  }
}