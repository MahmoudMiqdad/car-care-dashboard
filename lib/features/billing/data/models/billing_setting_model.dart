class BillingSettingModel {
  final bool? success;
  final String? message;
  final BillingSettingData? data;

  BillingSettingModel({this.success, this.message, this.data});

  factory BillingSettingModel.fromJson(Map<String, dynamic> json) =>
      BillingSettingModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null
            ? BillingSettingData.fromJson(json['data'])
            : null,
      );
}

class BillingSettingListModel {
  final bool? success;
  final List<BillingSettingData> data;
  final BillingSettingMetaModel? meta;

  BillingSettingListModel({this.success, required this.data, this.meta});

  factory BillingSettingListModel.fromJson(Map<String, dynamic> json) =>
      BillingSettingListModel(
        success: json['success'],
        data: json['data'] != null
            ? List.from(json['data'])
                .map((e) => BillingSettingData.fromJson(e))
                .toList()
            : [],
        meta: json['meta'] != null
            ? BillingSettingMetaModel.fromJson(json['meta'])
            : null,
      );
}

class BillingSettingMetaModel {
  final int? total;
  final int? perPage;
  final int? currentPage;

  BillingSettingMetaModel({this.total, this.perPage, this.currentPage});

  factory BillingSettingMetaModel.fromJson(Map<String, dynamic> json) =>
      BillingSettingMetaModel(
        total: json['total'],
        perPage: json['per_page'],
        currentPage: json['current_page'],
      );
}

class BillingSettingData {
  final int? id;
  final String? providerType;
  final int? providerId;
  final String? billingType;
  final num? monthlyFee;
  final num? commissionPercent;
  final int? freeTrialDays;
  final int? paymentDueDays;
  final String? startsAt;
  final bool? isActive;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;

  BillingSettingData({
    this.id,
    this.providerType,
    this.providerId,
    this.billingType,
    this.monthlyFee,
    this.commissionPercent,
    this.freeTrialDays,
    this.paymentDueDays,
    this.startsAt,
    this.isActive,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory BillingSettingData.fromJson(Map<String, dynamic> json) =>
      BillingSettingData(
        id: json['id'],
        providerType: json['provider_type'],
        // provider_id بيرجع مرة int ومرة String من الباك اند - بنطبّعه دايماً int
        providerId: json['provider_id'] is int
            ? json['provider_id']
            : int.tryParse(json['provider_id']?.toString() ?? ''),
        billingType: json['billing_type'],
        monthlyFee: json['monthly_fee'] != null
            ? num.tryParse(json['monthly_fee'].toString())
            : null,
        commissionPercent: json['commission_percent'] != null
            ? num.tryParse(json['commission_percent'].toString())
            : null,
        freeTrialDays: json['free_trial_days'],
        paymentDueDays: json['payment_due_days'],
        startsAt: json['starts_at'],
        isActive: json['is_active'],
        notes: json['notes'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
}
