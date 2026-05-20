abstract class TechnicianLocationState {}

class TechnicianLocationInitial extends TechnicianLocationState {}

// ─── Update Location (البروفايل - موقع عام) ───────────────────────────────
class UpdateLocationLoading extends TechnicianLocationState {}
class UpdateLocationSuccess extends TechnicianLocationState {}
class UpdateLocationError extends TechnicianLocationState {
  final String message;
  UpdateLocationError(this.message);
}

// ─── Share Location (داخل SOS نشط) ───────────────────────────────────────
class ShareLocationLoading extends TechnicianLocationState {}
class ShareLocationSuccess extends TechnicianLocationState {}
class ShareLocationError extends TechnicianLocationState {
  final String message;
  ShareLocationError(this.message);
}