import 'package:car_care/features/reports/domain/entities/reports_entity.dart';
import 'package:car_care/features/reports/presentation/constants/report_filter_options.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_state.dart';
import 'package:car_care/features/reports/presentation/widgets/reports_common_widgets.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({super.key});

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  DateTime? _from;
  DateTime? _to;
  String? _providerType;
  String? _status;

  @override
  void initState() {
    super.initState();
    context.read<ReportsCubit>().loadOverview();
  }

  void _apply() {
    context.read<ReportsCubit>().loadOverview(
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
                      label: strings.filterStatus,
                      value: _status,
                      options: ReportFilterOptions.operationStatuses,
                      labels: operationStatusLabels(context),
                      onChanged: (v) {
                        setState(() => _status = v);
                        _apply();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (state.overviewLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: AppLoadingWidget()),
                )
              else if (state.overviewError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ReportErrorView(message: state.overviewError!, onRetry: _apply),
                )
              else if (state.overview != null)
                _OverviewContent(data: state.overview!),
            ],
          ),
        );
      },
    );
  }
}

class _OverviewContent extends StatelessWidget {
  final OverviewReportEntity data;
  const _OverviewContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final provTypeLabels = providerTypeLabels(context);
    final provStatusLabels = providerStatusLabels(context);
    final opTypeLabels = operationTypeLabels(context);
    final e = data.entities;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            ReportStatCard(title: strings.overviewTotalUsers, value: '${e?.totalUsers ?? 0}', icon: Icons.people_alt_rounded),
            ReportStatCard(title: strings.overviewTotalCustomers, value: '${e?.totalCustomers ?? 0}', icon: Icons.person_rounded),
            ReportStatCard(title: strings.overviewTotalProviders, value: '${e?.totalProviders ?? 0}', icon: Icons.store_rounded),
          ],
        ),
        const SizedBox(height: 20),

        ReportSectionCard(
          title: strings.overviewProvidersByTypeStatusTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: (e?.providersByStatus.entries ?? const <MapEntry<String, Map<String, int>>>[]).map((entry) {
              final total = e?.providersByType[entry.key] ?? 0;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text(
                        '${provTypeLabels[entry.key] ?? entry.key}   ($total)',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
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
          title: strings.overviewOperationsSummaryTitle,
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: data.operationsSummary.entries.map((entry) {
              final label = opTypeLabels[entry.key] ?? entry.key;
              final c = entry.value;
              return Container(
                width: 220,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F7FB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    Text('${strings.opStatusCompleted}: ${c.completed ?? 0}', style: const TextStyle(fontSize: 12)),
                    Text('${strings.opStatusPending}: ${c.pending ?? 0}   ${strings.opStatusCancelled}: ${c.cancelled ?? 0}', style: const TextStyle(fontSize: 12)),
                    Text('${strings.opStatusInProgress}: ${c.inProgress ?? 0}', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        ReportSectionCard(
          title: strings.overviewRevenueSummaryTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: (data.revenueSummary?.bySource.entries ?? const <MapEntry<String, num>>[])
                    .map((e2) => ReportStatCard(title: e2.key, value: '${e2.value}'))
                    .toList(),
              ),
        
            ],
          ),
        ),
        const SizedBox(height: 16),

        ReportSectionCard(
          title: strings.adsLatestTitle,
          child: (data.advertisementsSummary?.latestAds.isEmpty ?? true)
              ? Text(strings.adsEmpty, style: const TextStyle(fontSize: 13, color: Colors.black54))
              : Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: data.advertisementsSummary!.latestAds.map((ad) {
                    return Container(
                      width: 200,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => showFullImagePreview(context, ad.imageUrl),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                ad.imageUrl ?? '',
                                height: 90,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => Container(
                                  height: 90,
                                  color: const Color(0xFFF0F0F0),
                                  child: const Icon(Icons.broken_image_outlined),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(ad.title ?? '—', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                          Text(ad.placement ?? '', style: const TextStyle(fontSize: 11, color: Colors.black54)),
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