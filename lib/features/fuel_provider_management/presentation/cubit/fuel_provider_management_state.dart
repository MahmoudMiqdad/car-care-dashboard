import 'package:car_care/features/fuel_provider_management/domain/entities/fuel_provider_management_entity.dart';

abstract class FuelProviderState {}

class FuelProviderInitial extends FuelProviderState {}

class FuelProviderLoading extends FuelProviderState {}

class FuelProviderListActionLoading extends FuelProviderState {
  final List<FuelProviderEntity> fuelProviders;
  final String currentFilter;
  final int actionFuelProviderId;
  FuelProviderListActionLoading(this.fuelProviders, this.currentFilter, this.actionFuelProviderId);
}

class FuelProviderListLoaded extends FuelProviderState {
  final List<FuelProviderEntity> fuelProviders;
  final String currentFilter;
  FuelProviderListLoaded(this.fuelProviders, this.currentFilter);
}

class FuelProviderDetailsLoaded extends FuelProviderState {
  final FuelProviderEntity fuelProvider;
  FuelProviderDetailsLoaded(this.fuelProvider);
}

class FuelProviderActionSuccess extends FuelProviderState {
  final FuelProviderEntity fuelProvider;
  final String message;
  final List<FuelProviderEntity> fuelProviders;
  final String currentFilter;
  FuelProviderActionSuccess(
    this.fuelProvider,
    this.message,
    this.fuelProviders,
    this.currentFilter,
  );
}

class FuelProviderError extends FuelProviderState {
  final String message;
  FuelProviderError(this.message);
}