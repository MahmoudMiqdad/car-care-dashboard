import 'package:flutter_bloc/flutter_bloc.dart';
import 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {

  TrackingCubit() : super(TrackingInitial());


}
