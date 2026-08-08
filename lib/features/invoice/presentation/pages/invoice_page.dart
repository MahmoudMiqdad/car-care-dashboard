import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/utils/responsive.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/Empty_state.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/features/invoice/domain/entities/invoice_entity.dart';
import 'package:car_care/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:car_care/features/invoice/presentation/cubit/invoice_state.dart';
import 'package:car_care/features/invoice/presentation/invoice_filters.dart';
import 'package:car_care/features/invoice/presentation/widgets/invoice_widgets.dart';

import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InvoicesPageWeb extends StatelessWidget {
  final String? initialProviderType;
  final int? initialProviderId;
  final String initialStatus;
  final String? customerName;
  final String? customerAddress;
  final String? customerPhone;

  const InvoicesPageWeb({
    super.key,
    this.initialProviderType,
    this.initialProviderId,
    this.initialStatus = 'all',
    this.customerName,
    this.customerAddress,
    this.customerPhone,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvoiceCubit>(
      create: (_) => getIt<InvoiceCubit>()
        ..loadInvoices(
          filters: InvoiceFilters(
            providerType: initialProviderType,
            providerId: initialProviderId,
            status: initialStatus,
          ),
        ),
      child: _InvoicesPageWebView(
        providerType: initialProviderType,
        providerId: initialProviderId,
        customerName: customerName,
        customerAddress: customerAddress,
        customerPhone: customerPhone,
      ),
    );
  }
}

class _InvoicesPageWebView extends StatefulWidget {
  final String? providerType;
  final int? providerId;
  final String? customerName;
  final String? customerAddress;
  final String? customerPhone;

  const _InvoicesPageWebView({
    this.providerType,
    this.providerId,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
  });

  @override
  State<_InvoicesPageWebView> createState() => _InvoicesPageWebViewState();
}

class _InvoicesPageWebViewState extends State<_InvoicesPageWebView> {
  String? _from;
  String? _to;

  Future<void> _generate(BuildContext context) async {
    final cubit = context.read<InvoiceCubit>();
    final result = await showInvoiceGenerateDialog(
      context,
      lockedProviderType: widget.providerType,
      lockedProviderId: widget.providerId,
    );
    if (result != null) {
      cubit.generateInvoices(
        periodStart: result.periodStart,
        periodEnd: result.periodEnd,
        providerType: result.providerType,
        providerId: result.providerId,
      );
    }
  }

  Future<void> _issue(BuildContext context, int id) async {
    context.read<InvoiceCubit>().issueInvoice(id);
  }

  Future<void> _markPaid(BuildContext context, int id) async {
    final result = await showInvoiceMarkPaidDialog(context);
    if (result != null) {
      context.read<InvoiceCubit>().markInvoicePaid(
            id,
            externalPaymentMethod: result.method,
            externalPaymentReference: result.reference,
            notes: result.notes,
          );
    }
  }

  Future<void> _cancel(BuildContext context, int id) async {
    final confirmed = await showInvoiceCancelDialog(context);
    if (confirmed) {
      context.read<InvoiceCubit>().cancelInvoice(id);
    }
  }

  void _applyDateFilter(BuildContext context, InvoiceFilters currentFilters) {
    context.read<InvoiceCubit>().loadInvoices(
          filters: currentFilters.copyWith(from: _from, to: _to),
        );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isMobile = Responsive.isMobile(context);

    return AdminLayout(
      currentRoute: 'adminInvoices',
      title: strings.invoicesPageTitle,
      child: BlocConsumer<InvoiceCubit, InvoiceState>(
        listener: (context, state) {
          if (state is InvoiceError) {
            AppSnackBar.error(context, state.message);
          }
          if (state is InvoiceActionSuccess) {
            AppSnackBar.success(context, state.message);
          }
          if (state is InvoiceGenerateSuccess) {
            showInvoiceGenerateResultDialog(context, state.result);
            context.read<InvoiceCubit>().loadInvoices();
          }
        },
        builder: (context, state) {
          final currentFilters = _filtersFromState(state);
          final invoices = _invoicesFromState(state);
          final actionLoadingId =
              state is InvoiceListActionLoading ? state.actionInvoiceId : null;
          final isGenerating = state is InvoiceGenerating;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: InvoiceFilterBar(
                        currentStatus: currentFilters.status,
                        onChanged: (value) {
                          context.read<InvoiceCubit>().loadInvoices(
                                filters: currentFilters.copyWith(status: value),
                              );
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: strings.refresh,
                    iconSize: 25,
                    onPressed: () => context.read<InvoiceCubit>().loadInvoices(),
                    icon: const Icon(Icons.refresh_rounded, color: AppColors.accent),
                  ),
                  const SizedBox(width: 6),
                  FilledButton.icon(
                    onPressed: isGenerating ? null : () => _generate(context),
                    icon: isGenerating
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.receipt_long_rounded, size: 20),
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.providerType != null
                            ? strings.invoiceActionGenerateForProvider
                            : strings.invoiceActionGenerate,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              InvoiceDateRangeFilter(
                from: _from,
                to: _to,
                onFromChanged: (v) => setState(() => _from = v),
                onToChanged: (v) => setState(() => _to = v),
                onApply: () => _applyDateFilter(context, currentFilters),
              ),

              const SizedBox(height: 14),
              Expanded(
                child: _buildContent(context, state, invoices, actionLoadingId, isMobile),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    InvoiceState state,
    List<InvoiceEntity> invoices,
    int? actionLoadingId,
    bool isMobile,
  ) {
    if (state is InvoiceLoading || state is InvoiceInitial) {
      return const Center(child: AppLoadingWidget());
    }

    if (invoices.isEmpty) {
      return const Center(child: EmptyStateWidget());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isMobile) const InvoiceTableHeader(),
        if (!isMobile) const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: invoices.length,
            itemBuilder: (context, index) {
              final inv = invoices[index];
              return InvoiceTableRow(
                invoice: inv,
                isActionLoading: actionLoadingId == inv.id,
                isMobile: isMobile,
                onViewDetails: () => context.goNamed(
                  'adminInvoiceDetails',
                  pathParameters: {'id': inv.id.toString()},
                  queryParameters: {
                    'customer_name': widget.customerName ?? '',
                    'customer_address': widget.customerAddress ?? '',
                    'customer_phone': widget.customerPhone ?? '',
                  },
                ),
                onIssue: () => _issue(context, inv.id!),
                onMarkPaid: () => _markPaid(context, inv.id!),
                onCancel: () => _cancel(context, inv.id!),
              );
            },
          ),
        ),
      ],
    );
  }

  InvoiceFilters _filtersFromState(InvoiceState state) {
    if (state is InvoiceListLoaded) return state.filters;
    if (state is InvoiceListActionLoading) return state.filters;
    if (state is InvoiceActionSuccess) return state.filters;
    if (state is InvoiceGenerating) return state.filters;
    if (state is InvoiceGenerateSuccess) return state.filters;
    return const InvoiceFilters();
  }

  List<InvoiceEntity> _invoicesFromState(InvoiceState state) {
    if (state is InvoiceListLoaded) return state.invoices;
    if (state is InvoiceListActionLoading) return state.invoices;
    if (state is InvoiceActionSuccess) return state.invoices;
    if (state is InvoiceGenerating) return state.invoices;
    if (state is InvoiceGenerateSuccess) return state.invoices;
    return const [];
  }
}

class _DateChip extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DateChip({required this.label, required this.value, required this.onTap});

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
            const Icon(Icons.calendar_today_rounded, size: 13, color: AppColors.primary),
            const SizedBox(width: 6),
            Text('$label: $value', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class InvoiceDateRangeFilter extends StatelessWidget {
  final String? from;
  final String? to;
  final ValueChanged<String?> onFromChanged;
  final ValueChanged<String?> onToChanged;
  final VoidCallback onApply;

  const InvoiceDateRangeFilter({
    super.key,
    required this.from,
    required this.to,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onApply,
  });

  String _fmt(String? iso) {
    if (iso == null || iso.isEmpty) return '—';
    return iso;
  }

  Future<void> _pick(
    BuildContext context,
    String? initial, {
    required ValueChanged<String?> onChanged,
    DateTime? minDate,
    DateTime? maxDate,
  }) async {
    DateTime? initialDate;
    if (initial != null && initial.isNotEmpty) {
      initialDate = DateTime.tryParse(initial);
    }

    final first = minDate ?? DateTime(2020);
    final last = maxDate ?? DateTime(2100);

    var safeInitial = initialDate ?? DateTime.now();
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

    if (picked != null) {
      final formatted =
          '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      onChanged(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    final fromDate = (from != null && from!.isNotEmpty) ? DateTime.tryParse(from!) : null;
    final toDate = (to != null && to!.isNotEmpty) ? DateTime.tryParse(to!) : null;

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
            onChanged: onFromChanged,
            maxDate: toDate,
          ),
        ),
        _DateChip(
          label: strings.reportDateTo,
          value: _fmt(to),
          onTap: () => _pick(
            context,
            to,
            onChanged: onToChanged,
            minDate: fromDate,
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
            label: Text(strings.reportFilterClear, style: const TextStyle(fontSize: 13)),
          ),
        SizedBox(
          height: 34,
          child: FilledButton.icon(
            onPressed: onApply,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
            icon: const Icon(Icons.filter_alt_rounded, size: 14),
            label: Text(strings.reportFilterApply, style: const TextStyle(fontSize: 13)),
          ),
        ),
      ],
    );
  }
}