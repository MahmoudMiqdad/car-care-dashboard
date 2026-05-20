import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/features/sos/presentation/cubit/sos_cubit/sos_cubit.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_requests_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUserSosRequests extends StatelessWidget {
  const AllUserSosRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
       create: (_) => getIt<SosCubit>()..getAll(),
      child: const SosRequestsListPage(),
    );
  }
}
