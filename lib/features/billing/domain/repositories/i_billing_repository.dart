import 'package:car_care/features/billing/domain/entities/billing_entity.dart';
import 'package:car_care/features/billing/presentation/constsnts/billing_setting_params.dart';

import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';

abstract class IBillingSettingRepository {
  Future<Either<Failure, List<BillingSettingEntity>>> getBillingSettings({
    String? providerType,
    int? providerId,
    String? billingType,
    bool? isActive,
  });

  Future<Either<Failure, BillingSettingEntity>> getBillingSetting(int id);

  Future<Either<Failure, BillingSettingEntity>> createBillingSetting(
      BillingSettingParams params);

  Future<Either<Failure, BillingSettingEntity>> updateBillingSetting(
      int id, BillingSettingParams params);

  Future<Either<Failure, String>> deleteBillingSetting(int id);
}