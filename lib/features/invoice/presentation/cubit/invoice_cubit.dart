
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/invoice/domain/entities/invoice_entity.dart';
import 'package:car_care/features/invoice/domain/repositories/i_invoice_repository.dart';
import 'package:car_care/features/invoice/presentation/cubit/invoice_state.dart';
import 'package:car_care/features/invoice/presentation/invoice_filters.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final IInvoiceRepository _repo;
  InvoiceCubit(this._repo) : super(InvoiceInitial());

  List<InvoiceEntity> _currentList = [];
  InvoiceFilters _currentFilters = const InvoiceFilters();

  Future<void> loadInvoices({InvoiceFilters? filters}) async {
    if (filters != null) _currentFilters = filters;
    emit(InvoiceLoading());
    final res = await _repo.getInvoices(
      providerType: _currentFilters.providerType,
      providerId: _currentFilters.providerId,
      status: _currentFilters.status,
      from: _currentFilters.from,
      to: _currentFilters.to,
    );
    res.fold(
      (l) => emit(InvoiceError(l.message)),
      (r) {
        _currentList = r;
        emit(InvoiceListLoaded(_currentList, _currentFilters));
      },
    );
  }

  Future<void> loadInvoiceDetails(int id) async {
    emit(InvoiceLoading());
    final res = await _repo.getInvoice(id);
    res.fold(
      (l) => emit(InvoiceError(l.message)),
      (r) => emit(InvoiceDetailsLoaded(r)),
    );
  }

  Future<void> generateInvoices({
    required String periodStart,
    required String periodEnd,
    String? providerType,
    int? providerId,
  }) async {
    emit(InvoiceGenerating(_currentList, _currentFilters));
    final res = await _repo.generateInvoices(
      periodStart: periodStart,
      periodEnd: periodEnd,
      providerType: providerType,
      providerId: providerId,
    );
    res.fold(
      (l) => emit(InvoiceError(l.message)),
      (r) => emit(InvoiceGenerateSuccess(r, _currentList, _currentFilters)),
    );
  }

  Future<void> issueInvoice(int id) async {
    emit(InvoiceListActionLoading(_currentList, _currentFilters, id));
    final res = await _repo.issueInvoice(id);
    await _handleActionResult(res);
  }

  Future<void> markInvoicePaid(
    int id, {
    String? externalPaymentMethod,
    String? externalPaymentReference,
    String? notes,
  }) async {
    emit(InvoiceListActionLoading(_currentList, _currentFilters, id));
    final res = await _repo.markInvoicePaid(
      id,
      externalPaymentMethod: externalPaymentMethod,
      externalPaymentReference: externalPaymentReference,
      notes: notes,
    );
    await _handleActionResult(res);
  }

  Future<void> cancelInvoice(int id) async {
    emit(InvoiceListActionLoading(_currentList, _currentFilters, id));
    final res = await _repo.cancelInvoice(id);
    await _handleActionResult(res);
  }

  Future<void> _handleActionResult(Either<Failure, InvoiceActionResult> res) async {
    res.fold(
      (l) => emit(InvoiceError(l.message)),
      (result) {
        _currentList = _currentList
            .map((inv) => inv.id == result.invoice.id ? result.invoice : inv)
            .toList();
        emit(InvoiceActionSuccess(
          result.invoice,
          result.message ?? '',
          _currentList,
          _currentFilters,
        ));
      },
    );
  }
}