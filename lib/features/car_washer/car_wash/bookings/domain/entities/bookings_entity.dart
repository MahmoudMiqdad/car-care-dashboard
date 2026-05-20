import 'package:car_care/features/car_washer/car_wash/washers_browse/domain/entities/washers_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:car_care/features/vehicle/domain/entities/vehicle_entity.dart';

class BookingsEntity extends Equatable {
  final int id;
  final String serviceType;
  final String? price;
  final String status;
  final String statusText;
  final String scheduledAt;
  final String notes;
  final bool canCancel;
  final VehicleEntity vehicle;
  final WasherEntity? carWasher;

  const BookingsEntity({
    required this.id,
    required this.serviceType,
    this.price,
    required this.status,
    required this.statusText,
    required this.scheduledAt,
    required this.notes,
    required this.canCancel,
    required this.vehicle,
      this.carWasher,
  });

  @override
  List<Object?> get props => [id, status, scheduledAt];

}

