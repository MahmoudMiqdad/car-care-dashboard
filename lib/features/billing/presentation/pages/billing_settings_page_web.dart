import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/utils/responsive.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/Empty_state.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/features/billing/domain/entities/billing_entity.dart';
import 'package:car_care/features/billing/presentation/cubit/billing_cubit.dart';
import 'package:car_care/features/billing/presentation/cubit/billing_state.dart';
import 'package:car_care/features/billing/presentation/widgets/billing_setting_widgets.dart';

import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BillingSettingsPageWeb extends StatelessWidget {
  final String? initialProviderType;
  final int? initialProviderId;
  final String? customerName;
  final String? customerAddress;
  final String? customerPhone;

  const BillingSettingsPageWeb({
    super.key,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    this.initialProviderType,
    this.initialProviderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BillingSettingCubit>(
      create: (_) => getIt<BillingSettingCubit>()
        ..loadBillingSettings(
          providerType: initialProviderType,
          providerId: initialProviderId,
        ),
      child: _BillingSettingsPageWebView(
        providerType: initialProviderType,
        providerId: initialProviderId,
        customerName: customerName,
        customerAddress: customerAddress,
        customerPhone: customerPhone,
      ),
    );
  }
}

class _BillingSettingsPageWebView extends StatelessWidget {
  final String? providerType;
  final int? providerId;
  final String? customerName;
  final String? customerAddress;
  final String? customerPhone;

  const _BillingSettingsPageWebView({
    this.providerType,
    this.providerId,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isMobile = Responsive.isMobile(context);

    return AdminLayout(
      currentRoute: 'adminBillingSettings',
      title: strings.billingSettingsPageTitle,
      child: BlocConsumer<BillingSettingCubit, BillingSettingState>(
        listener: (context, state) {
          if (state is BillingSettingError) {
            AppSnackBar.error(context, state.message);
          }
          if (state is BillingSettingActionSuccess) {
            AppSnackBar.success(context, state.message);
          }
        },
        builder: (context, state) {
          final currentFilter = _filterFromState(state);
          final settings = _settingsFromState(state);
          final actionLoadingId =
              state is BillingSettingListActionLoading ? state.actionSettingId : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: BillingSettingFilterBar(
                        currentFilter: currentFilter,
                        onChanged: (value) {
                          context.read<BillingSettingCubit>().loadBillingSettings(
                                isActiveFilter: value,
                                providerType: providerType,
                                providerId: providerId,
                              );
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: strings.refresh,
                    iconSize: 25,
                    onPressed: () {
                      context.read<BillingSettingCubit>().loadBillingSettings(
                            isActiveFilter: currentFilter,
                            providerType: providerType,
                            providerId: providerId,
                          );
                    },
                    icon: const Icon(Icons.refresh_rounded, color: AppColors.accent),
                  ),
                  const SizedBox(width: 6),
                  FilledButton.icon(
                    onPressed: () => context.goNamed(
                      'adminBillingSettingForm',
                      queryParameters: {
                        if (providerType != null) 'provider_type': providerType!,
                        if (providerId != null) 'provider_id': providerId.toString(),
                      },
                    ),
                    icon: const Icon(Icons.add_rounded, size: 20),
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(strings.billingCreateNew, style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(
                child: _buildContent(context, state, settings, actionLoadingId, isMobile),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    BillingSettingState state,
    List<BillingSettingEntity> settings,
    int? actionLoadingId,
    bool isMobile,
  ) {
    if (state is BillingSettingLoading || state is BillingSettingInitial) {
      return const Center(child: AppLoadingWidget());
    }

    if (settings.isEmpty) {
      return const Center(child: EmptyStateWidget());
    }

    final cubit = context.read<BillingSettingCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isMobile) const BillingSettingTableHeader(),
        if (!isMobile) const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: settings.length,
            itemBuilder: (context, index) {
              final item = settings[index];
              return BillingSettingTableRow(
                setting: item,
                isActionLoading: actionLoadingId == item.id,
                isMobile: isMobile,
                customerName: customerName,
                customerAddress: customerAddress,
                customerPhone: customerPhone,
                onView: () => context.goNamed(
                  'adminBillingSettingDetails',
                  queryParameters: {'id': item.id.toString()},
                ),
                onEdit: () => context.goNamed(
                  'adminBillingSettingEdit',
                  pathParameters: {'id': item.id.toString()},
                ),
                onDelete: () => cubit.deleteBillingSetting(item.id!),
              );
            },
          ),
        ),
      ],
    );
  }

  String _filterFromState(BillingSettingState state) {
    if (state is BillingSettingListLoaded) return state.isActiveFilter;
    if (state is BillingSettingListActionLoading) return state.isActiveFilter;
    if (state is BillingSettingActionSuccess) return state.isActiveFilter;
    return 'all';
  }

  List<BillingSettingEntity> _settingsFromState(BillingSettingState state) {
    if (state is BillingSettingListLoaded) return state.settings;
    if (state is BillingSettingListActionLoading) return state.settings;
    if (state is BillingSettingActionSuccess) return state.settings;
    return const [];
  }
}