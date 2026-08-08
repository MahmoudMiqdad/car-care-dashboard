import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:car_care/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:car_care/features/dashboard/presentation/widgets/dashboard_charts.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPageWeb extends StatelessWidget {
  const DashboardPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (_) => getIt<DashboardCubit>()..loadDashboard(),
      child: const _DashboardPageWebView(),
    );
  }
}

class _DashboardPageWebView extends StatefulWidget {
  const _DashboardPageWebView();

  @override
  State<_DashboardPageWebView> createState() => _DashboardPageWebViewState();
}

class _DashboardPageWebViewState extends State<_DashboardPageWebView> {
  String? _opsFrom;
  String? _opsTo;
  String? _revFrom;
  String? _revTo;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AdminLayout(
      currentRoute: 'adminDashboard',
      title: strings.dashboardPageTitle,
      child: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state is DashboardError) {
            AppSnackBar.error(context, state.message);
          }
          if (state is DashboardLoaded) {
            _opsFrom = state.operationsFrom;
            _opsTo = state.operationsTo;
            _revFrom = state.revenueFrom;
            _revTo = state.revenueTo;
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading || state is DashboardInitial) {
            return const Center(child: AppLoadingWidget());
          }

          final loaded = state is DashboardLoaded
              ? state
              : state is DashboardSectionUpdating
                  ? state.previous
                  : null;

          if (loaded == null) {
            return Center(
              child: FilledButton(
                onPressed: () => context.read<DashboardCubit>().loadDashboard(),
                child: Text(strings.refresh),
              ),
            );
          }

          final isOperationsUpdating =
              state is DashboardSectionUpdating && state.section == DashboardUpdatingSection.operations;
          final isRevenueUpdating =
              state is DashboardSectionUpdating && state.section == DashboardUpdatingSection.revenue;

          final summary = loaded.summary;

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AdvertisementsStrip(advertisements: loaded.advertisements),
                if (loaded.advertisements.isNotEmpty) const SizedBox(height: 16),

                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    StatMiniCard(
                      label: strings.dashboardTotalUsers,
                      value: '${summary.users?.totalUsers ?? 0}',
                      color: const Color(0xFF1565C0),
                      icon: Icons.people_alt_rounded,
                    ),
                    StatMiniCard(
                      label: strings.dashboardTotalCustomers,
                      value: '${summary.users?.totalCustomers ?? 0}',
                      color: const Color(0xFF6A1B9A),
                      icon: Icons.person_rounded,
                    ),
                    StatMiniCard(
                      label: strings.dashboardCompletedOperations,
                      value: '${summary.operations?.totals?.completedOperations ?? 0}',
                      color: const Color(0xFF2E7D32),
                      icon: Icons.check_circle_rounded,
                    ),
                    StatMiniCard(
                      label: strings.dashboardPendingOperations,
                      value: '${summary.operations?.totals?.pendingOperations ?? 0}',
                      color: const Color(0xFFEF6C00),
                      icon: Icons.pending_actions_rounded,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 900;
                    final providersChart = DashboardCard(
                      title: strings.dashboardProvidersOverview,
                      child: ProvidersBarChart(providers: summary.providers),
                    );
                    final operationsPie = DashboardCard(
                      title: strings.dashboardOperationsStatus,
                      child: OperationsTotalsPieChart(totals: summary.operations?.totals),
                    );

                    if (isWide) {
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(flex: 3, child: providersChart),
                            const SizedBox(width: 16),
                            Expanded(flex: 2, child: operationsPie),
                          ],
                        ),
                      );
                    }

                    return Column(
                      children: [
                        providersChart,
                        const SizedBox(height: 16),
                        operationsPie,
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),

                DashboardCard(
                  title: strings.dashboardOperationsOverTime,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PeriodSelector(
                        currentPeriod: loaded.currentPeriod,
                        isCustomRange: loaded.operationsFrom != null || loaded.operationsTo != null,
                        isLoading: isOperationsUpdating,
                        onChanged: (period) => context.read<DashboardCubit>().changeOperationsPeriod(period),
                      ),
                      const SizedBox(height: 12),
                      DashboardDateRangeFilter(
                        from: _opsFrom,
                        to: _opsTo,
                        onFromChanged: (v) => setState(() => _opsFrom = v),
                        onToChanged: (v) => setState(() => _opsTo = v),
                        onApply: () => context.read<DashboardCubit>().applyOperationsDateRange(
                              from: _opsFrom,
                              to: _opsTo,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Stack(
                        children: [
                          OperationsTimeSeriesLineChart(operations: loaded.operations),
                          if (isOperationsUpdating)
                            Positioned.fill(
                              child: Container(
                                color: Colors.white.withOpacity(0.6),
                                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                DashboardCard(
                  title: strings.dashboardRevenue,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DashboardDateRangeFilter(
                        from: _revFrom,
                        to: _revTo,
                        onFromChanged: (v) => setState(() => _revFrom = v),
                        onToChanged: (v) => setState(() => _revTo = v),
                        onApply: () => context.read<DashboardCubit>().applyRevenueDateRange(
                              from: _revFrom,
                              to: _revTo,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Stack(
                        children: [
                          RevenueBreakdownChart(revenue: loaded.revenue),
                          if (isRevenueUpdating)
                            Positioned.fill(
                              child: Container(
                                color: Colors.white.withOpacity(0.6),
                                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
class _PeriodSelector extends StatelessWidget {
  final String currentPeriod;
  final bool isCustomRange;
  final bool isLoading;
  final ValueChanged<String> onChanged;

  const _PeriodSelector({
    required this.currentPeriod,
    required this.isCustomRange,
    required this.isLoading,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final periods = <String, String>{
      'week': strings.dashboardPeriodWeek,
      'month': strings.dashboardPeriodMonth,
      'year': strings.dashboardPeriodYear,
    };

    return Wrap(
      spacing: 8,
      children: periods.entries.map((entry) {
        final selected = !isCustomRange && entry.key == currentPeriod;
        return ChoiceChip(
          label: Text(entry.value),
          selected: selected,
          onSelected: isLoading ? null : (_) => onChanged(entry.key),
          labelStyle: TextStyle(
            fontSize: 13,
            color: selected ? Colors.white : AppColors.black,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
          selectedColor: AppColors.primary,
          backgroundColor: AppColors.primary.withOpacity(0.08),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        );
      }).toList(),
    );
  }
}