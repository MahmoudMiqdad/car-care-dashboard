import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/carwasher_management/domain/entities/carwasher_management_entity.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


Future<String?> showCarwasherRejectDialog(BuildContext context) async {
  final strings = context.l10n;
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(strings.rejectDialogTitle, style: const TextStyle(fontSize: 20)),
      content: TextField(
        controller: controller,
        maxLines: 3,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: strings.rejectDialogHint,
          hintStyle: const TextStyle(fontSize: 15),
          border: const OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(strings.cancel, style: const TextStyle(fontSize: 15)),
        ),
        FilledButton(
          onPressed: () {
            if (controller.text.trim().isEmpty) return;
            Navigator.pop(context, controller.text.trim());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(strings.confirmReject, style: const TextStyle(fontSize: 15)),
          ),
        ),
      ],
    ),
  );
}

class CarwasherFilterBar extends StatelessWidget {
  final String currentFilter;
  final ValueChanged<String> onChanged;

  const CarwasherFilterBar({super.key, required this.currentFilter, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final filters = <String, String>{
      'all': strings.statusAll,
      'pending': strings.statusPending,
      'approved': strings.statusApproved,
      'rejected': strings.statusRejected,
      'suspended': strings.statusSuspended,
    };

    return Wrap(
      spacing: 8,
      children: filters.entries.map((entry) {
        final selected = entry.key == currentFilter;
        return ChoiceChip(
          label: Text(entry.value),
          selected: selected,
          onSelected: (_) => onChanged(entry.key),
          labelPadding: const EdgeInsets.symmetric(horizontal: 4),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
          labelStyle: TextStyle(
            fontSize: 14,
            color: selected ? Theme.of(context).colorScheme.primary : AppColors.white,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
          backgroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        );
      }).toList(),
    );
  }
}

class CarwasherStatusBadge extends StatelessWidget {
  final String? status;
  const CarwasherStatusBadge({super.key, required this.status});

  Color _color() {
    switch (status) {
      case 'approved':
        return const Color(0xFF2E7D32);
      case 'rejected':
        return const Color(0xFFC62828);
      case 'suspended':
        return const Color(0xFF616161);
      case 'pending':
      default:
        return const Color(0xFFEF6C00);
    }
  }

  String _label(BuildContext context) {
    final strings = context.l10n;
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

  @override
  Widget build(BuildContext context) {
    final color = _color();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(16)),
      child: Text(_label(context), style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
    );
  }
}

class CarwasherTableHeader extends StatelessWidget {
  const CarwasherTableHeader({super.key});

  static const _style = TextStyle(fontWeight: FontWeight.w600, color: Colors.black54, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFFF6F7FB), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(strings.columnShop, style: _style)),
          Expanded(flex: 2, child: Text(strings.columnCity, style: _style)),
          Expanded(flex: 2, child: Text(strings.columnPhone, style: _style)),
          Expanded(flex: 2, child: Text(strings.columnStatus, style: _style)),
          Expanded(flex: 3, child: Text(strings.columnActions, style: _style)),
        ],
      ),
    );
  }
}

Widget _btn(String text, Color color, VoidCallback onTap) {
  return SizedBox(
    height: 34,
    child: OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    ),
  );
}

class CarwasherTableRow extends StatelessWidget {
  final CarwasherEntity carwasher;
  final bool isActionLoading;
  final bool isMobile;
  final VoidCallback onViewDetails;
  final VoidCallback onApprove;
  final void Function(String reason) onReject;
  final VoidCallback onSuspend;
  final VoidCallback onReactivate;

  const CarwasherTableRow({
    super.key,
    required this.carwasher,
    required this.isActionLoading,
    this.isMobile = false,
    required this.onViewDetails,
    required this.onApprove,
    required this.onReject,
    required this.onSuspend,
    required this.onReactivate,
  });

  @override
  Widget build(BuildContext context) {
    return isMobile ? _buildMobileCard(context) : _buildDesktopRow(context);
  }

  Widget _buildDesktopRow(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: onViewDetails,
              child: Text(
                carwasher.shopName ?? '—',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          _cell(carwasher.city),
          _cell(carwasher.phone),
          Expanded(flex: 2, child: Center(child: CarwasherStatusBadge(status: carwasher.status))),
          Expanded(
            flex: 3,
            child: isActionLoading
                ? const Center(
                    child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                  )
                : _buildActions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onViewDetails,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    carwasher.shopName ?? '—',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                CarwasherStatusBadge(status: carwasher.status),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              _mobileInfo('City', carwasher.city),
              _mobileInfo('Phone', carwasher.phone),
            ],
          ),
          const SizedBox(height: 12),
          isActionLoading
              ? const Center(
                  child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                )
              : _buildActions(context),
        ],
      ),
    );
  }

  Widget _mobileInfo(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Text('$label: $value', style: const TextStyle(fontSize: 12, color: Colors.black87));
  }

  Widget _cell(String? text) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(text ?? '—', style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final strings = context.l10n;
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
          buttons.add(_btn(strings.billingSettingLinkButton, const Color(0xFF1565C0), () {
        context.goNamed(
          'adminBillingSettings',
          queryParameters: {
            'provider_type': 'car-washer',
            'provider_id': carwasher.id.toString(),
            'customer_address': carwasher.city ?? '',
            'customer_name': carwasher.user?.name ?? '',
            'customer_phone': carwasher.phone ?? '',
          },
        );
      }));
        break;
      case 'suspended':
        buttons.add(_btn(strings.actionReactivate, const Color(0xFF2E7D32), onReactivate));
        break;
    }

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [...buttons, _btn(strings.actionDetails, Colors.blueGrey, onViewDetails)],
    );
  }
}