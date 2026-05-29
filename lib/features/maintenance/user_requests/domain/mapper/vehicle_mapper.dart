import 'package:car_care/features/maintenance/user_requests/data/models/vehicle_model.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/user_entity.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/vehicle_entity.dart';
import 'package:car_care/features/maintenance/user_requests/domain/mapper/user_mapper.dart';

extension VehicleMapper on VehicleModel {
  VehicleEntity toEntity() {
    return VehicleEntity(
      id: id ?? 0,
      brand: brand ?? '',
      model: model ?? '',
      year: year ?? '',
      plateNumber: plateNumber ?? '',
      currentKm: currentKm ?? 0,
      image: image,
      imagePath: imagePath,
      owner: owner?.toEntity() ?? UserEntity(id: 0, name: ''),
      status: status ?? '',
      needsMaintenance: needsMaintenance ?? false,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}