import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/features/sos/presentation/cubit/sos_cubit/sos_cubit.dart';
import 'package:car_care/features/sos/presentation/pages/create_sos_page.dart';
import 'package:car_care/features/vehicle/presentation/cubit/vehicle_cubit/vehicle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSosPageWrapper extends StatelessWidget {
  const CreateSosPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<VehicleCubit>()..getAllVehicles(),
        ),
        BlocProvider(
          create: (_) => getIt<SosCubit>(),
        ),
      ],
      child: const CreateSosPage(),
    );
  }
}