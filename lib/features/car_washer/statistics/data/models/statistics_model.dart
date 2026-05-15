import '../../domain/entities/statistics_entity.dart';

class StatisticsModel extends StatisticsEntity {
  const StatisticsModel({
    required super.totalBookings,
    required super.pendingBookings,
    required super.acceptedBookings,
    required super.inProgressBookings,
    required super.completedBookings,
    required super.cancelledBookings,
    required super.averageRating,
    required super.ratingsCount,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      totalBookings: _toInt(json['total_bookings']),
      pendingBookings: _toInt(json['pending_bookings']),
      acceptedBookings: _toInt(json['accepted_bookings']),
      inProgressBookings: _toInt(json['in_progress_bookings']),
      completedBookings: _toInt(json['completed_bookings']),
      cancelledBookings: _toInt(json['cancelled_bookings']),
      averageRating: _toDouble(json['average_rating']),
      ratingsCount: _toInt(json['ratings_count']),
    );
  }

  static int _toInt(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  static double _toDouble(dynamic v) {
    if (v is double) return v;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }
}