import 'package:car_care/features/invoice/domain/entities/invoice_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';

abstract class IInvoiceRepository {
  Future<Either<Failure, List<InvoiceEntity>>> getInvoices({
    String? providerType,
    int? providerId,
    String? status,
    String? from,
    String? to,
  });

  Future<Either<Failure, InvoiceEntity>> getInvoice(int id);

  Future<Either<Failure, InvoiceGenerateResultEntity>> generateInvoices({
    required String periodStart,
    required String periodEnd,
    String? providerType,
    int? providerId,
  });

  Future<Either<Failure, InvoiceActionResult>> issueInvoice(int id);

  Future<Either<Failure, InvoiceActionResult>> markInvoicePaid(
    int id, {
    String? externalPaymentMethod,
    String? externalPaymentReference,
    String? notes,
  });

  Future<Either<Failure, InvoiceActionResult>> cancelInvoice(int id);
}