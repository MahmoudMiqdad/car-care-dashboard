abstract class ShareFuelProviderLocationState {}

class ShareFuelProviderLocationInitial extends ShareFuelProviderLocationState {}

class ShareFuelProviderLocationLoading extends ShareFuelProviderLocationState {}

class ShareFuelProviderLocationSuccess extends ShareFuelProviderLocationState {}

class ShareFuelProviderLocationError extends ShareFuelProviderLocationState {
  final String message;
  ShareFuelProviderLocationError(this.message);
}