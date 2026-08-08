import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/billing/domain/entities/billing_entity.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// دايالوج تأكيد الحذف - بيرجع true إذا المستخدم أكّد
Future<bool> showBillingSettingDeleteDialog(BuildContext context) async {
  final strings = context.l10n;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(strings.billingDeleteTitle, style: const TextStyle(fontSize: 20)),
      content: Text(strings.billingDeleteMessage, style: const TextStyle(fontSize: 15)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(strings.cancel, style: const TextStyle(fontSize: 15)),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: const Color(0xFFC62828)),
          onPressed: () => Navigator.pop(context, true),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(strings.confirmDelete, style: const TextStyle(fontSize: 15)),
          ),
        ),
      ],
    ),
  );
  return result ?? false;
}

class BillingSettingFilterBar extends StatelessWidget {
  final String currentFilter; // all | active | inactive
  final ValueChanged<String> onChanged;

  const BillingSettingFilterBar({
    super.key,
    required this.currentFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final filters = <String, String>{
      'all': strings.statusAll,
      'active': strings.billingStatusActive,
      'inactive': strings.billingStatusInactive,
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

class BillingSettingStatusBadge extends StatelessWidget {
  final bool? isActive;
  const BillingSettingStatusBadge({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final active = isActive ?? false;
    final color = active ? const Color(0xFF2E7D32) : const Color(0xFF616161);
    final label = active ? strings.billingStatusActive : strings.billingStatusInactive;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
    );
  }
}

class BillingSettingTableHeader extends StatelessWidget {
  const BillingSettingTableHeader({super.key});

  static const _style = TextStyle(fontWeight: FontWeight.w600, color: Colors.black54, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(strings.billingColumnProvider, style: _style)),
          Expanded(flex: 2, child: Text(strings.billingColumnType, style: _style)),
          Expanded(flex: 2, child: Text(strings.billingColumnMonthlyFee, style: _style)),
          Expanded(flex: 2, child: Text(strings.billingColumnCommission, style: _style)),
          Expanded(flex: 2, child: Text(strings.billingColumnStartsAt, style: _style)),
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

class BillingSettingTableRow extends StatelessWidget {
  final BillingSettingEntity setting;
  final bool isActionLoading;
  final bool isMobile;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String? customerName;
  final String? customerAddress;
  final String? customerPhone;

  const BillingSettingTableRow({
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    super.key,
    required this.setting,
    required this.isActionLoading,
    this.isMobile = false,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
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
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: onView,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${setting.providerType ?? '—'} ${setting.providerId ?? '-'}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${setting.id}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          _cell(setting.billingType),
          _cell(setting.monthlyFee?.toString()),
          _cell(setting.commissionPercent != null ? '${setting.commissionPercent}%' : '—'),
          _cell(setting.startsAt),
          Expanded(flex: 2, child: Center(child: BillingSettingStatusBadge(isActive: setting.isActive))),
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
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onView,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${setting.providerType ?? '—'} ${setting.providerId ?? '-'}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Text('${setting.id}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                BillingSettingStatusBadge(isActive: setting.isActive),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              _mobileInfo(context.l10n.billingColumnType, setting.billingType),
              _mobileInfo(context.l10n.billingColumnMonthlyFee, setting.monthlyFee?.toString()),
              _mobileInfo(context.l10n.billingColumnCommission,
                  setting.commissionPercent != null ? '${setting.commissionPercent}%' : null),
              _mobileInfo(context.l10n.billingColumnStartsAt, setting.startsAt),
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
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        _btn(strings.invoiceViewInvoices, const Color(0xFF1565C0), () {
          context.goNamed(
            'adminInvoices',
            queryParameters: {
              'provider_type': setting.providerType ?? '',
              'provider_id': setting.providerId?.toString() ?? '',
              'customer_address': customerAddress ?? '',
              'customer_name': customerName ?? '',
              'customer_phone': customerPhone ?? '',
            },
          );
        }),
        _btn(strings.actionEdit, const Color(0xFF1565C0), onEdit),
        _btn(strings.actionDelete, const Color(0xFFC62828), () async {
          final confirmed = await showBillingSettingDeleteDialog(context);
          if (confirmed) onDelete();
        }),
      ],
    );
  }
}