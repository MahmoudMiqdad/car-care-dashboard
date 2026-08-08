
import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/core/widgets/loding.dart';

import 'package:car_care/features/fuel_provider_management/domain/entities/fuel_provider_management_entity.dart';

import 'package:car_care/features/fuel_provider_management/presentation/cubit/fuel_provider_management_cubit.dart';
import 'package:car_care/features/fuel_provider_management/presentation/cubit/fuel_provider_management_state.dart';

import 'package:car_care/features/fuel_provider_management/presentation/widgets/fuel_provider_widgets.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FuelProviderDetailsPageWeb extends StatelessWidget {
  final int fuelProviderId;
  const FuelProviderDetailsPageWeb({super.key, required this.fuelProviderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FuelProviderCubit>(
      create: (_) => getIt<FuelProviderCubit>()..loadFuelProviderDetails(fuelProviderId),
      child: _FuelProviderDetailsView(fuelProviderId: fuelProviderId),
    );
  }
}

class _FuelProviderDetailsView extends StatefulWidget {
  final int fuelProviderId;
  const _FuelProviderDetailsView({required this.fuelProviderId});

  @override
  State<_FuelProviderDetailsView> createState() => _FuelProviderDetailsViewState();
}

class _FuelProviderDetailsViewState extends State<_FuelProviderDetailsView> {
  FuelProviderEntity? _provider;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AdminLayout(
      currentRoute: 'adminFuelProviders',
      title: _provider?.companyName ?? strings.fuelProviderDetailsTitle,
      child: BlocConsumer<FuelProviderCubit, FuelProviderState>(
        listener: (context, state) {
          if (state is FuelProviderError) AppSnackBar.error(context, state.message);
          if (state is FuelProviderDetailsLoaded) setState(() => _provider = state.fuelProvider);
          if (state is FuelProviderActionSuccess && state.fuelProvider.id == widget.fuelProviderId) {
            setState(() => _provider = state.fuelProvider);
            AppSnackBar.success(context, state.message);
          }
        },
        builder: (context, state) {
          final isActionLoading = state is FuelProviderListActionLoading &&
              state.actionFuelProviderId == widget.fuelProviderId;

          final provider = _provider;
          if (provider == null) return const Center(child: AppLoadingWidget());

          return _DetailsBody(
            provider: provider,
            isActionLoading: isActionLoading,
            onBack: () => context.canPop() ? context.pop() : context.goNamed('adminFuelProviders'),
            onApprove: () => context.read<FuelProviderCubit>().approveFuelProvider(widget.fuelProviderId),
            onReject: (reason) =>
                context.read<FuelProviderCubit>().rejectFuelProvider(widget.fuelProviderId, reason),
            onSuspend: () => context.read<FuelProviderCubit>().suspendFuelProvider(widget.fuelProviderId),
            onReactivate: () =>
                context.read<FuelProviderCubit>().reactivateFuelProvider(widget.fuelProviderId),
          );
        },
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  final FuelProviderEntity provider;
  final bool isActionLoading;
  final VoidCallback onBack;
  final VoidCallback onApprove;
  final void Function(String reason) onReject;
  final VoidCallback onSuspend;
  final VoidCallback onReactivate;

  const _DetailsBody({
    required this.provider,
    required this.isActionLoading,
    required this.onBack,
    required this.onApprove,
    required this.onReject,
    required this.onSuspend,
    required this.onReactivate,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1500),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back_rounded, size: 20)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      provider.companyName ?? strings.fuelProviderDetailsTitle,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  FuelProviderStatusBadge(status: provider.status),
                ],
              ),
              const SizedBox(height: 20),
              _InfoCard(provider: provider),
              const SizedBox(height: 16),
              _FuelInfoCard(provider: provider),
              const SizedBox(height: 24),
              _BottomActionsBar(
                provider: provider,
                isLoading: isActionLoading,
                onApprove: onApprove,
                onReject: onReject,
                onSuspend: onSuspend,
                onReactivate: onReactivate,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final FuelProviderEntity provider;
  const _InfoCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    final rows = <MapEntry<String, String?>>[
      MapEntry(strings.detailsId, provider.id?.toString()),
      MapEntry(strings.detailsEmail, provider.user?.email),
      MapEntry(strings.detailsPhone, provider.phone),
      MapEntry(strings.detailsCity, provider.city),
      MapEntry(strings.detailsAddress, provider.address),
      MapEntry(strings.detailsAvailable,
          provider.isAvailable == null ? null : (provider.isAvailable! ? strings.detailsYes : strings.detailsNo)),
      MapEntry(strings.detailsStatus, _statusLabel(strings, provider.status)),
      if (provider.status == 'rejected') MapEntry(strings.detailsRejectionReason, provider.rejectionReason),
      MapEntry(strings.detailsApprovedAt, provider.approvedAt),
      MapEntry(strings.detailsRejectedAt, provider.rejectedAt),
      MapEntry(strings.detailsSuspendedAt, provider.suspendedAt),
      MapEntry(strings.detailsCreatedAt, provider.createdAt),
    ].where((e) => e.value != null && e.value!.isNotEmpty).toList();

    return _Card(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 560;
          return Wrap(
            runSpacing: 10,
            children: rows.map((e) {
              return SizedBox(
                width: isWide ? constraints.maxWidth / 2 - 8 : constraints.maxWidth,
                child: _InfoRow(label: e.key, value: e.value!),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  String _statusLabel(dynamic strings, String? status) {
    switch (status) {
      case 'approved':
        return strings.statusApproved;
      case 'rejected':
        return strings.statusRejected;
      case 'suspended':
        return strings.statusSuspended;
      case 'pending':
      default:
        return strings.statusPending;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text('$label  :',
                style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, fontSize: 18)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

class _FuelInfoCard extends StatelessWidget {
  final FuelProviderEntity provider;
  const _FuelInfoCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    if (provider.fuelTypes.isEmpty && provider.prices.isEmpty &&
        provider.latitude == null && provider.longitude == null) {
      return const SizedBox.shrink();
    }

    return _Card(
      title: strings.detailsFuelTypes,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (provider.fuelTypes.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: provider.fuelTypes
                  .map((f) => Chip(label: Text(f, style: const TextStyle(fontSize: 13))))
                  .toList(),
            ),
          if (provider.prices.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(strings.detailsPrices,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: provider.prices.entries
                  .map((e) => Text('${e.key}: ${e.value}', style: const TextStyle(fontSize: 14)))
                  .toList(),
            ),
          ],
          if (provider.latitude != null && provider.longitude != null) ...[
            const SizedBox(height: 14),
            Text('${strings.detailsLocation}: ${provider.latitude}, ${provider.longitude}',
                style: const TextStyle(fontSize: 14)),
          ],
        ],
      ),
    );
  }
}

class _BottomActionsBar extends StatelessWidget {
  final FuelProviderEntity provider;
  final bool isLoading;
  final VoidCallback onApprove;
  final void Function(String) onReject;
  final VoidCallback onSuspend;
  final VoidCallback onReactivate;

  const _BottomActionsBar({
    required this.provider,
    required this.isLoading,
    required this.onApprove,
    required this.onReject,
    required this.onSuspend,
    required this.onReactivate,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    if (isLoading) return const Center(child: CircularProgressIndicator());

    final buttons = <Widget>[];
    switch (provider.status) {
      case 'pending':
        buttons.add(_btn(strings.actionApprove, const Color(0xFF2E7D32), onApprove));
        buttons.add(_btn(strings.actionReject, const Color(0xFFC62828), () async {
          final reason = await showFuelProviderRejectDialog(context);
          if (reason != null) onReject(reason);
        }));
        break;
      case 'approved':
        buttons.add(_btn(strings.actionSuspend, const Color(0xFF616161), onSuspend));
        break;
      case 'suspended':
        buttons.add(_btn(strings.actionReactivate, const Color(0xFF2E7D32), onReactivate));
        break;
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Wrap(spacing: 10, runSpacing: 10, alignment: WrapAlignment.center, children: buttons),
    );
  }

  Widget _btn(String text, Color color, VoidCallback onTap) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text, style: const TextStyle(fontSize: 25)),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String? title;
  final Widget child;
  const _Card({this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black)),
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );
  }
}