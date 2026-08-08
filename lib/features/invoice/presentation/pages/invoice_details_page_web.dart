import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/features/invoice/domain/entities/invoice_entity.dart';
import 'package:car_care/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:car_care/features/invoice/presentation/cubit/invoice_state.dart';
import 'package:car_care/features/invoice/presentation/widgets/invoice_pdf_generator.dart';
import 'package:car_care/features/invoice/presentation/widgets/invoice_widgets.dart';

import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';

class InvoiceDetailsPageWeb extends StatelessWidget {
  final int invoiceId;
  final String? customerName;
  final String? customerAddress;
  final String? customerPhone;

  const InvoiceDetailsPageWeb({
    super.key,
    required this.invoiceId,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvoiceCubit>(
      create: (_) => getIt<InvoiceCubit>()..loadInvoiceDetails(invoiceId),
      child: _InvoiceDetailsView(
        invoiceId: invoiceId,
        customerName: customerName,
        customerAddress: customerAddress,
        customerPhone: customerPhone,
      ),
    );
  }
}

class _InvoiceDetailsView extends StatefulWidget {
  final int invoiceId;
  final String? customerName;
  final String? customerAddress;
  final String? customerPhone;

  const _InvoiceDetailsView({
    required this.invoiceId,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
  });

  @override
  State<_InvoiceDetailsView> createState() => _InvoiceDetailsViewState();
}

class _InvoiceDetailsViewState extends State<_InvoiceDetailsView> {
  InvoiceEntity? _invoice;
  bool _isActionLoading = false;

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '—';
    try {
      final d = DateTime.parse(iso);
      return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} '
          '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }

  Future<void> _issue(BuildContext context) async {
    setState(() => _isActionLoading = true);
    context.read<InvoiceCubit>().issueInvoice(widget.invoiceId);
  }

  Future<void> _markPaid(BuildContext context) async {
    final result = await showInvoiceMarkPaidDialog(context);
    if (result != null) {
      setState(() => _isActionLoading = true);
      context.read<InvoiceCubit>().markInvoicePaid(
            widget.invoiceId,
            externalPaymentMethod: result.method,
            externalPaymentReference: result.reference,
            notes: result.notes,
          );
    }
  }

  Future<void> _cancel(BuildContext context) async {
    final confirmed = await showInvoiceCancelDialog(context);
    if (confirmed) {
      setState(() => _isActionLoading = true);
      context.read<InvoiceCubit>().cancelInvoice(widget.invoiceId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AdminLayout(
      currentRoute: 'adminInvoices',
      title: _invoice?.invoiceNumber ?? strings.invoiceDetailsTitle,
      child: BlocConsumer<InvoiceCubit, InvoiceState>(
        listener: (context, state) {
          if (state is InvoiceError) {
            setState(() => _isActionLoading = false);
            AppSnackBar.error(context, state.message);
          }
          if (state is InvoiceDetailsLoaded) {
            setState(() => _invoice = state.invoice);
          }
          if (state is InvoiceActionSuccess && state.invoice.id == widget.invoiceId) {
            setState(() {
              _invoice = state.invoice;
              _isActionLoading = false;
            });
            AppSnackBar.success(context, state.message);
          }
        },
        builder: (context, state) {
          final invoice = _invoice;
          if (invoice == null) {
            return const Center(child: AppLoadingWidget());
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.goNamed('adminInvoices');
                            }
                          },
                          icon: const Icon(Icons.arrow_back_rounded, size: 20),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            invoice.invoiceNumber ?? strings.invoiceDetailsTitle,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InvoiceStatusBadge(status: invoice.effectiveStatus ?? invoice.status),
                      ],
                    ),
                    const SizedBox(height: 20),

                    _InfoCard(
                      rows: [
                        MapEntry(strings.invoiceFieldProviderType, invoice.providerType),
                        MapEntry(strings.invoiceFieldProviderId, invoice.providerId?.toString()),
                        MapEntry(strings.invoiceFieldPeriodStart, invoice.periodStart),
                        MapEntry(strings.invoiceFieldPeriodEnd, invoice.periodEnd),
                        MapEntry(strings.invoiceFieldIssuedAt, _formatDate(invoice.issuedAt)),
                        MapEntry(strings.invoiceFieldDueAt, _formatDate(invoice.dueAt)),
                        MapEntry(strings.invoiceFieldSubtotal, invoice.subtotal?.toString()),
                        MapEntry(strings.invoiceFieldCommissionTotal, invoice.commissionTotal?.toString()),
                        MapEntry(strings.invoiceFieldSubscriptionTotal, invoice.subscriptionTotal?.toString()),
                        MapEntry(strings.invoiceFieldTotalAmount, invoice.totalAmount?.toString()),
                        if (invoice.paidAt != null)
                          MapEntry(strings.invoiceFieldPaidAt, _formatDate(invoice.paidAt)),
                        if (invoice.externalPaymentMethod != null)
                          MapEntry(strings.invoiceFieldPaymentMethod, invoice.externalPaymentMethod),
                        if (invoice.externalPaymentReference != null)
                          MapEntry(strings.invoiceFieldPaymentReference, invoice.externalPaymentReference),
                      ],
                    ),

                    if (invoice.notes != null && invoice.notes!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _Card(
                        title: strings.invoiceFieldNotes,
                        child: Text(invoice.notes!, style: const TextStyle(fontSize: 15, color: AppColors.black)),
                      ),
                    ],

                    if (invoice.items.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _Card(
                        title: strings.invoiceFieldItems,
                        child: Column(
                          children: invoice.items.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.description ?? item.itemType ?? '—',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    item.amount?.toString() ?? '0',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    _BottomActionsBar(
                      invoice: invoice,
                      isLoading: _isActionLoading,
                      customerName: widget.customerName,
                      customerAddress: widget.customerAddress,
                      customerPhone: widget.customerPhone,
                      onIssue: () => _issue(context),
                      onMarkPaid: () => _markPaid(context),
                      onCancel: () => _cancel(context),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BottomActionsBar extends StatelessWidget {
  final InvoiceEntity invoice;
  final bool isLoading;
  final String? customerName;
  final String? customerAddress;
  final String? customerPhone;
  final VoidCallback onIssue;
  final VoidCallback onMarkPaid;
  final VoidCallback onCancel;

  const _BottomActionsBar({
    required this.invoice,
    required this.isLoading,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    required this.onIssue,
    required this.onMarkPaid,
    required this.onCancel,
  });

  Widget _btn(String text, Color color, VoidCallback onTap, {IconData? icon}) {
    return SizedBox(
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: icon != null ? Icon(icon, size: 20) : const SizedBox.shrink(),
        label: Text(text, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

Future<void> _exportPdf(BuildContext context) async {
  debugPrint('customerName: "$customerName"');
  debugPrint('customerAddress: "$customerAddress"');
  
  final bytes = await InvoicePdfGenerator.generate(
    invoice,
    customerName: customerName,
    customerCity: customerAddress,
    customerPhone: customerPhone,
  );
  await Printing.layoutPdf(
    onLayout: (format) async => bytes,
    name: '${invoice.invoiceNumber ?? 'invoice'}.pdf',
  );
}
  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final buttons = <Widget>[];
    final status = (invoice.effectiveStatus ?? invoice.status ?? '').toLowerCase().trim();

    switch (status) {
      case 'draft':
        buttons.add(_btn(strings.invoiceActionIssue, const Color(0xFF1565C0), onIssue));
        break;
      case 'issued':
      case 'overdue':
        buttons.add(_btn(strings.invoiceActionMarkPaid, const Color(0xFF2E7D32), onMarkPaid));
        buttons.add(_btn(strings.invoiceActionCancel, const Color(0xFFC62828), onCancel));
        break;
    }

    buttons.add(_btn(
      strings.invoiceActionExportPdf,
      const Color(0xFF6A1B9A),
      () => _exportPdf(context),
      icon: Icons.picture_as_pdf_outlined,
    ));

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: buttons,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<MapEntry<String, String?>> rows;
  const _InfoCard({required this.rows});

  @override
  Widget build(BuildContext context) {
    final filtered = rows.where((e) => e.value != null && e.value!.isNotEmpty).toList();

    return _Card(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 480;
          return Wrap(
            runSpacing: 10,
            children: filtered.map((e) {
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
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label :',
              style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
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
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black)),
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );
  }
}