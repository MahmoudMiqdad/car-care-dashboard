import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/core/widgets/loding.dart';

import 'package:car_care/features/shop_management/domain/entities/shop_management_entity.dart';

import 'package:car_care/features/shop_management/presentation/cubit/shop_management_cubit.dart';
import 'package:car_care/features/shop_management/presentation/cubit/shop_management_state.dart';
import 'package:car_care/features/shop_management/presentation/widgets/shop_widgets.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShopDetailsPageWeb extends StatelessWidget {
  final int shopId;
  const ShopDetailsPageWeb({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
      create: (_) => getIt<ShopCubit>()..loadShopDetails(shopId),
      child: _ShopDetailsView(shopId: shopId),
    );
  }
}

class _ShopDetailsView extends StatefulWidget {
  final int shopId;
  const _ShopDetailsView({required this.shopId});

  @override
  State<_ShopDetailsView> createState() => _ShopDetailsViewState();
}

class _ShopDetailsViewState extends State<_ShopDetailsView> {
  ShopEntity? _shop;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AdminLayout(
      currentRoute: 'adminShops',
      title: _shop?.name ?? strings.shopDetailsTitle,
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if (state is ShopError) AppSnackBar.error(context, state.message);
          if (state is ShopDetailsLoaded) setState(() => _shop = state.shop);
          if (state is ShopActionSuccess && state.shop.id == widget.shopId) {
            setState(() => _shop = state.shop);
            AppSnackBar.success(context, state.message);
          }
        },
        builder: (context, state) {
          final isActionLoading =
              state is ShopListActionLoading && state.actionShopId == widget.shopId;

          final shop = _shop;
          if (shop == null) return const Center(child: AppLoadingWidget());

          return _DetailsBody(
            shop: shop,
            isActionLoading: isActionLoading,
            onBack: () => context.canPop() ? context.pop() : context.goNamed('adminShops'),
            onApprove: () => context.read<ShopCubit>().approveShop(widget.shopId),
            onReject: (reason) => context.read<ShopCubit>().rejectShop(widget.shopId, reason),
            onSuspend: () => context.read<ShopCubit>().suspendShop(widget.shopId),
            onReactivate: () => context.read<ShopCubit>().reactivateShop(widget.shopId),
          );
        },
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  final ShopEntity shop;
  final bool isActionLoading;
  final VoidCallback onBack;
  final VoidCallback onApprove;
  final void Function(String reason) onReject;
  final VoidCallback onSuspend;
  final VoidCallback onReactivate;

  const _DetailsBody({
    required this.shop,
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
                      shop.name ?? strings.shopDetailsTitle,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ShopStatusBadge(status: shop.status),
                ],
              ),
              const SizedBox(height: 20),
              _InfoCard(shop: shop),
              const SizedBox(height: 16),
              _BusinessInfoCard(shop: shop),
              const SizedBox(height: 24),
              _BottomActionsBar(
                shop: shop,
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
  final ShopEntity shop;
  const _InfoCard({required this.shop});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    final rows = <MapEntry<String, String?>>[
      MapEntry(strings.detailsId, shop.id?.toString()),
      MapEntry(strings.detailsEmail, shop.owner?.email),
      MapEntry(strings.detailsPhone, shop.phone),
      MapEntry(strings.detailsCity, shop.city),
      MapEntry(strings.detailsAvailable,
          shop.isActive == null ? null : (shop.isActive! ? strings.detailsYes : strings.detailsNo)),
      MapEntry(strings.detailsStatus, _statusLabel(strings, shop.status)),
      if (shop.status == 'rejected') MapEntry(strings.detailsRejectionReason, shop.rejectionReason),
      MapEntry(strings.detailsApprovedAt, shop.approvedAt),
      MapEntry(strings.detailsRejectedAt, shop.rejectedAt),
      MapEntry(strings.detailsSuspendedAt, shop.suspendedAt),
      MapEntry(strings.detailsCreatedAt, shop.createdAt),
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

class _BusinessInfoCard extends StatelessWidget {
  final ShopEntity shop;
  const _BusinessInfoCard({required this.shop});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    if (shop.businessTypes.isEmpty && shop.carBrands.isEmpty && shop.partCategories.isEmpty) {
      return const SizedBox.shrink();
    }

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (shop.businessTypes.isNotEmpty) ...[
            Text(strings.detailsBusinessTypes,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 18)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: shop.businessTypes
                  .map((t) => Chip(label: Text(t, style: const TextStyle(fontSize: 13))))
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],
          if (shop.carBrands.isNotEmpty) ...[
            Text(strings.detailsCarBrands,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 18)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: shop.carBrands
                  .map((b) => Chip(label: Text(b, style: const TextStyle(fontSize: 13))))
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],
          if (shop.partCategories.isNotEmpty) ...[
            Text(strings.detailsPartCategories,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 18)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: shop.partCategories
                  .map((c) => Chip(label: Text(c, style: const TextStyle(fontSize: 13))))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _BottomActionsBar extends StatelessWidget {
  final ShopEntity shop;
  final bool isLoading;
  final VoidCallback onApprove;
  final void Function(String) onReject;
  final VoidCallback onSuspend;
  final VoidCallback onReactivate;

  const _BottomActionsBar({
    required this.shop,
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
    switch (shop.status) {
      case 'pending':
        buttons.add(_btn(strings.actionApprove, const Color(0xFF2E7D32), onApprove));
        buttons.add(_btn(strings.actionReject, const Color(0xFFC62828), () async {
          final reason = await showShopRejectDialog(context);
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