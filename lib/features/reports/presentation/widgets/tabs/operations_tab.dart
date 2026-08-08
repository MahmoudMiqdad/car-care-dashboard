// lib/features/reports/presentation/widgets/tabs/operations_tab.dart
import 'package:car_care/features/reports/presentation/constants/report_filter_options.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_state.dart';
import 'package:car_care/features/reports/presentation/widgets/reports_common_widgets.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperationsTab extends StatefulWidget {
  const OperationsTab({super.key});

  @override
  State<OperationsTab> createState() => _OperationsTabState();
}

class _OperationsTabState extends State<OperationsTab> {
  DateTime? _from;
  DateTime? _to;
  String? _operationType;
  String? _status;
  String? _groupBy;

  @override
  void initState() {
    super.initState();
    context.read<ReportsCubit>().loadOperations();
  }

  void _apply() {
    context.read<ReportsCubit>().loadOperations(
          from: _from?.toIso8601String().split('T').first,
          to: _to?.toIso8601String().split('T').first,
          operationType: _operationType,
          status: _status,
          groupBy: _groupBy,
        );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final opTypeLabels = operationTypeLabels(context);
    final opStatusLabels = operationStatusLabels(context);
    final grpByLabels = groupByLabels(context);

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
                      label: strings.filterOperationType,
                      value: _operationType,
                      options: ReportFilterOptions.operationTypes,
                      labels: opTypeLabels,
                      onChanged: (v) {
                        setState(() => _operationType = v);
                        _apply();
                      },
                    ),
                    ReportDropdownFilter(
                      label: strings.filterStatus,
                      value: _status,
                      options: ReportFilterOptions.operationStatuses,
                      labels: opStatusLabels,
                      onChanged: (v) {
                        setState(() => _status = v);
                        _apply();
                      },
                    ),
                    ReportDropdownFilter(
                      label: strings.filterGroupBy,
                      value: _groupBy,
                      options: ReportFilterOptions.groupByOptions,
                      labels: grpByLabels,
                      onChanged: (v) {
                        setState(() => _groupBy = v);
                        _apply();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (state.operationsLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: AppLoadingWidget()),
                )
              else if (state.operationsError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ReportErrorView(message: state.operationsError!, onRetry: _apply),
                )
              else if (state.operations != null)
                ReportSectionCard(
                  title: state.operations!.groupBy != null
                      ? strings.operationsGroupedTitle(grpByLabels[state.operations!.groupBy] ?? state.operations!.groupBy!)
                      : strings.operationsTitle,
                  child: state.operations!.operations.isEmpty
                      ? Text(strings.operationsEmpty, style: const TextStyle(fontSize: 13, color: Colors.black54))
                      : Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: state.operations!.operations.entries.map((entry) {
                            final label = opTypeLabels[entry.key] ?? entry.key;
                            final c = entry.value;
                            return Container(
                              width: 230,
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
                                  Text('${opStatusLabels['total'] ?? strings.reportFilterAll}: ${c.total ?? 0}', style: const TextStyle(fontSize: 12)),
                                  Text('${opStatusLabels['completed']}: ${c.completed ?? 0}   ${opStatusLabels['in_progress']}: ${c.inProgress ?? 0}',
                                      style: const TextStyle(fontSize: 12)),
                                  Text('${opStatusLabels['pending']}: ${c.pending ?? 0}   ${opStatusLabels['cancelled']}: ${c.cancelled ?? 0}',
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),
            ],
          ),
        );
      },
    );
  }
}