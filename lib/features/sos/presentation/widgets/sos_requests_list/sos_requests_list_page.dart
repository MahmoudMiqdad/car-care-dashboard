import 'package:car_care/core/constants/app_constants.dart';
import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/sos/presentation/cubit/sos_cubit/sos_cubit.dart';
import 'package:car_care/features/sos/presentation/cubit/sos_cubit/sos_state.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_request_card.dart';
import 'package:car_care/features/technician_sos/presentation/cubit/technician_sos_cubit/technician_sos_cubit.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SosRequestsListPage extends StatelessWidget {
  const SosRequestsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<TechnicianSosCubit>().getAvailableRequests();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.lightScaffold,
          appBar: CustomAppBar(
            title: l10n.sosRequestsListTitle,
            showBackButton: true,
            backgroundColor: AppColors.carWashTeal,
            onBackTapped: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(Routes.home);
              }
            },
          ),
          body: ImageBackground(
            child: BlocBuilder<SosCubit, SosState>(
              builder: (context, state) {
                if (state is SosLoading) {
                  return const Center(child: AppLoadingWidget());
                }

                if (state is SosError) {
                  return Center(child: Text(state.message));
                }

                if (state is SosListLoaded) {
                  final Sos = state.listSOs;

                  return RefreshIndicator(
                      onRefresh: () async {
                context.read<SosCubit>().getAll();
              },
                    
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        AppConstants.pageHorizontal,
                        16.h,
                        AppConstants.pageHorizontal,
                        16.h,
                      ),
                      itemCount: Sos.length,
                      separatorBuilder: (_, _) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        return SosRequestCard(item: Sos[index]);
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
