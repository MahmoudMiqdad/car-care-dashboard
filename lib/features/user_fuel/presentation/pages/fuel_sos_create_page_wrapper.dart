// fuel_sos_create_page_wrapper.dart

import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/features/user_fuel/presentation/cubit/user_fuel_cubit/user_fuel_cubit.dart';
import 'package:car_care/features/user_fuel/presentation/pages/fuel_sos_create_page.dart';
import 'package:car_care/features/vehicle/presentation/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FuelSosCreatePageWrapper extends StatelessWidget {
  const FuelSosCreatePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<VehicleCubit>()..getAllVehicles(),
        ),
        BlocProvider(
          create: (_) => getIt<UserFuelCubit>(),
        ),
      ],
      child: const FuelSosCreatePage(),
    );
  }
}