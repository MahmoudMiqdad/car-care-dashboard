// lib/features/reports/presentation/widgets/tabs/providers_tab.dart
import 'package:car_care/features/reports/presentation/constants/report_filter_options.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_state.dart';
import 'package:car_care/features/reports/presentation/widgets/reports_common_widgets.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvidersTab extends StatefulWidget {
  const ProvidersTab({super.key});

  @override
  State<ProvidersTab> createState() => _ProvidersTabState();
}

class _ProvidersTabState extends State<ProvidersTab> {
  String? _providerType;
  String? _providerStatus;
  String? _billingStatus;

  @override
  void initState() {
    super.initState();
    context.read<ReportsCubit>().loadProviders();
  }

  void _apply() {
    context.read<ReportsCubit>().loadProviders(
          providerType: _providerType,
          providerStatus: _providerStatus,
          billingStatus: _billingStatus,
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
                      label: strings.filterProviderStatus,
                      value: _providerStatus,
                      options: ReportFilterOptions.providerStatuses,
                      labels: providerStatusLabels(context),
                      onChanged: (v) {
                        setState(() => _providerStatus = v);
                        _apply();
                      },
                    ),
                    ReportDropdownFilter(
                      label: strings.filterBillingStatus,
                      value: _billingStatus,
                      options: ReportFilterOptions.billingStatuses,
                      labels: billingStatusLabels(context),
                      onChanged: (v) {
                        setState(() => _billingStatus = v);
                        _apply();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (state.providersLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: AppLoadingWidget()),
                )
              else if (state.providersError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ReportErrorView(message: state.providersError!, onRetry: _apply),
                )
              else if (state.providers != null)
                _ProvidersContent(data: state.providers!),
            ],
          ),
        );
      },
    );
  }
}

class _ProvidersContent extends StatelessWidget {
  final dynamic data; // ProvidersReportEntity
  const _ProvidersContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final provTypeLabels = providerTypeLabels(context);
    final provStatusLabels = providerStatusLabels(context);
    final billStatusLabels = billingStatusLabels(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            ReportStatCard(
              title: strings.providersPendingApproval,
              value: '${data.needingAction?.pendingApproval ?? 0}',
              color: const Color(0xFFEF6C00),
              icon: Icons.pending_actions_rounded,
            ),
            ReportStatCard(
              title: strings.providersOverdueBilling,
              value: '${data.needingAction?.overdueBillingCount ?? 0}',
              color: const Color(0xFFC62828),
              icon: Icons.warning_amber_rounded,
            ),
            ReportStatCard(
              title: strings.providersBillingNotConfigured,
              value: '${data.needingAction?.notConfiguredBillingCount ?? 0}',
              color: const Color(0xFF616161),
              icon: Icons.settings_outlined,
            ),
          ],
        ),
        const SizedBox(height: 16),

        ReportSectionCard(
          title: strings.providersCountByTypeTitle,
          child: Wrap(
            spacing: 10,
            children: (data.countsByType as Map<String, int>)
                .entries
                .map((e) => Chip(
                      label: Text('${provTypeLabels[e.key] ?? e.key}: ${e.value}', style: const TextStyle(fontSize: 12)),
                      visualDensity: VisualDensity.compact,
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),

        ReportSectionCard(
          title: strings.providersStatusByTypeTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: (data.countsByProviderStatus as Map<String, Map<String, int>>).entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(provTypeLabels[entry.key] ?? entry.key,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        children: entry.value.entries
                            .map((s) => Chip(
                                  label: Text('${provStatusLabels[s.key] ?? s.key}: ${s.value}',
                                      style: const TextStyle(fontSize: 11)),
                                  visualDensity: VisualDensity.compact,
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        ReportSectionCard(
          title: strings.filterBillingStatus,
          child: Wrap(
            spacing: 10,
            children: (data.countsByBillingStatus as Map<String, int>)
                .entries
                .map((e) => Chip(
                      label: Text('${billStatusLabels[e.key] ?? e.key}: ${e.value}', style: const TextStyle(fontSize: 12)),
                      visualDensity: VisualDensity.compact,
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),

        ReportSectionCard(
          title: strings.providersTopByCompletedTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: (data.topProvidersByCompletedOperations as Map<String, List<dynamic>>).entries.map((entry) {
              if (entry.value.isEmpty) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(provTypeLabels[entry.key] ?? entry.key,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    ...entry.value.map((p) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            strings.providersCompletedOpsLine(p.providerName ?? '—', p.providerId.toString(), p.completedCount.toString()),
                            style: const TextStyle(fontSize: 12),
                          ),
                        )),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}