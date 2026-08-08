// advertisement_repository_impl.dart
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:car_care/features/advertisement/data/data_sources/advertisement_remote_data_source.dart';
import 'package:car_care/features/advertisement/data/models/advertisement_model.dart';
import 'package:car_care/features/advertisement/domain/entities/advertisement_entity.dart';
import 'package:car_care/features/advertisement/domain/repositories/i_advertisement_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';

class AdvertisementRepositoryImpl implements IAdvertisementRepository {
  final AdvertisementRemoteDataSource _remote;
  AdvertisementRepositoryImpl(this._remote);

  AdvertisementEntity _map(AdvertisementData? d) => AdvertisementEntity(
        id: d?.id,
        title: d?.title,
        imagePath: d?.imagePath,
        imageUrl: d?.imageUrl,
        placement: d?.placement,
        linkUrl: d?.linkUrl,
        startsAt: d?.startsAt,
        endsAt: d?.endsAt,
        isActive: d?.isActive,
        sortOrder: d?.sortOrder,
        createdBy: d?.createdBy,
        updatedBy: d?.updatedBy,
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

  /// يحول bytes + اسم الملف لـ XFile يلي الداتا سورس عم تتوقعه
  XFile _toXFile(Uint8List bytes, String fileName) =>
      XFile.fromData(bytes, name: fileName);

  @override
  Future<Either<Failure, List<AdvertisementEntity>>> getAdvertisements({
    bool? isActive,
    String? placement,
    int? perPage,
  }) =>
      _call(() async => (await _remote.getAdvertisements(
            isActive: isActive,
            placement: placement,
            perPage: perPage,
          ))
              .data
              .map(_map)
              .toList());

  @override
  Future<Either<Failure, AdvertisementEntity>> getAdvertisement(int id) =>
      _call(() async => _map((await _remote.getAdvertisement(id)).data));

  @override
  Future<Either<Failure, AdvertisementEntity>> createAdvertisement({
    required String title,
    required String placement,
    String? linkUrl,
    String? startsAt,
    String? endsAt,
    int? sortOrder,
    required Uint8List imageBytes,
    required String imageFileName,
  }) =>
      _call(() async => _map((await _remote.createAdvertisement(
            title: title,
            placement: placement,
            linkUrl: linkUrl,
            startsAt: startsAt,
            endsAt: endsAt,
            sortOrder: sortOrder,
            image: _toXFile(imageBytes, imageFileName),
          ))
              .data));

  @override
  Future<Either<Failure, AdvertisementEntity>> updateAdvertisement({
    required int id,
    String? title,
    String? placement,
    bool? isActive,
    int? sortOrder,
    Uint8List? imageBytes,
    String? imageFileName,
  }) =>
      _call(() async => _map((await _remote.updateAdvertisement(
            id: id,
            title: title,
            placement: placement,
            isActive: isActive,
            sortOrder: sortOrder,
            image: imageBytes != null
                ? _toXFile(imageBytes, imageFileName ?? 'image')
                : null,
          ))
              .data));

  @override
  Future<Either<Failure, AdvertisementEntity>> activateAdvertisement(int id) =>
      _call(() async => _map((await _remote.activateAdvertisement(id)).data));

  @override
  Future<Either<Failure, AdvertisementEntity>> deactivateAdvertisement(
          int id) =>
      _call(() async => _map((await _remote.deactivateAdvertisement(id)).data));

  @override
  Future<Either<Failure, void>> deleteAdvertisement(int id) =>
      _call(() => _remote.deleteAdvertisement(id));
}