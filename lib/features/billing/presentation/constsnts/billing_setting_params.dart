const List<String> kBillingTypes = [
  'monthly_subscription',
  'commission_per_order',
  'subscription_plus_commission',
  'exempt',
];

class BillingSettingParams {
  final String? providerType;
  final int? providerId;
  final String billingType;
  final num? monthlyFee;
  final num? commissionPercent;
  final int? freeTrialDays;
  final int? paymentDueDays;
  final String? startsAt;
  final bool isActive;
  final String? notes;

  const BillingSettingParams({
    this.providerType,
    this.providerId,
    required this.billingType,
    this.monthlyFee,
    this.commissionPercent,
    this.freeTrialDays,
    this.paymentDueDays,
    this.startsAt,
    this.isActive = true,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'billing_type': billingType,
      'monthly_fee': monthlyFee,
      'commission_percent': commissionPercent,
      'free_trial_days': freeTrialDays,
      'payment_due_days': paymentDueDays,
      'starts_at': startsAt,
      'is_active': isActive,
      'notes': notes,
    };
    if (providerType != null) map['provider_type'] = providerType;
    if (providerId != null) map['provider_id'] = providerId;
    return map;
  }
}


bool billingTypeShowsMonthlyFee(String type) =>
    type == 'monthly_subscription' || type == 'subscription_plus_commission';

bool billingTypeShowsCommission(String type) =>
    type == 'commission_per_order' || type == 'subscription_plus_commission';

bool billingTypeIsExempt(String type) => type == 'exempt';