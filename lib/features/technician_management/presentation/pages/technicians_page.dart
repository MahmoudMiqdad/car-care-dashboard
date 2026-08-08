import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/utils/responsive.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/features/technician_management/presentation/widgets/technician_widgets.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/core/widgets/Empty_state.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/technician_management/domain/entities/technician_entity.dart';
import 'package:car_care/features/technician_management/presentation/cubit/technician_cubit.dart';
import 'package:car_care/features/technician_management/presentation/cubit/technician_state.dart';

class TechniciansPageWeb extends StatelessWidget {
  const TechniciansPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TechnicianCubit>(
      create: (_) => getIt<TechnicianCubit>()..loadTechnicians(),
      child: const _TechniciansPageWebView(),
    );
  }
}

class _TechniciansPageWebView extends StatelessWidget {
  const _TechniciansPageWebView();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isMobile = Responsive.isMobile(context);

    return AdminLayout(
      currentRoute: 'adminTechnicians',
      title: strings.techniciansPageTitle,
      child: BlocConsumer<TechnicianCubit, TechnicianState>(
        listener: (context, state) {
          if (state is TechnicianError) {
            AppSnackBar.error(context, state.message);
          }
          if (state is TechnicianActionSuccess) {
            AppSnackBar.success(context, state.message);
          }
        },
        builder: (context, state) {
          final currentFilter = _filterFromState(state);
          final technicians = _techniciansFromState(state);
          final actionLoadingId =
              state is TechnicianListActionLoading ? state.actionTechnicianId : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: TechnicianFilterBar(
                        currentFilter: currentFilter,
                        onChanged: (value) {
                          context.read<TechnicianCubit>().loadTechnicians(status: value);
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: strings.refresh,
                    iconSize: 25,
                    onPressed: () {
                      context.read<TechnicianCubit>().loadTechnicians(status: currentFilter);
                    },
                    icon: const Icon(Icons.refresh_rounded, color: AppColors.accent),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(
                child: _buildContent(context, state, technicians, actionLoadingId, isMobile),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    TechnicianState state,
    List<TechnicianEntity> technicians,
    int? actionLoadingId,
    bool isMobile,
  ) {
    if (state is TechnicianLoading || state is TechnicianInitial) {
      return const Center(child: AppLoadingWidget());
    }

    if (technicians.isEmpty) {
      return const Center(child: EmptyStateWidget());
    }

    final cubit = context.read<TechnicianCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isMobile) const TechnicianTableHeader(),
        if (!isMobile) const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: technicians.length,
            itemBuilder: (context, index) {
              final tech = technicians[index];
              return TechnicianTableRow(
                technician: tech,
                isActionLoading: actionLoadingId == tech.id,
                isMobile: isMobile,
                onViewDetails: () => context.goNamed(
                  'adminTechnicianDetails',
                  pathParameters: {'id': tech.id.toString()},
                ),
                onApprove: () => cubit.approveTechnician(tech.id!),
                onReject: (reason) => cubit.rejectTechnician(tech.id!, reason),
                onSuspend: () => cubit.suspendTechnician(tech.id!),
                onReactivate: () => cubit.reactivateTechnician(tech.id!),
              );
            },
          ),
        ),
      ],
    );
  }

  String _filterFromState(TechnicianState state) {
    if (state is TechnicianListLoaded) return state.currentFilter;
    if (state is TechnicianListActionLoading) return state.currentFilter;
    if (state is TechnicianActionSuccess) return state.currentFilter;
    return 'all';
  }

  List<TechnicianEntity> _techniciansFromState(TechnicianState state) {
    if (state is TechnicianListLoaded) return state.technicians;
    if (state is TechnicianListActionLoading) return state.technicians;
    if (state is TechnicianActionSuccess) return state.technicians;
    return const [];
  }
}