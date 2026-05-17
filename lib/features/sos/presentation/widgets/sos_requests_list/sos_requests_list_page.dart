import 'package:car_care/core/constants/app_constants.dart';
import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/const.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_request_list_dummy_data.dart';
import 'package:car_care/features/sos/presentation/widgets/sos_requests_list/sos_request_card.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SosRequestsListPage extends StatelessWidget {
  const SosRequestsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Directionality(
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
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(
              AppConstants.pageHorizontal,
              16.h,
              AppConstants.pageHorizontal,
              16.h,
            ),
            itemCount: kSosRequestListDummyItems.length,
            separatorBuilder: (_, _) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return SosRequestCard(item: kSosRequestListDummyItems[index]);
            },
          ),
        ),
      ),
    );
  }
}
