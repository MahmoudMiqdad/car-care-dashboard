import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/utils/responsive.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/Empty_state.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/features/fuel_provider_management/domain/entities/fuel_provider_management_entity.dart';
import 'package:car_care/features/fuel_provider_management/presentation/cubit/fuel_provider_management_cubit.dart';
import 'package:car_care/features/fuel_provider_management/presentation/cubit/fuel_provider_management_state.dart';

import 'package:car_care/features/fuel_provider_management/presentation/widgets/fuel_provider_widgets.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FuelProviderManagementPage extends StatelessWidget {
  const FuelProviderManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FuelProviderCubit>(
      create: (_) => getIt<FuelProviderCubit>()..loadFuelProviders(),
      child: const _FuelProviderManagementView(),
    );
  }
}

class _FuelProviderManagementView extends StatelessWidget {
  const _FuelProviderManagementView();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isMobile = Responsive.isMobile(context);

    return AdminLayout(
      currentRoute: 'adminFuelProviders',
      title: strings.fuelProvidersPageTitle,
      child: BlocConsumer<FuelProviderCubit, FuelProviderState>(
        listener: (context, state) {
          if (state is FuelProviderError) AppSnackBar.error(context, state.message);
          if (state is FuelProviderActionSuccess) AppSnackBar.success(context, state.message);
        },
        builder: (context, state) {
          final currentFilter = _filterFromState(state);
          final providers = _providersFromState(state);
          final actionLoadingId =
              state is FuelProviderListActionLoading ? state.actionFuelProviderId : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FuelProviderFilterBar(
                        currentFilter: currentFilter,
                        onChanged: (value) => context.read<FuelProviderCubit>().loadFuelProviders(status: value),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: strings.refresh,
                    iconSize: 25,
                    onPressed: () => context.read<FuelProviderCubit>().loadFuelProviders(status: currentFilter),
                    icon: const Icon(Icons.refresh_rounded, color: AppColors.accent),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(child: _buildContent(context, state, providers, actionLoadingId, isMobile)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    FuelProviderState state,
    List<FuelProviderEntity> providers,
    int? actionLoadingId,
    bool isMobile,
  ) {
    if (state is FuelProviderLoading || state is FuelProviderInitial) {
      return const Center(child: AppLoadingWidget());
    }
    if (providers.isEmpty) {
      return const Center(child: EmptyStateWidget());
    }

    final cubit = context.read<FuelProviderCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isMobile) const FuelProviderTableHeader(),
        if (!isMobile) const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final item = providers[index];
              return FuelProviderTableRow(
                fuelProvider: item,
                isActionLoading: actionLoadingId == item.id,
                isMobile: isMobile,
                onViewDetails: () => context.goNamed(
                  'adminFuelProviderDetails',
                  pathParameters: {'id': item.id.toString()},
                ),
                onApprove: () => cubit.approveFuelProvider(item.id!),
                onReject: (reason) => cubit.rejectFuelProvider(item.id!, reason),
                onSuspend: () => cubit.suspendFuelProvider(item.id!),
                onReactivate: () => cubit.reactivateFuelProvider(item.id!),
              );
            },
          ),
        ),
      ],
    );
  }

  String _filterFromState(FuelProviderState state) {
    if (state is FuelProviderListLoaded) return state.currentFilter;
    if (state is FuelProviderListActionLoading) return state.currentFilter;
    if (state is FuelProviderActionSuccess) return state.currentFilter;
    return 'all';
  }

  List<FuelProviderEntity> _providersFromState(FuelProviderState state) {
    if (state is FuelProviderListLoaded) return state.fuelProviders;
    if (state is FuelProviderListActionLoading) return state.fuelProviders;
    if (state is FuelProviderActionSuccess) return state.fuelProviders;
    return const [];
  }
}