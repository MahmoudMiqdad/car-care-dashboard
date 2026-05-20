abstract class ShareTechnicianLocationSosState {}

class TechnicianLocationInitial extends ShareTechnicianLocationSosState {}



class ShareLocationLoading extends ShareTechnicianLocationSosState {}
class ShareLocationSuccess extends ShareTechnicianLocationSosState {}
class ShareLocationError extends ShareTechnicianLocationSosState {
  final String message;
  ShareLocationError(this.message);
}