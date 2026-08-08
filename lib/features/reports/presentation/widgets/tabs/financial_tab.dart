// lib/features/reports/presentation/widgets/tabs/financial_tab.dart
import 'package:car_care/features/reports/presentation/constants/report_filter_options.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_state.dart';
import 'package:car_care/features/reports/presentation/widgets/reports_common_widgets.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinancialTab extends StatefulWidget {
  const FinancialTab({super.key});

  @override
  State<FinancialTab> createState() => _FinancialTabState();
}

class _FinancialTabState extends State<FinancialTab> {
  DateTime? _from;
  DateTime? _to;
  String? _providerType;
  String? _groupBy;

  @override
  void initState() {
    super.initState();
    context.read<ReportsCubit>().loadFinancial();
  }

  void _apply() {
    context.read<ReportsCubit>().loadFinancial(
          from: _from?.toIso8601String().split('T').first,
          to: _to?.toIso8601String().split('T').first,
          providerType: _providerType,
          groupBy: _groupBy,
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
                      label: strings.filterGroupBy,
                      value: _groupBy,
                      options: ReportFilterOptions.groupByOptions,
                      labels: groupByLabels(context),
                      onChanged: (v) {
                        setState(() => _groupBy = v);
                        _apply();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (state.financialLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: AppLoadingWidget()),
                )
              else if (state.financialError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ReportErrorView(message: state.financialError!, onRetry: _apply),
                )
              else if (state.financial != null) ...[
                ReportSectionCard(
                  title: strings.financialGrossRevenueTitle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: (state.financial!.grossRevenue?.bySource.entries ?? const <MapEntry<String, num>>[])
                            .map((e) => ReportStatCard(title: e.key, value: '${e.value}'))
                            .toList(),
                      ),
                      if (state.financial!.grossRevenue?.notes.isNotEmpty == true) ...[
                        const SizedBox(height: 12),
                        ...state.financial!.grossRevenue!.notes.map(
                          (n) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text('• $n', style: const TextStyle(fontSize: 12, color: Colors.black45)),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ReportSectionCard(
                  title: strings.financialBillingSummaryTitle,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ReportStatCard(title: strings.financialIssuedTotal, value: '${state.financial!.billing?.issuedTotal ?? 0}'),
                      ReportStatCard(title: strings.financialPaid, value: '${state.financial!.billing?.paidTotal ?? 0}'),
                      ReportStatCard(title: strings.financialUnpaid, value: '${state.financial!.billing?.unpaidTotal ?? 0}'),
                      ReportStatCard(title: strings.financialOverdue, value: '${state.financial!.billing?.overdueTotal ?? 0}'),
                      ReportStatCard(title: strings.financialCommissions, value: '${state.financial!.billing?.commissionTotal ?? 0}'),
                      ReportStatCard(title: strings.financialSubscriptions, value: '${state.financial!.billing?.subscriptionTotal ?? 0}'),
                    ],
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