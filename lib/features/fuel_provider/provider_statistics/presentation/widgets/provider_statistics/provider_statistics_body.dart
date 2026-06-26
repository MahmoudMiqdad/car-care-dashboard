import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/fuel_provider/provider_statistics/presentation/cubit/provider_statistics_cubit.dart';
import 'package:car_care/features/fuel_provider/provider_statistics/presentation/cubit/provider_statistics_state.dart';
import 'package:car_care/features/fuel_provider/provider_statistics/presentation/widgets/provider_statistics/provider_statistics_orders_card.dart';
import 'package:car_care/features/fuel_provider/provider_statistics/presentation/widgets/provider_statistics/provider_statistics_profits_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProviderStatisticsBody extends StatelessWidget {
  const ProviderStatisticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return 
       BlocBuilder<
          FuelProviderStatisticsCubit,
          FuelProviderStatisticsState>(
        builder: (context, state) {
          if (state is FuelProviderStatisticsLoading) {
            return const Center(child: AppLoadingWidget());
          }

          if (state is FuelProviderStatisticsError) {
             AppSnackBar.error(context, state.message);
          }

          if (state is FuelProviderStatisticsLoaded) {
            final stats = state.statistics;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProviderStatisticsOrdersCard(statistics: stats),
                  SizedBox(height: 18.h),
                  ProviderStatisticsProfitsCard(statistics: stats),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          }

          return const SizedBox.shrink( child: Text("data"),);
        },
      );
  
  }
}