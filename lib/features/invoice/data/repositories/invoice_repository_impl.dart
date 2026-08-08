import 'package:car_care/features/invoice/data/data_sources/invoice_remote_data_source.dart';
import 'package:car_care/features/invoice/data/models/invoice_model.dart';
import 'package:car_care/features/invoice/domain/entities/invoice_entity.dart';
import 'package:car_care/features/invoice/domain/repositories/i_invoice_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';

class InvoiceRepositoryImpl implements IInvoiceRepository {
  final InvoiceRemoteDataSource _remote;
  InvoiceRepositoryImpl(this._remote);

  InvoiceEntity _mapInvoice(InvoiceData? d) => InvoiceEntity(
        id: d?.id,
        invoiceNumber: d?.invoiceNumber,
        providerType: d?.providerType,
        providerId: d?.providerId,
        billingSettingId: d?.billingSettingId,
        periodStart: d?.periodStart,
        periodEnd: d?.periodEnd,
        issuedAt: d?.issuedAt,
        dueAt: d?.dueAt,
        subtotal: d?.subtotal,
        commissionTotal: d?.commissionTotal,
        subscriptionTotal: d?.subscriptionTotal,
        totalAmount: d?.totalAmount,
        status: d?.status,
        effectiveStatus: d?.effectiveStatus,
        isOverdue: d?.isOverdue,
        externalPaymentMethod: d?.externalPaymentMethod,
        externalPaymentReference: d?.externalPaymentReference,
        paidAt: d?.paidAt,
        confirmedBy: d?.confirmedBy,
        notes: d?.notes,
        items: d?.items.map((e) => InvoiceItemEntity(
              id: e.id,
              itemType: e.itemType,
              sourceType: e.sourceType,
              sourceId: e.sourceId,
              description: e.description,
              amount: e.amount,
            )).toList() ?? const [],
        createdAt: d?.createdAt,
        updatedAt: d?.updatedAt,
      );

  InvoiceGenerateResultEntity _mapGenerateResult(InvoiceGenerateResponseModel m) {
    final d = m.data;
    return InvoiceGenerateResultEntity(
      periodStart: d?.periodStart,
      periodEnd: d?.periodEnd,
      generatedCount: d?.generatedCount,
      skippedCount: d?.skippedCount,
      message: m.message,
      generated: d?.generated.map((e) => InvoiceGeneratedEntity(
            id: e.id,
            invoiceNumber: e.invoiceNumber,
            periodStart: e.periodStart,
            periodEnd: e.periodEnd,
            totalAmount: e.totalAmount,
            status: e.status,
            effectiveStatus: e.effectiveStatus,
            dueAt: e.dueAt,
          )).toList() ?? const [],
      skipped: d?.skipped.map((e) => InvoiceSkippedEntity(
            providerType: e.providerType,
            providerId: e.providerId,
            status: e.status,
            reason: e.reason,
            invoiceId: e.invoiceId,
            trialEndsAt: e.trialEndsAt,
          )).toList() ?? const [],
    );
  }

  Future<Either<Failure, T>> _call<T>(Future<T> Function() fn) async {
    try {
      return Right(await fn());
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InvoiceEntity>>> getInvoices({
    String? providerType,
    int? providerId,
    String? status,
    String? from,
    String? to,
  }) =>
      _call(() async => (await _remote.getInvoices(
            providerType: providerType,
            providerId: providerId,
            status: status,
            from: from,
            to: to,
          )).data.map(_mapInvoice).toList());

  @override
  Future<Either<Failure, InvoiceEntity>> getInvoice(int id) =>
      _call(() async => _mapInvoice((await _remote.getInvoice(id)).data));

  @override
  Future<Either<Failure, InvoiceGenerateResultEntity>> generateInvoices({
    required String periodStart,
    required String periodEnd,
    String? providerType,
    int? providerId,
  }) =>
      _call(() async => _mapGenerateResult(await _remote.generateInvoices(
            periodStart: periodStart,
            periodEnd: periodEnd,
            providerType: providerType,
            providerId: providerId,
          )));

  @override
  Future<Either<Failure, InvoiceActionResult>> issueInvoice(int id) => _call(() async {
        final res = await _remote.issueInvoice(id);
        return InvoiceActionResult(invoice: _mapInvoice(res.data), message: res.message);
      });

  @override
  Future<Either<Failure, InvoiceActionResult>> markInvoicePaid(
    int id, {
    String? externalPaymentMethod,
    String? externalPaymentReference,
    String? notes,
  }) =>
      _call(() async {
        final res = await _remote.markInvoicePaid(
          id,
          externalPaymentMethod: externalPaymentMethod,
          externalPaymentReference: externalPaymentReference,
          notes: notes,
        );
        return InvoiceActionResult(invoice: _mapInvoice(res.data), message: res.message);
      });

  @override
  Future<Either<Failure, InvoiceActionResult>> cancelInvoice(int id) => _call(() async {
        final res = await _remote.cancelInvoice(id);
        return InvoiceActionResult(invoice: _mapInvoice(res.data), message: res.message);
      });
}