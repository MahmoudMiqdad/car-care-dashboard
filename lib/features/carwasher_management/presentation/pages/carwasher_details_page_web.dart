import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/carwasher_management/domain/entities/carwasher_management_entity.dart';
import 'package:car_care/features/carwasher_management/presentation/cubit/carwasher_management_cubit.dart';
import 'package:car_care/features/carwasher_management/presentation/cubit/carwasher_management_state.dart';

import 'package:car_care/features/carwasher_management/presentation/widgets/carwasher_widgets.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CarwasherDetailsPageWeb extends StatelessWidget {
  final int carwasherId;
  const CarwasherDetailsPageWeb({super.key, required this.carwasherId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarwasherCubit>(
      create: (_) => getIt<CarwasherCubit>()..loadCarwasherDetails(carwasherId),
      child: _CarwasherDetailsView(carwasherId: carwasherId),
    );
  }
}

class _CarwasherDetailsView extends StatefulWidget {
  final int carwasherId;
  const _CarwasherDetailsView({required this.carwasherId});

  @override
  State<_CarwasherDetailsView> createState() => _CarwasherDetailsViewState();
}

class _CarwasherDetailsViewState extends State<_CarwasherDetailsView> {
  CarwasherEntity? _carwasher;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AdminLayout(
      currentRoute: 'adminCarwashers',
      title: _carwasher?.shopName ?? strings.carwasherDetailsTitle,
      child: BlocConsumer<CarwasherCubit, CarwasherState>(
        listener: (context, state) {
          if (state is CarwasherError) AppSnackBar.error(context, state.message);
          if (state is CarwasherDetailsLoaded) setState(() => _carwasher = state.carwasher);
          if (state is CarwasherActionSuccess && state.carwasher.id == widget.carwasherId) {
            setState(() => _carwasher = state.carwasher);
            AppSnackBar.success(context, state.message);
          }
        },
        builder: (context, state) {
          final isActionLoading =
              state is CarwasherListActionLoading && state.actionCarwasherId == widget.carwasherId;

          final carwasher = _carwasher;
          if (carwasher == null) return const Center(child: AppLoadingWidget());

          return _DetailsBody(
            carwasher: carwasher,
            isActionLoading: isActionLoading,
            onBack: () => context.canPop() ? context.pop() : context.goNamed('adminCarwashers'),
            onApprove: () => context.read<CarwasherCubit>().approveCarwasher(widget.carwasherId),
            onReject: (reason) => context.read<CarwasherCubit>().rejectCarwasher(widget.carwasherId, reason),
            onSuspend: () => context.read<CarwasherCubit>().suspendCarwasher(widget.carwasherId),
            onReactivate: () => context.read<CarwasherCubit>().reactivateCarwasher(widget.carwasherId),
          );
        },
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  final CarwasherEntity carwasher;
  final bool isActionLoading;
  final VoidCallback onBack;
  final VoidCallback onApprove;
  final void Function(String reason) onReject;
  final VoidCallback onSuspend;
  final VoidCallback onReactivate;

  const _DetailsBody({
    required this.carwasher,
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
                      carwasher.shopName ?? strings.carwasherDetailsTitle,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CarwasherStatusBadge(status: carwasher.status),
                ],
              ),
              const SizedBox(height: 20),
              _InfoCard(carwasher: carwasher),
              const SizedBox(height: 16),
              _ServicesCard(carwasher: carwasher),
              const SizedBox(height: 24),
              _BottomActionsBar(
                carwasher: carwasher,
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
  final CarwasherEntity carwasher;
  const _InfoCard({required this.carwasher});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    final rows = <MapEntry<String, String?>>[
      MapEntry(strings.detailsId, carwasher.id?.toString()),
      MapEntry(strings.detailsEmail, carwasher.user?.email),
      MapEntry(strings.detailsPhone, carwasher.phone),
      MapEntry(strings.detailsCity, carwasher.city),
      MapEntry(strings.detailsAddress, carwasher.address),
      MapEntry(strings.detailsDescription, carwasher.description),
      MapEntry(strings.detailsAvailable,
          carwasher.isAvailable == null ? null : (carwasher.isAvailable! ? strings.detailsYes : strings.detailsNo)),
      MapEntry(strings.detailsRating,
          carwasher.ratingStars != null ? '${carwasher.ratingStars} (${carwasher.ratingsCount ?? 0})' : null),
      MapEntry(strings.detailsStatus, _statusLabel(strings, carwasher.status)),
      if (carwasher.status == 'rejected') MapEntry(strings.detailsRejectionReason, carwasher.rejectionReason),
      MapEntry(strings.detailsApprovedAt, carwasher.approvedAt),
      MapEntry(strings.detailsRejectedAt, carwasher.rejectedAt),
      MapEntry(strings.detailsSuspendedAt, carwasher.suspendedAt),
      MapEntry(strings.detailsCreatedAt, carwasher.createdAt),
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

class _ServicesCard extends StatelessWidget {
  final CarwasherEntity carwasher;
  const _ServicesCard({required this.carwasher});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return _Card(
      title: strings.detailsServices,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: carwasher.services
                .map((s) => Chip(label: Text(s, style: const TextStyle(fontSize: 13))))
                .toList(),
          ),
          if (carwasher.servicePrices.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(strings.detailsServicePrices,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black,fontSize: 25)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: carwasher.servicePrices.entries
                  .map((e) => Text('${e.key}: ${e.value}', style: const TextStyle(fontSize: 10)))
                  .toList(),
            ),
          ],
          if (carwasher.workingHours.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(strings.detailsWorkingHours,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black,fontSize: 25)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: carwasher.workingHours.entries
                  .map((e) => Text('${e.key}: ${e.value}', style: const TextStyle(fontSize: 10)))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _BottomActionsBar extends StatelessWidget {
  final CarwasherEntity carwasher;
  final bool isLoading;
  final VoidCallback onApprove;
  final void Function(String) onReject;
  final VoidCallback onSuspend;
  final VoidCallback onReactivate;

  const _BottomActionsBar({
    required this.carwasher,
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
    switch (carwasher.status) {
      case 'pending':
        buttons.add(_btn(strings.actionApprove, const Color(0xFF2E7D32), onApprove));
        buttons.add(_btn(strings.actionReject, const Color(0xFFC62828), () async {
          final reason = await showCarwasherRejectDialog(context);
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