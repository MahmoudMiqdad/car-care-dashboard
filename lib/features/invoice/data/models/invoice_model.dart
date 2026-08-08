class InvoiceModel {
  final bool? success;
  final String? message;
  final InvoiceData? data;

  InvoiceModel({this.success, this.message, this.data});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? InvoiceData.fromJson(json['data']) : null,
      );
}

class InvoiceListModel {
  final bool? success;
  final List<InvoiceData> data;
  final InvoiceMetaModel? meta;

  InvoiceListModel({this.success, required this.data, this.meta});

  factory InvoiceListModel.fromJson(Map<String, dynamic> json) => InvoiceListModel(
        success: json['success'],
        data: json['data'] != null
            ? List.from(json['data']).map((e) => InvoiceData.fromJson(e)).toList()
            : [],
        meta: json['meta'] != null ? InvoiceMetaModel.fromJson(json['meta']) : null,
      );
}

class InvoiceMetaModel {
  final int? total;
  final int? perPage;
  final int? currentPage;

  InvoiceMetaModel({this.total, this.perPage, this.currentPage});

  factory InvoiceMetaModel.fromJson(Map<String, dynamic> json) => InvoiceMetaModel(
        total: json['total'],
        perPage: json['per_page'],
        currentPage: json['current_page'],
      );
}

class InvoiceData {
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
  final List<InvoiceItemData> items;
  final String? createdAt;
  final String? updatedAt;

  InvoiceData({
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

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        id: json['id'],
        invoiceNumber: json['invoice_number'],
        providerType: json['provider_type'],
        providerId: json['provider_id'],
        billingSettingId: json['billing_setting_id'],
        periodStart: json['period_start'],
        periodEnd: json['period_end'],
        issuedAt: json['issued_at'],
        dueAt: json['due_at'],
        subtotal: json['subtotal'],
        commissionTotal: json['commission_total'],
        subscriptionTotal: json['subscription_total'],
        totalAmount: json['total_amount'],
        status: json['status'],
        effectiveStatus: json['effective_status'],
        isOverdue: json['is_overdue'],
        externalPaymentMethod: json['external_payment_method'],
        externalPaymentReference: json['external_payment_reference'],
        paidAt: json['paid_at'],
        confirmedBy: json['confirmed_by'],
        notes: json['notes'],
        items: json['items'] != null
            ? List.from(json['items']).map((e) => InvoiceItemData.fromJson(e)).toList()
            : [],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
}

class InvoiceItemData {
  final int? id;
  final String? itemType;
  final String? sourceType;
  final int? sourceId;
  final String? description;
  final num? amount;

  InvoiceItemData({
    this.id,
    this.itemType,
    this.sourceType,
    this.sourceId,
    this.description,
    this.amount,
  });

  factory InvoiceItemData.fromJson(Map<String, dynamic> json) => InvoiceItemData(
        id: json['id'],
        itemType: json['item_type'],
        sourceType: json['source_type'],
        sourceId: json['source_id'],
        description: json['description'],
        amount: json['amount'],
      );
}

// ===== Generate =====

class InvoiceGenerateResponseModel {
  final bool? success;
  final String? message;
  final InvoiceGenerateData? data;

  InvoiceGenerateResponseModel({this.success, this.message, this.data});

  factory InvoiceGenerateResponseModel.fromJson(Map<String, dynamic> json) =>
      InvoiceGenerateResponseModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? InvoiceGenerateData.fromJson(json['data']) : null,
      );
}

class InvoiceGenerateData {
  final String? periodStart;
  final String? periodEnd;
  final int? generatedCount;
  final int? skippedCount;
  final List<InvoiceGeneratedItemData> generated;
  final List<InvoiceSkippedItemData> skipped;

  InvoiceGenerateData({
    this.periodStart,
    this.periodEnd,
    this.generatedCount,
    this.skippedCount,
    this.generated = const [],
    this.skipped = const [],
  });

  factory InvoiceGenerateData.fromJson(Map<String, dynamic> json) => InvoiceGenerateData(
        periodStart: json['period']?['start'],
        periodEnd: json['period']?['end'],
        generatedCount: json['generated_count'],
        skippedCount: json['skipped_count'],
        generated: json['generated'] != null
            ? List.from(json['generated']).map((e) => InvoiceGeneratedItemData.fromJson(e)).toList()
            : [],
        skipped: json['skipped'] != null
            ? List.from(json['skipped']).map((e) => InvoiceSkippedItemData.fromJson(e)).toList()
            : [],
      );
}

class InvoiceGeneratedItemData {
  final int? id;
  final String? invoiceNumber;
  final String? periodStart;
  final String? periodEnd;
  final num? totalAmount;
  final String? status;
  final String? effectiveStatus;
  final String? dueAt;

  InvoiceGeneratedItemData({
    this.id,
    this.invoiceNumber,
    this.periodStart,
    this.periodEnd,
    this.totalAmount,
    this.status,
    this.effectiveStatus,
    this.dueAt,
  });

  factory InvoiceGeneratedItemData.fromJson(Map<String, dynamic> json) => InvoiceGeneratedItemData(
        id: json['id'],
        invoiceNumber: json['invoice_number'],
        periodStart: json['period_start'],
        periodEnd: json['period_end'],
        totalAmount: json['total_amount'],
        status: json['status'],
        effectiveStatus: json['effective_status'],
        dueAt: json['due_at'],
      );
}

class InvoiceSkippedItemData {
  final String? providerType;
  final int? providerId;
  final String? status;
  final String? reason;
  final int? invoiceId;
  final String? trialEndsAt;

  InvoiceSkippedItemData({
    this.providerType,
    this.providerId,
    this.status,
    this.reason,
    this.invoiceId,
    this.trialEndsAt,
  });

  factory InvoiceSkippedItemData.fromJson(Map<String, dynamic> json) => InvoiceSkippedItemData(
        providerType: json['provider_type'],
        providerId: json['provider_id'],
        status: json['status'],
        reason: json['reason'],
        invoiceId: json['invoice_id'],
        trialEndsAt: json['trial_ends_at'],
      );
}