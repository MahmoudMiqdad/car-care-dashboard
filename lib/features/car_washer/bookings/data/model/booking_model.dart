import 'package:car_care/features/car_washer/bookings/domain/entities/bookings_entity.dart';
import 'package:car_care/features/vehicle/data/model/vehicle_model.dart'
    show VehicleModel;

class BookingModel extends BookingsEntity {
  const BookingModel({
    required super.id,
    required super.serviceType,
    super.price,
    required super.status,
    required super.statusText,
    required super.scheduledAt,
    required super.notes,
    required super.canCancel,
    required super.vehicle,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      serviceType: json['service_type']?.toString() ?? '',
      price: json['price']?.toString(),
      status: json['status']?.toString() ?? '',
      statusText: json['status_text']?.toString() ?? '',
      scheduledAt: json['scheduled_at']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
      canCancel: json['can_cancel'] == true,
      vehicle: VehicleModel.fromJson(json['vehicle'] as Map<String, dynamic>),
    );
  }

  static List<BookingModel> listFromResponse(Map<String, dynamic> response) {
    final List<dynamic> data = response['data'] ?? [];
    return data.map((json) => BookingModel.fromJson(json)).toList();
  }
}
