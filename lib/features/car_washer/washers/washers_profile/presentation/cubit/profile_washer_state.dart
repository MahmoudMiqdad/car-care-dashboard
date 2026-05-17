import '../../domain/entities/washer_profile_entity.dart';

abstract class ProfileWasherState {}

class ProfileWasherInitial extends ProfileWasherState {}

class ProfileWasherLoading extends ProfileWasherState {}

class ProfileWasherLoaded extends ProfileWasherState {
  ProfileWasherLoaded(this.profile);
  final WasherProfileEntity profile;
}

class ProfileWasherEmpty extends ProfileWasherState {}

class ProfileWasherSaving extends ProfileWasherState {}

class ProfileWasherError extends ProfileWasherState {
  ProfileWasherError(this.message);
  final String message;
}

class ProfileWasherMessage extends ProfileWasherState {
  ProfileWasherMessage(this.message);
  final String message;
}