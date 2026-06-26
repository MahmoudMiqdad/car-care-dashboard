// cancel_request_state.dart

import 'package:car_care/features/maintenance/user_requests/domain/entities/maintenance_request_entity.dart';

abstract class CancelRequestState {}

class CancelRequestInitial extends CancelRequestState {}

class CancelRequestLoading extends CancelRequestState {}

class CancelRequestSuccess extends CancelRequestState {
  final MaintenanceRequestEntity request;
  CancelRequestSuccess(this.request);
}

class CancelRequestError extends CancelRequestState {
  final String message;
  CancelRequestError(this.message);
}
class DeleteRequestError extends CancelRequestState {
  final String message;
 DeleteRequestError(this.message);
}

class DeleteRequestSuccess extends CancelRequestState {
  final MaintenanceRequestEntity request;
  DeleteRequestSuccess(this.request);
}