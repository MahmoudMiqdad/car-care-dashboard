class BillingSettingEntity {
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
 
  const BillingSettingEntity({
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
}
 