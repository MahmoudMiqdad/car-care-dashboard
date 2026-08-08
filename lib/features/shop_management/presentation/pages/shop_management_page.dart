import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/utils/responsive.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/Empty_state.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/features/shop_management/domain/entities/shop_management_entity.dart';
import 'package:car_care/features/shop_management/presentation/cubit/shop_management_cubit.dart';
import 'package:car_care/features/shop_management/presentation/cubit/shop_management_state.dart';

import 'package:car_care/features/shop_management/presentation/widgets/shop_widgets.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShopManagementPage extends StatelessWidget {
  const ShopManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
      create: (_) => getIt<ShopCubit>()..loadShops(),
      child: const _ShopManagementView(),
    );
  }
}

class _ShopManagementView extends StatelessWidget {
  const _ShopManagementView();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isMobile = Responsive.isMobile(context);

    return AdminLayout(
      currentRoute: 'adminShops',
      title: strings.shopsPageTitle,
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if (state is ShopError) AppSnackBar.error(context, state.message);
          if (state is ShopActionSuccess) AppSnackBar.success(context, state.message);
        },
        builder: (context, state) {
          final currentFilter = _filterFromState(state);
          final shops = _shopsFromState(state);
          final actionLoadingId = state is ShopListActionLoading ? state.actionShopId : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ShopFilterBar(
                        currentFilter: currentFilter,
                        onChanged: (value) => context.read<ShopCubit>().loadShops(status: value),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: strings.refresh,
                    iconSize: 25,
                    onPressed: () => context.read<ShopCubit>().loadShops(status: currentFilter),
                    icon: const Icon(Icons.refresh_rounded, color: AppColors.accent),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(child: _buildContent(context, state, shops, actionLoadingId, isMobile)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ShopState state,
    List<ShopEntity> shops,
    int? actionLoadingId,
    bool isMobile,
  ) {
    if (state is ShopLoading || state is ShopInitial) {
      return const Center(child: AppLoadingWidget());
    }
    if (shops.isEmpty) {
      return const Center(child: EmptyStateWidget());
    }

    final cubit = context.read<ShopCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isMobile) const ShopTableHeader(),
        if (!isMobile) const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: shops.length,
            itemBuilder: (context, index) {
              final item = shops[index];
              return ShopTableRow(
                shop: item,
                isActionLoading: actionLoadingId == item.id,
                isMobile: isMobile,
                onViewDetails: () => context.goNamed(
                  'adminShopDetails',
                  pathParameters: {'id': item.id.toString()},
                ),
                onApprove: () => cubit.approveShop(item.id!),
                onReject: (reason) => cubit.rejectShop(item.id!, reason),
                onSuspend: () => cubit.suspendShop(item.id!),
                onReactivate: () => cubit.reactivateShop(item.id!),
              );
            },
          ),
        ),
      ],
    );
  }

  String _filterFromState(ShopState state) {
    if (state is ShopListLoaded) return state.currentFilter;
    if (state is ShopListActionLoading) return state.currentFilter;
    if (state is ShopActionSuccess) return state.currentFilter;
    return 'all';
  }

  List<ShopEntity> _shopsFromState(ShopState state) {
    if (state is ShopListLoaded) return state.shops;
    if (state is ShopListActionLoading) return state.shops;
    if (state is ShopActionSuccess) return state.shops;
    return const [];
  }
}