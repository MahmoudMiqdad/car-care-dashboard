import 'package:equatable/equatable.dart';

class StatisticsEntity extends Equatable {
  const StatisticsEntity({
    required this.totalBookings,
    required this.pendingBookings,
    required this.acceptedBookings,
    required this.inProgressBookings,
    required this.completedBookings,
    required this.cancelledBookings,
    required this.averageRating,
    required this.ratingsCount,
  });

  final int totalBookings;
  final int pendingBookings;
  final int acceptedBookings;
  final int inProgressBookings;
  final int completedBookings;
  final int cancelledBookings;
  final num averageRating;
  final int ratingsCount;

  @override
  List<Object?> get props => [
        totalBookings,
        pendingBookings,
        acceptedBookings,
        inProgressBookings,
        completedBookings,
        cancelledBookings,
        averageRating,
        ratingsCount,
      ];
}