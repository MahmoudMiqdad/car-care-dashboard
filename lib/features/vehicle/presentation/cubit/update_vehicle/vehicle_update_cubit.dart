import 'dart:typed_data';

import 'package:car_care/features/vehicle/domain/entities/vehicle_entity.dart';
import 'package:car_care/features/vehicle/domain/repositories/i_vehicle_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'vehicle_update_state.dart';

class VehicleUpdateCubit extends Cubit<VehicleUpdateState> {
  VehicleUpdateCubit(this._repo) : super(const VehicleUpdateInitial());

  final IVehicleRepository _repo;

  Future<void> updateVehicle({
    required int id,
    required String brand,
    required String model,
    required String year,
    required String plateNumber,
    required String currentKm,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    emit(const VehicleUpdateLoading());

    final params = <String, dynamic>{
      if (brand.trim().isNotEmpty) 'brand': brand.trim(),
      if (model.trim().isNotEmpty) 'model': model.trim(),
      if (year.trim().isNotEmpty) 'year': year.trim(),
      if (plateNumber.trim().isNotEmpty) 'plate_number': plateNumber.trim(),
      if (currentKm.trim().isNotEmpty) 'current_km': currentKm.trim(),
    };

    if (imageBytes != null && imageName != null) {
      params['image_bytes'] = imageBytes;
      params['image_name'] = imageName;
    }

    final result = await _repo.updateVehicle(id: id, params: params);

    result.fold(
      (failure) => emit(VehicleUpdateError(failure.message)),
      (VehicleEntity vehicle) => emit(VehicleUpdateSuccess(vehicle)),
    );
  }
}