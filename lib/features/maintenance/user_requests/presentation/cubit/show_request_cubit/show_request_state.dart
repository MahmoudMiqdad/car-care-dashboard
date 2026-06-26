
import 'package:car_care/features/maintenance/user_requests/domain/entities/maintenance_request_details_entity.dart';


abstract class ShowRequestState {}
class ShowRequestInitial extends ShowRequestState {}
class ShowRequestLoading extends ShowRequestState {}
class ShowRequestLoaded extends ShowRequestState {
  final MaintenanceRequestDetailsEntity request;
  ShowRequestLoaded(this.request);
}
class ShowRequestError extends ShowRequestState {
  final String message;
  ShowRequestError(this.message);
}

