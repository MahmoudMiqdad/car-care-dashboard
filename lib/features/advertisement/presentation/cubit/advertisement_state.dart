// advertisement_state.dart
import 'package:car_care/features/advertisement/domain/entities/advertisement_entity.dart';


abstract class AdvertisementState {}

class AdvertisementInitial extends AdvertisementState {}

class AdvertisementLoading extends AdvertisementState {}

class AdvertisementSubmitting extends AdvertisementState {}

class AdvertisementListActionLoading extends AdvertisementState {
  final List<AdvertisementEntity> ads;
  final int actionAdId;
  AdvertisementListActionLoading(this.ads, this.actionAdId);
}

class AdvertisementListLoaded extends AdvertisementState {
  final List<AdvertisementEntity> ads;
  AdvertisementListLoaded(this.ads);
}

class AdvertisementDetailsLoaded extends AdvertisementState {
  final AdvertisementEntity ad;
  AdvertisementDetailsLoaded(this.ad);
}

class AdvertisementActionSuccess extends AdvertisementState {
  final AdvertisementEntity ad;
  final String message;
  final List<AdvertisementEntity> ads;
  AdvertisementActionSuccess(this.ad, this.message, this.ads);
}

class AdvertisementDeleted extends AdvertisementState {
  final int id;
  final List<AdvertisementEntity> ads;
  AdvertisementDeleted(this.id, this.ads);
}

class AdvertisementError extends AdvertisementState {
  final String message;
  AdvertisementError(this.message);
}