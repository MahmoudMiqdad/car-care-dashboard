

import 'package:car_care/features/invoice/domain/entities/invoice_entity.dart';
import 'package:car_care/features/invoice/presentation/invoice_filters.dart';

abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceListLoaded extends InvoiceState {
  final List<InvoiceEntity> invoices;
  final InvoiceFilters filters;
  InvoiceListLoaded(this.invoices, this.filters);
}

class InvoiceListActionLoading extends InvoiceState {
  final List<InvoiceEntity> invoices;
  final InvoiceFilters filters;
  final int actionInvoiceId;
  InvoiceListActionLoading(this.invoices, this.filters, this.actionInvoiceId);
}

class InvoiceDetailsLoaded extends InvoiceState {
  final InvoiceEntity invoice;
  InvoiceDetailsLoaded(this.invoice);
}

class InvoiceActionSuccess extends InvoiceState {
  final InvoiceEntity invoice;
  final String message;
  final List<InvoiceEntity> invoices;
  final InvoiceFilters filters;
  InvoiceActionSuccess(this.invoice, this.message, this.invoices, this.filters);
}

class InvoiceGenerating extends InvoiceState {
  final List<InvoiceEntity> invoices;
  final InvoiceFilters filters;
  InvoiceGenerating(this.invoices, this.filters);
}

class InvoiceGenerateSuccess extends InvoiceState {
  final InvoiceGenerateResultEntity result;
  final List<InvoiceEntity> invoices;
  final InvoiceFilters filters;
  InvoiceGenerateSuccess(this.result, this.invoices, this.filters);
}

class InvoiceError extends InvoiceState {
  final String message;
  InvoiceError(this.message);
}