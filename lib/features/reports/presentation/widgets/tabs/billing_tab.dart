// lib/features/reports/presentation/widgets/tabs/billing_tab.dart
import 'package:car_care/features/reports/presentation/constants/report_filter_options.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_state.dart';
import 'package:car_care/features/reports/presentation/widgets/reports_common_widgets.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillingTab extends StatefulWidget {
  const BillingTab({super.key});

  @override
  State<BillingTab> createState() => _BillingTabState();
}

class _BillingTabState extends State<BillingTab> {
  DateTime? _from;
  DateTime? _to;
  String? _providerType;
  String? _status;

  @override
  void initState() {
    super.initState();
    context.read<ReportsCubit>().loadBilling();
  }

  void _apply() {
    context.read<ReportsCubit>().loadBilling(
          from: _from?.toIso8601String().split('T').first,
          to: _to?.toIso8601String().split('T').first,
          providerType: _providerType,
          status: _status,
        );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReportSectionCard(
                child: Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    DateRangeFilterBar(
                      from: _from,
                      to: _to,
                      onFromChanged: (d) => setState(() => _from = d),
                      onToChanged: (d) => setState(() => _to = d),
                      onApply: _apply,
                    ),
                    ReportDropdownFilter(
                      label: strings.filterProviderType,
                      value: _providerType,
                      options: ReportFilterOptions.providerTypes,
                      labels: providerTypeLabels(context),
                      onChanged: (v) {
                        setState(() => _providerType = v);
                        _apply();
                      },
                    ),
                    ReportDropdownFilter(
                      label: strings.filterInvoiceStatus,
                      value: _status,
                      options: ReportFilterOptions.invoiceStatuses,
                      onChanged: (v) {
                        setState(() => _status = v);
                        _apply();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (state.billingLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: AppLoadingWidget()),
                )
              else if (state.billingError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ReportErrorView(message: state.billingError!, onRetry: _apply),
                )
              else if (state.billing != null) ...[
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    ReportStatCard(title: strings.billingInvoicesCount, value: '${state.billing!.invoicesCount ?? 0}'),
                    ReportStatCard(title: strings.billingDraft, value: '${state.billing!.draftCount ?? 0}'),
                    ReportStatCard(title: strings.billingIssued, value: '${state.billing!.issuedCount ?? 0}'),
                    ReportStatCard(title: strings.billingOverdueCount, value: '${state.billing!.overdueCount ?? 0}', color: const Color(0xFFC62828)),
                    ReportStatCard(title: strings.billingPaidCount, value: '${state.billing!.paidCount ?? 0}', color: const Color(0xFF2E7D32)),
                    ReportStatCard(title: strings.billingCancelled, value: '${state.billing!.cancelledCount ?? 0}'),
                  ],
                ),
                const SizedBox(height: 16),
                ReportSectionCard(
                  title: strings.billingFinancialTotalsTitle,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ReportStatCard(title: strings.billingPaidTotal, value: '${state.billing!.paidTotal ?? 0}'),
                      ReportStatCard(title: strings.billingUnpaidTotal, value: '${state.billing!.unpaidTotal ?? 0}'),
                      ReportStatCard(title: strings.billingOverdueTotal, value: '${state.billing!.overdueTotal ?? 0}'),
                      ReportStatCard(title: strings.billingAvgInvoice, value: '${state.billing!.averageInvoiceAmount ?? 0}'),
                      ReportStatCard(title: strings.billingProvidersOverdue, value: '${state.billing!.providersWithOverdueCount ?? 0}'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ReportSectionCard(
                  title: strings.billingLatestInvoicesTitle,
                  child: state.billing!.latestInvoices.isEmpty
                      ? Text(strings.billingEmpty, style: const TextStyle(fontSize: 13, color: Colors.black54))
                      : Column(
                          children: state.billing!.latestInvoices
                              .map((inv) => ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(inv.providerName ?? '—', style: const TextStyle(fontSize: 13)),
                                    subtitle: Text(
                                      '${strings.billingStatusLabel}: ${inv.status ?? '—'}  •  ${strings.billingIssuedAtLabel}: ${inv.issuedAt ?? '—'}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    trailing: Text('${inv.amount ?? 0}',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  ))
                              .toList(),
                        ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}