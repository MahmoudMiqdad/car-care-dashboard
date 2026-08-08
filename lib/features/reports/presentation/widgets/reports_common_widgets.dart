import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
class DateRangeFilterBar extends StatelessWidget {
  final DateTime? from;
  final DateTime? to;
  final ValueChanged<DateTime?> onFromChanged;
  final ValueChanged<DateTime?> onToChanged;
  final VoidCallback onApply;

  const DateRangeFilterBar({
    super.key,
    required this.from,
    required this.to,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onApply,
  });

  Future<void> _pick(
    BuildContext context,
    DateTime? initial,
    ValueChanged<DateTime?> onChanged, {
    DateTime? minDate,
    DateTime? maxDate,
  }) async {
    final first = minDate ?? DateTime(2020);
    final last = maxDate ?? DateTime(2100);

    // لو التاريخ الحالي طالع برا المجال المسموح، رجّعه لأقرب حد
    var safeInitial = initial ?? DateTime.now();
    if (safeInitial.isBefore(first)) safeInitial = first;
    if (safeInitial.isAfter(last)) safeInitial = last;

    final picked = await showDatePicker(
      context: context,
      initialDate: safeInitial,
      firstDate: first,
      lastDate: last,
      builder: (context, child) {
        final baseTheme = Theme.of(context);
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Theme(
            data: baseTheme.copyWith(
              textTheme: Typography.material2021(
                platform: baseTheme.platform,
              ).black,
              colorScheme: baseTheme.colorScheme.copyWith(
                primary: AppColors.primary,
              ),
            ),
            child: child!,
          ),
        );
      },
    );
    if (picked != null) onChanged(picked);
  }

  String _fmt(DateTime? d) => d == null
      ? '—'
      : '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _DateChip(
          label: strings.reportDateFrom,
          value: _fmt(from),
          onTap: () => _pick(
            context,
            from,
            onFromChanged,
            // "من" ما بتقدر تكون بعد "إلى"
            maxDate: to,
          ),
        ),
        _DateChip(
          label: strings.reportDateTo,
          value: _fmt(to),
          onTap: () => _pick(
            context,
            to,
            onToChanged,
            // "إلى" ما بتقدر تكون قبل "من"
            minDate: from,
          ),
        ),
        if (from != null || to != null)
          TextButton.icon(
            onPressed: () {
              onFromChanged(null);
              onToChanged(null);
              onApply();
            },
            icon: const Icon(Icons.clear_rounded, size: 14),
            label: Text(
              strings.reportFilterClear,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        SizedBox(
          height: 34,
          child: FilledButton.icon(
            onPressed: onApply,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
            icon: const Icon(Icons.filter_alt_rounded, size: 14),
            label: Text(
              strings.reportFilterApply,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
class _DateChip extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DateChip({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              size: 13,
              color: AppColors.primary,
            ),
            const SizedBox(width: 6),
            Text('$label: $value', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class ReportDropdownFilter extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final Map<String, String>? labels;

  const ReportDropdownFilter({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return SizedBox(
      width: 190,
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 13),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        items: [
          DropdownMenuItem<String>(
            value: null,
            child: Text(
              strings.reportFilterAll,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          ...options.map(
            (o) => DropdownMenuItem<String>(
              value: o,
              child: Text(
                labels?[o] ?? o,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}

class ReportStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;
  final IconData? icon;

  const ReportStatCard({
    super.key,
    required this.title,
    required this.value,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return Container(
      width: 190,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: c, size: 18),
                const SizedBox(width: 6),
              ],
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: c,
            ),
          ),
        ],
      ),
    );
  }
}

class ReportSectionCard extends StatelessWidget {
  final String? title;
  final Widget child;

  const ReportSectionCard({super.key, this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );
  }
}

class ReportErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ReportErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Colors.redAccent,
            size: 36,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: onRetry,
            child: Text(
              strings.reportRetry,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

void showFullImagePreview(BuildContext context, String? imageUrl) {
  if (imageUrl == null || imageUrl.isEmpty) return;
  showDialog(
    context: context,
    barrierColor: Colors.black87,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InteractiveViewer(
              minScale: 0.5,
              maxScale: 5,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => Container(
                      height: 200,
                      width: 200,
                      color: const Color(0xFFF0F0F0),
                      child: const Icon(Icons.broken_image_outlined, size: 40),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: IconButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                style: IconButton.styleFrom(backgroundColor: Colors.black45),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Map<String, String> providerTypeLabels(BuildContext context) {
  final strings = context.l10n;
  return {
    'technician': strings.providerTypeTechnician,
    'fuel-provider': strings.providerTypeFuelProvider,
    'car-washer': strings.providerTypeCarWasher,
    'shop': strings.providerTypeShop,
  };
}

Map<String, String> operationStatusLabels(BuildContext context) {
  final strings = context.l10n;
  return {
    'total': strings.reportFilterAll,
    'completed': strings.opStatusCompleted,
    'in_progress': strings.opStatusInProgress,
    'cancelled': strings.opStatusCancelled,
    'pending': strings.opStatusPending,
  };
}

Map<String, String> operationTypeLabels(BuildContext context) {
  final strings = context.l10n;
  return {
    // 'totals': strings.opTypeTotals,
    'maintenance': strings.opTypeMaintenance,
    'sos': strings.opTypeSos,
    'fuel': strings.opTypeFuel,
    'car_wash': strings.opTypeCarWash,
    'spare_parts': strings.opTypeSpareParts,
  };
}

Map<String, String> groupByLabels(BuildContext context) {
  final strings = context.l10n;
  return {
    'day': strings.groupByDay,
    'month': strings.groupByMonth,
    'year': strings.groupByYear,
  };
}

Map<String, String> providerStatusLabels(BuildContext context) {
  final strings = context.l10n;
  return {
    'pending': strings.providerStatusPending,
    'approved': strings.providerStatusApproved,
    'rejected': strings.providerStatusRejected,
    'suspended': strings.providerStatusSuspended,
  };
}

Map<String, String> billingStatusLabels(BuildContext context) {
  final strings = context.l10n;
  return {
    'not_configured': strings.billingStatusNotConfigured,
    'exempt': strings.billingStatusExempt,
    'free_trial': strings.billingStatusFreeTrial,
    'active': strings.billingStatusActive,
    'invoice_due': strings.billingStatusInvoiceDue,
    'overdue': strings.billingStatusOverdue,
  };
}
