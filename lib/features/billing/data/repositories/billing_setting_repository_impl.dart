
import 'package:car_care/features/billing/data/data_sources/billing_remote_data_source.dart';
import 'package:car_care/features/billing/data/models/billing_setting_model.dart';
import 'package:car_care/features/billing/domain/entities/billing_entity.dart';
import 'package:car_care/features/billing/domain/repositories/i_billing_repository.dart';
import 'package:car_care/features/billing/presentation/constsnts/billing_setting_params.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';

class BillingSettingRepositoryImpl implements IBillingSettingRepository {
  final BillingSettingRemoteDataSource _remote;
  BillingSettingRepositoryImpl(this._remote);

  BillingSettingEntity _mapBillingSetting(BillingSettingData? d) =>
      BillingSettingEntity(
        id: d?.id,
        providerType: d?.providerType,
        providerId: d?.providerId,
        billingType: d?.billingType,
        monthlyFee: d?.monthlyFee,
        commissionPercent: d?.commissionPercent,
        freeTrialDays: d?.freeTrialDays,
        paymentDueDays: d?.paymentDueDays,
        startsAt: d?.startsAt,
        isActive: d?.isActive,
        notes: d?.notes,
        createdAt: d?.createdAt,
        updatedAt: d?.updatedAt,
      );

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
  Future<Either<Failure, List<BillingSettingEntity>>> getBillingSettings({
    String? providerType,
    int? providerId,
    String? billingType,
    bool? isActive,
  }) =>
      _call(() async => (await _remote.getBillingSettings(
            providerType: providerType,
            providerId: providerId,
            billingType: billingType,
            isActive: isActive,
          ))
              .data
              .map(_mapBillingSetting)
              .toList());

  @override
  Future<Either<Failure, BillingSettingEntity>> getBillingSetting(int id) =>
      _call(() async =>
          _mapBillingSetting((await _remote.getBillingSetting(id)).data));

  @override
  Future<Either<Failure, BillingSettingEntity>> createBillingSetting(
          BillingSettingParams params) =>
      _call(() async => _mapBillingSetting(
          (await _remote.createBillingSetting(params)).data));

  @override
  Future<Either<Failure, BillingSettingEntity>> updateBillingSetting(
          int id, BillingSettingParams params) =>
      _call(() async => _mapBillingSetting(
          (await _remote.updateBillingSetting(id, params)).data));

  @override
  Future<Either<Failure, String>> deleteBillingSetting(int id) => _call(
      () async => (await _remote.deleteBillingSetting(id))['message'] ?? '');
}
