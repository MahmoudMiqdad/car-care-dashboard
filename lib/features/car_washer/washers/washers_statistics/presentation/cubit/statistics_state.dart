import '../../domain/entities/statistics_entity.dart';

abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  StatisticsLoaded(this.statistics);
  final StatisticsEntity statistics;
}

class StatisticsError extends StatisticsState {
  StatisticsError(this.message);
  final String message;
}