class InvoiceEntity {
  final int? id;
  final String? invoiceNumber;
  final String? providerType;
  final int? providerId;
  final int? billingSettingId;
  final String? periodStart;
  final String? periodEnd;
  final String? issuedAt;
  final String? dueAt;
  final num? subtotal;
  final num? commissionTotal;
  final num? subscriptionTotal;
  final num? totalAmount;
  final String? status;
  final String? effectiveStatus;
  final bool? isOverdue;
  final String? externalPaymentMethod;
  final String? externalPaymentReference;
  final String? paidAt;
  final int? confirmedBy;
  final String? notes;
  final List<InvoiceItemEntity> items;
  final String? createdAt;
  final String? updatedAt;

  const InvoiceEntity({
    this.id,
    this.invoiceNumber,
    this.providerType,
    this.providerId,
    this.billingSettingId,
    this.periodStart,
    this.periodEnd,
    this.issuedAt,
    this.dueAt,
    this.subtotal,
    this.commissionTotal,
    this.subscriptionTotal,
    this.totalAmount,
    this.status,
    this.effectiveStatus,
    this.isOverdue,
    this.externalPaymentMethod,
    this.externalPaymentReference,
    this.paidAt,
    this.confirmedBy,
    this.notes,
    this.items = const [],
    this.createdAt,
    this.updatedAt,
  });
}

class InvoiceItemEntity {
  final int? id;
  final String? itemType;
  final String? sourceType;
  final int? sourceId;
  final String? description;
  final num? amount;

  const InvoiceItemEntity({
    this.id,
    this.itemType,
    this.sourceType,
    this.sourceId,
    this.description,
    this.amount,
  });
}

/// نتيجة أي أكشن (issue / mark-paid / cancel) — بترجع الفاتورة المحدّثة + رسالة السيرفر
class InvoiceActionResult {
  final InvoiceEntity invoice;
  final String? message;

  const InvoiceActionResult({required this.invoice, this.message});
}

// ===== Generate =====

class InvoiceGenerateResultEntity {
  final String? periodStart;
  final String? periodEnd;
  final int? generatedCount;
  final int? skippedCount;
  final List<InvoiceGeneratedEntity> generated;
  final List<InvoiceSkippedEntity> skipped;
  final String? message;

  const InvoiceGenerateResultEntity({
    this.periodStart,
    this.periodEnd,
    this.generatedCount,
    this.skippedCount,
    this.generated = const [],
    this.skipped = const [],
    this.message,
  });
}

class InvoiceGeneratedEntity {
  final int? id;
  final String? invoiceNumber;
  final String? periodStart;
  final String? periodEnd;
  final num? totalAmount;
  final String? status;
  final String? effectiveStatus;
  final String? dueAt;

  const InvoiceGeneratedEntity({
    this.id,
    this.invoiceNumber,
    this.periodStart,
    this.periodEnd,
    this.totalAmount,
    this.status,
    this.effectiveStatus,
    this.dueAt,
  });
}

class InvoiceSkippedEntity {
  final String? providerType;
  final int? providerId;
  final String? status;
  final String? reason;
  final int? invoiceId;
  final String? trialEndsAt;

  const InvoiceSkippedEntity({
    this.providerType,
    this.providerId,
    this.status,
    this.reason,
    this.invoiceId,
    this.trialEndsAt,
  });
}