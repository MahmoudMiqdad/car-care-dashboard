import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/invoice/domain/entities/invoice_entity.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';

// ============ Status Badge ============

class InvoiceStatusBadge extends StatelessWidget {
  final String? status;
  const InvoiceStatusBadge({super.key, required this.status});

  Color _color() {
    switch (status) {
      case 'paid':
        return const Color(0xFF2E7D32);
      case 'issued':
        return const Color(0xFF1565C0);
      case 'overdue':
        return const Color(0xFFC62828);
      case 'cancelled':
        return const Color(0xFF616161);
      case 'draft':
      default:
        return const Color(0xFFEF6C00);
    }
  }

  String _label(BuildContext context) {
    final strings = context.l10n;
    switch (status) {
      case 'paid':
        return strings.invoiceStatusPaid;
      case 'issued':
        return strings.invoiceStatusIssued;
      case 'overdue':
        return strings.invoiceStatusOverdue;
      case 'cancelled':
        return strings.invoiceStatusCancelled;
      case 'draft':
      default:
        return strings.invoiceStatusDraft;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        _label(context),
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }
}

// ============ Filter Bar ============

class InvoiceFilterBar extends StatelessWidget {
  final String currentStatus;
  final ValueChanged<String> onChanged;

  const InvoiceFilterBar({super.key, required this.currentStatus, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final filters = <String, String>{
      'all': strings.invoiceStatusAll,
      'draft': strings.invoiceStatusDraft,
      'issued': strings.invoiceStatusIssued,
      'paid': strings.invoiceStatusPaid,
      'overdue': strings.invoiceStatusOverdue,
      'cancelled': strings.invoiceStatusCancelled,
    };

    return Wrap(
      spacing: 8,
      children: filters.entries.map((entry) {
        final selected = entry.key == currentStatus;
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

// ============ Table Header ============

class InvoiceTableHeader extends StatelessWidget {
  const InvoiceTableHeader({super.key});

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
          Expanded(flex: 3, child: Text(strings.columnInvoiceNumber, style: _style)),
          Expanded(flex: 2, child: Text(strings.columnProvider, style: _style)),
          Expanded(flex: 3, child: Text(strings.columnPeriod, style: _style)),
          Expanded(flex: 2, child: Text(strings.columnTotalAmount, style: _style)),
          Expanded(flex: 2, child: Text(strings.columnDueAt, style: _style)),
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

// ============ Table Row ============

class InvoiceTableRow extends StatelessWidget {
  final InvoiceEntity invoice;
  final bool isActionLoading;
  final bool isMobile;
  final VoidCallback onViewDetails;
  final VoidCallback onIssue;
  final VoidCallback onMarkPaid;
  final VoidCallback onCancel;

  const InvoiceTableRow({
    super.key,
    required this.invoice,
    required this.isActionLoading,
    this.isMobile = false,
    required this.onViewDetails,
    required this.onIssue,
    required this.onMarkPaid,
    required this.onCancel,
  });

  String _money(num? v) => v == null ? '—' : v.toString();

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
              onTap: onViewDetails,
              child: Text(
                invoice.invoiceNumber ?? '—',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          _cell('${invoice.providerType ?? '—'} ${invoice.providerId ?? '-'}'),
          _cell('${invoice.periodStart ?? '—'} → ${invoice.periodEnd ?? '—'}', flex: 3),
          _cell(_money(invoice.totalAmount)),
          _cell(invoice.dueAt?.split('T').first),
          Expanded(flex: 2, child: Center(child: InvoiceStatusBadge(status: invoice.effectiveStatus ?? invoice.status))),
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
            onTap: onViewDetails,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        invoice.invoiceNumber ?? '—',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${invoice.providerType ?? '—'} ${invoice.providerId ?? '-'}',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                InvoiceStatusBadge(status: invoice.effectiveStatus ?? invoice.status),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            children: [
              _mobileInfo('Period', '${invoice.periodStart ?? '—'} → ${invoice.periodEnd ?? '—'}'),
              _mobileInfo('Total', _money(invoice.totalAmount)),
              _mobileInfo('Due', invoice.dueAt?.split('T').first),
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

  Widget _cell(String? text, {int flex = 2}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(text ?? '—', style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final strings = context.l10n;
    final buttons = <Widget>[];
    final status = invoice.effectiveStatus ?? invoice.status;

    switch (status) {
      case 'draft':
        buttons.add(_btn(strings.invoiceActionIssue, const Color(0xFF1565C0), onIssue));
        break;
      case 'issued':
      case 'overdue':
        buttons.add(_btn(strings.invoiceActionMarkPaid, const Color(0xFF2E7D32), onMarkPaid));
        buttons.add(_btn(strings.invoiceActionCancel, const Color(0xFFC62828), onCancel));
        break;
      case 'paid':
      case 'cancelled':
        break;
    }

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [...buttons, _btn(strings.actionDetails, Colors.blueGrey, onViewDetails)],
    );
  }
}

// ============ Generate Invoices Dialog ============

class InvoiceGenerateResult {
  final String periodStart;
  final String periodEnd;
  final String? providerType;
  final int? providerId;
  const InvoiceGenerateResult({
    required this.periodStart,
    required this.periodEnd,
    this.providerType,
    this.providerId,
  });
}

Future<InvoiceGenerateResult?> showInvoiceGenerateDialog(
  BuildContext context, {
  String? lockedProviderType,
  int? lockedProviderId,
}) async {
  final strings = context.l10n;
  DateTime? start;
  DateTime? end;

  // ===== مقاسات موحّدة =====
  const double titleSize = 22;
  const double labelSize = 18;
  const double fieldTextSize = 18;
  const double lockedInfoSize = 16;
  const double buttonTextSize = 18;

  const _labelStyle = TextStyle(fontSize: labelSize, fontWeight: FontWeight.w600);
  const _fieldTextStyle = TextStyle(fontSize: fieldTextSize);
  const _fieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    border: OutlineInputBorder(),
  );

  String _fmt(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<DateTime?> _pick(
    BuildContext context,
    DateTime? initial, {
    DateTime? minDate,
    DateTime? maxDate,
  }) async {
    final first = minDate ?? DateTime(2020);
    final last = maxDate ?? DateTime(2100);

    var safeInitial = initial ?? DateTime.now();
    if (safeInitial.isBefore(first)) safeInitial = first;
    if (safeInitial.isAfter(last)) safeInitial = last;

    return showDatePicker(
      context: context,
      initialDate: safeInitial,
      firstDate: first,
      lastDate: last,
      builder: (context, child) {
        final baseTheme = Theme.of(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Theme(
            data: baseTheme.copyWith(
              textTheme: Typography.material2021(platform: baseTheme.platform).black,
              colorScheme: baseTheme.colorScheme.copyWith(primary: AppColors.primary),
            ),
            child: child!,
          ),
        );
      },
    );
  }

  return showDialog<InvoiceGenerateResult>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> pickStart() async {
            final picked = await _pick(
              context,
              start,
              // "من" ما بتقدر تكون بعد "إلى"
              maxDate: end,
            );
            if (picked != null) setState(() => start = picked);
          }

          Future<void> pickEnd() async {
            final picked = await _pick(
              context,
              end,
              // "إلى" ما بتقدر تكون قبل "من"
              minDate: start,
            );
            if (picked != null) setState(() => end = picked);
          }

          return AlertDialog(
            title: Text(
              lockedProviderType != null
                  ? strings.invoiceActionGenerateForProvider
                  : strings.invoiceGenerateDialogTitle,
              style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.w600),
            ),
            content: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (lockedProviderType != null) ...[
                    Text(
                      '${strings.invoiceFieldProviderType}: $lockedProviderType',
                      style: const TextStyle(fontSize: lockedInfoSize, color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${strings.invoiceFieldProviderId}: $lockedProviderId',
                      style: const TextStyle(fontSize: lockedInfoSize, color: Colors.black54),
                    ),
                    const SizedBox(height: 18),
                  ],

                  Text(strings.invoiceFieldPeriodStart, style: _labelStyle),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: pickStart,
                    child: InputDecorator(
                      decoration: _fieldDecoration,
                      child: Text(
                        start != null ? _fmt(start!) : strings.billingPickDate,
                        style: _fieldTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(strings.invoiceFieldPeriodEnd, style: _labelStyle),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: pickEnd,
                    child: InputDecorator(
                      decoration: _fieldDecoration,
                      child: Text(
                        end != null ? _fmt(end!) : strings.billingPickDate,
                        style: _fieldTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(strings.cancel, style: const TextStyle(fontSize: buttonTextSize)),
              ),
              FilledButton(
                onPressed: (start == null || end == null)
                    ? null
                    : () => Navigator.pop(
                          context,
                          InvoiceGenerateResult(
                            periodStart: _fmt(start!),
                            periodEnd: _fmt(end!),
                            providerType: lockedProviderType,
                            providerId: lockedProviderId,
                          ),
                        ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(strings.invoiceActionGenerate, style: const TextStyle(fontSize: buttonTextSize)),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
// ============ Mark Paid Dialog ============
// ============ Mark Paid Dialog ============

class InvoiceMarkPaidResult {
  final String? method;
  final String? reference;
  final String? notes;
  const InvoiceMarkPaidResult({this.method, this.reference, this.notes});
}

const List<String> kPaymentMethods = [
  'sham_cash',
  'syriatel_cash',
  'bank_transfer',
  'cash',
  'other',
];

Future<InvoiceMarkPaidResult?> showInvoiceMarkPaidDialog(BuildContext context) async {
  final strings = context.l10n;
  final referenceCtrl = TextEditingController();
  final notesCtrl = TextEditingController();
  String? selectedMethod;

  // ===== مقاسات موحّدة =====
  const double titleSize = 22;
  const double labelSize = 18;
  const double fieldTextSize = 18;
  const double buttonTextSize = 18;

  const _fieldTextStyle = TextStyle(fontSize: fieldTextSize);
  const _fieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    border: OutlineInputBorder(),
  );

  String _methodLabel(String value) {
    switch (value) {
      case 'sham_cash':
        return strings.paymentMethodShamCash;
      case 'syriatel_cash':
        return strings.paymentMethodSyriatelCash;
      case 'bank_transfer':
        return strings.paymentMethodBankTransfer;
      case 'cash':
        return strings.paymentMethodCash;
      case 'other':
      default:
        return strings.paymentMethodOther;
    }
  }

  return showDialog<InvoiceMarkPaidResult>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              strings.invoiceMarkPaidDialogTitle,
              style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.w600),
            ),
            content: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.invoiceFieldPaymentMethod,
                      style: const TextStyle(fontSize: labelSize, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedMethod,
                    decoration: _fieldDecoration,
                    style: _fieldTextStyle.copyWith(color: Colors.black87),
                  
                    items: kPaymentMethods
                        .map((m) => DropdownMenuItem<String>(
                              value: m,
                              child: Text(_methodLabel(m), style: _fieldTextStyle),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => selectedMethod = value),
                  ),
                  const SizedBox(height: 20),

                  Text(strings.invoiceFieldPaymentReference,
                      style: const TextStyle(fontSize: labelSize, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: referenceCtrl,
                    style: _fieldTextStyle,
                    decoration: _fieldDecoration,
                  ),
                  const SizedBox(height: 20),

                  Text(strings.invoiceFieldNotes,
                      style: const TextStyle(fontSize: labelSize, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: notesCtrl,
                    maxLines: 3,
                    style: _fieldTextStyle,
                    decoration: _fieldDecoration,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(strings.cancel, style: const TextStyle(fontSize: buttonTextSize)),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(
                  context,
                  InvoiceMarkPaidResult(
                    method: selectedMethod,
                    reference: referenceCtrl.text.trim().isEmpty ? null : referenceCtrl.text.trim(),
                    notes: notesCtrl.text.trim().isEmpty ? null : notesCtrl.text.trim(),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(strings.invoiceActionMarkPaid, style: const TextStyle(fontSize: buttonTextSize)),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

// ============ Cancel Confirm Dialog ============
Future<bool> showInvoiceCancelDialog(BuildContext context) async {
  final strings = context.l10n;

  const double titleSize = 22;
  const double messageSize = 18;
  const double buttonTextSize = 18;

  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        strings.invoiceCancelDialogTitle,
        style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.w600),
      ),
      content: SizedBox(
        width: 380,
        child: Text(
          strings.invoiceCancelDialogMessage,
          style: const TextStyle(fontSize: messageSize),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(strings.cancel, style: const TextStyle(fontSize: buttonTextSize)),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: const Color(0xFFC62828)),
          onPressed: () => Navigator.pop(context, true),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(strings.confirmReject, style: const TextStyle(fontSize: buttonTextSize)),
          ),
        ),
      ],
    ),
  );
  return result ?? false;
}

// ============ Generate Result Dialog (bottom sheet style) ============

void showInvoiceGenerateResultDialog(BuildContext context, dynamic result) {
  final strings = context.l10n;

  // ===== مقاسات موحّدة =====
  const double titleSize = 20;
  const double countTextSize = 20;
  const double skippedItemSize = 20;
  const double buttonTextSize = 20;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        strings.invoiceGenerateResultTitle,
        style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.w600),
      ),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 22),
                const SizedBox(width: 8),
                Text(
                  '${strings.invoiceGeneratedCount}: ${result.generatedCount ?? 0}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E7D32),
                    fontSize: countTextSize,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.info_rounded, color: Color(0xFFEF6C00), size: 22),
                const SizedBox(width: 8),
                Text(
                  '${strings.invoiceSkippedCount}: ${result.skippedCount ?? 0}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEF6C00),
                    fontSize: countTextSize,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (result.skipped.isNotEmpty) ...[
              const Divider(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 220),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: result.skipped.length,
                  itemBuilder: (context, i) {
                    final s = result.skipped[i];
                    final reason = s.reason == 'already_exists'
                        ? strings.invoiceSkippedReasonAlreadyExists
                        : s.reason == 'within_free_trial'
                            ? strings.invoiceSkippedReasonWithinFreeTrial
                            : (s.reason ?? '—');
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '${s.providerType} #${s.providerId} — $reason',
                        style: const TextStyle(fontSize: skippedItemSize),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text('OK', style: const TextStyle(fontSize: buttonTextSize)),
          ),
        ),
      ],
    ),
  );
}