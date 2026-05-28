import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_fuel_state.dart';

class UserFuelCubit extends Cubit<UserFuelState> {

  UserFuelCubit() : super(UserFuelInitial());

}
