// i_advertisement_repository.dart
import 'dart:typed_data';
import 'package:car_care/features/advertisement/domain/entities/advertisement_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';


abstract class IAdvertisementRepository {
  Future<Either<Failure, List<AdvertisementEntity>>> getAdvertisements({
    bool? isActive,
    String? placement,
    int? perPage,
  });
  Future<Either<Failure, AdvertisementEntity>> getAdvertisement(int id);
  Future<Either<Failure, AdvertisementEntity>> createAdvertisement({
    required String title,
    required String placement,
    String? linkUrl,
    String? startsAt,
    String? endsAt,
    int? sortOrder,
    required Uint8List imageBytes,
    required String imageFileName,
  });
  Future<Either<Failure, AdvertisementEntity>> updateAdvertisement({
    required int id,
    String? title,
    String? placement,
    bool? isActive,
    int? sortOrder,
    Uint8List? imageBytes,
    String? imageFileName,
  });
  Future<Either<Failure, AdvertisementEntity>> activateAdvertisement(int id);
  Future<Either<Failure, AdvertisementEntity>> deactivateAdvertisement(int id);
  Future<Either<Failure, void>> deleteAdvertisement(int id);
}