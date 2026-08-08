// lib/features/reports/presentation/pages/reports_page.dart
import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:car_care/features/reports/presentation/widgets/tabs/advertisements_tab.dart';
import 'package:car_care/features/reports/presentation/widgets/tabs/billing_tab.dart';
import 'package:car_care/features/reports/presentation/widgets/tabs/financial_tab.dart';
import 'package:car_care/features/reports/presentation/widgets/tabs/operations_tab.dart';
import 'package:car_care/features/reports/presentation/widgets/tabs/overview_tab.dart';
import 'package:car_care/features/reports/presentation/widgets/tabs/providers_tab.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportsCubit>(
      create: (_) => getIt<ReportsCubit>(),
      child: const _ReportsPageView(),
    );
  }
}

class _ReportsPageView extends StatefulWidget {
  const _ReportsPageView();

  @override
  State<_ReportsPageView> createState() => _ReportsPageViewState();
}

class _ReportsPageViewState extends State<_ReportsPageView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final tabs = [
      strings.tabOverview,
      strings.operationsTitle,
      strings.tabProviders,
      strings.tabFinancial,
      strings.tabBilling,
      strings.tabAdvertisements,
    ];

    return AdminLayout(
      currentRoute: 'adminReports',
      title: strings.reportsPageTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              unselectedLabelStyle: const TextStyle(fontSize: 13),
              tabs: tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                OverviewTab(),
                OperationsTab(),
                ProvidersTab(),
                FinancialTab(),
                BillingTab(),
                AdvertisementsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}