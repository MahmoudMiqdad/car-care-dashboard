import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/utils/responsive.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/Empty_state.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/features/carwasher_management/domain/entities/carwasher_management_entity.dart';
import 'package:car_care/features/carwasher_management/presentation/cubit/carwasher_management_cubit.dart';
import 'package:car_care/features/carwasher_management/presentation/cubit/carwasher_management_state.dart';

import 'package:car_care/features/carwasher_management/presentation/widgets/carwasher_widgets.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CarwasherManagementPage extends StatelessWidget {
  const CarwasherManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarwasherCubit>(
      create: (_) => getIt<CarwasherCubit>()..loadCarwashers(),
      child: const _CarwasherManagementView(),
    );
  }
}

class _CarwasherManagementView extends StatelessWidget {
  const _CarwasherManagementView();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isMobile = Responsive.isMobile(context);

    return AdminLayout(
      currentRoute: 'adminCarwashers',
      title: strings.carwashersPageTitle,
      child: BlocConsumer<CarwasherCubit, CarwasherState>(
        listener: (context, state) {
          if (state is CarwasherError) AppSnackBar.error(context, state.message);
          if (state is CarwasherActionSuccess) AppSnackBar.success(context, state.message);
        },
        builder: (context, state) {
          final currentFilter = _filterFromState(state);
          final carwashers = _carwashersFromState(state);
          final actionLoadingId = state is CarwasherListActionLoading ? state.actionCarwasherId : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: CarwasherFilterBar(
                        currentFilter: currentFilter,
                        onChanged: (value) => context.read<CarwasherCubit>().loadCarwashers(status: value),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: strings.refresh,
                    iconSize: 25,
                    onPressed: () => context.read<CarwasherCubit>().loadCarwashers(status: currentFilter),
                    icon: const Icon(Icons.refresh_rounded, color: AppColors.accent),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(child: _buildContent(context, state, carwashers, actionLoadingId, isMobile)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    CarwasherState state,
    List<CarwasherEntity> carwashers,
    int? actionLoadingId,
    bool isMobile,
  ) {
    if (state is CarwasherLoading || state is CarwasherInitial) {
      return const Center(child: AppLoadingWidget());
    }
    if (carwashers.isEmpty) {
      return const Center(child: EmptyStateWidget());
    }

    final cubit = context.read<CarwasherCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isMobile) const CarwasherTableHeader(),
        if (!isMobile) const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: carwashers.length,
            itemBuilder: (context, index) {
              final item = carwashers[index];
              return CarwasherTableRow(
                carwasher: item,
                isActionLoading: actionLoadingId == item.id,
                isMobile: isMobile,
                onViewDetails: () => context.goNamed(
                  'adminCarwasherDetails',
                  pathParameters: {'id': item.id.toString()},
                ),
                onApprove: () => cubit.approveCarwasher(item.id!),
                onReject: (reason) => cubit.rejectCarwasher(item.id!, reason),
                onSuspend: () => cubit.suspendCarwasher(item.id!),
                onReactivate: () => cubit.reactivateCarwasher(item.id!),
              );
            },
          ),
        ),
      ],
    );
  }

  String _filterFromState(CarwasherState state) {
    if (state is CarwasherListLoaded) return state.currentFilter;
    if (state is CarwasherListActionLoading) return state.currentFilter;
    if (state is CarwasherActionSuccess) return state.currentFilter;
    return 'all';
  }

  List<CarwasherEntity> _carwashersFromState(CarwasherState state) {
    if (state is CarwasherListLoaded) return state.carwashers;
    if (state is CarwasherListActionLoading) return state.carwashers;
    if (state is CarwasherActionSuccess) return state.carwashers;
    return const [];
  }
}