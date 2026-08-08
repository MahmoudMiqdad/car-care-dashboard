import 'package:car_care/features/billing/domain/entities/billing_entity.dart';

abstract class BillingSettingState {}

class BillingSettingInitial extends BillingSettingState {}

class BillingSettingLoading extends BillingSettingState {}

/// isActiveFilter: 'all' | 'active' | 'inactive'
class BillingSettingListLoaded extends BillingSettingState {
  final List<BillingSettingEntity> settings;
  final String isActiveFilter;
  final String? providerTypeFilter;
  final String? billingTypeFilter;

  BillingSettingListLoaded(
    this.settings,
    this.isActiveFilter, {
    this.providerTypeFilter,
    this.billingTypeFilter,
  });
}

class BillingSettingListActionLoading extends BillingSettingState {
  final List<BillingSettingEntity> settings;
  final String isActiveFilter;
  final int actionSettingId;

  BillingSettingListActionLoading(
      this.settings, this.isActiveFilter, this.actionSettingId);
}

class BillingSettingActionSuccess extends BillingSettingState {
  final String message;
  final List<BillingSettingEntity> settings;
  final String isActiveFilter;

  BillingSettingActionSuccess(this.message, this.settings, this.isActiveFilter);
}

class BillingSettingDetailsLoaded extends BillingSettingState {
  final BillingSettingEntity setting;
  BillingSettingDetailsLoaded(this.setting);
}

class BillingSettingFormSubmitting extends BillingSettingState {}

class BillingSettingFormSuccess extends BillingSettingState {
  final BillingSettingEntity setting;
  final String message;
  BillingSettingFormSuccess(this.setting, this.message);
}

class BillingSettingError extends BillingSettingState {
  final String message;
  BillingSettingError(this.message);
}
