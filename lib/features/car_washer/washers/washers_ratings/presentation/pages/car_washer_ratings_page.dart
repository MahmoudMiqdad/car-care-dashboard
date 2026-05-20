import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';

import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/car_washer/washers/washers_profile/domain/entities/washer_profile_entity.dart';
import 'package:car_care/features/car_washer/washers/washers_profile/presentation/widgets/profile_page/profile_washer_star_rating_row.dart';
import 'package:car_care/features/car_washer/washers/washers_ratings/domain/entities/car_washer_rating_entity.dart';
import 'package:car_care/features/car_washer/washers/washers_ratings/presentation/cubit/car_washer_ratings_cubit.dart';
import 'package:car_care/features/car_washer/washers/washers_ratings/presentation/cubit/car_washer_ratings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CarWasherRatingsPage extends StatefulWidget {
  const CarWasherRatingsPage({super.key, required this.profile});
  final WasherProfileEntity profile;

  @override
  State<CarWasherRatingsPage> createState() => _CarWasherRatingsPageState();
}

class _CarWasherRatingsPageState extends State<CarWasherRatingsPage> {
  late final CarWasherRatingsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<CarWasherRatingsCubit>()..fetchRatings(widget.profile.id);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.lightScaffold,
          appBar: CustomAppBar(
            title: 'التقييمات',
            showBackButton: true,
            backgroundColor: AppColors.carWashTeal,
            onBackTapped: () => context.pop(),
          ),
          body: ImageBackground(
            child: BlocBuilder<CarWasherRatingsCubit, CarWasherRatingsState>(
              builder: (context, state) {
                if (state is CarWasherRatingsLoading ||
                    state is CarWasherRatingsInitial) {
                  return const Center(child: AppLoadingWidget());
                }

                if (state is CarWasherRatingsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            size: 56.sp, color: Colors.red.shade400),
                        SizedBox(height: 12.h),
                        Text(state.message, textAlign: TextAlign.center),
                        SizedBox(height: 16.h),
                        ElevatedButton.icon(
                          onPressed: () =>
                              _cubit.fetchRatings(widget.profile.id),
                          icon: const Icon(Icons.refresh),
                          label: const Text('إعادة محاولة'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is CarWasherRatingsLoaded) {
                  return _RatingsContent(
                    profile: widget.profile,
                    ratings: state.ratings,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _RatingsContent extends StatelessWidget {
  const _RatingsContent({
    required this.profile,
    required this.ratings,
  });

  final WasherProfileEntity profile;
  final List<CarWasherRatingEntity> ratings;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      children: [
        _RatingSummaryCard(profile: profile),
        SizedBox(height: 16.h),
        if (ratings.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Text(
                'لا توجد تقييمات بعد',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.lightTextSecondary,
                ),
              ),
            ),
          )
        else
          ...ratings.map((r) => _RatingCard(rating: r)),
      ],
    );
  }
}

class _RatingSummaryCard extends StatelessWidget {
  const _RatingSummaryCard({required this.profile});
  final WasherProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            profile.averageRating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.carWashTeal,
              height: 1,
            ),
          ),
          SizedBox(height: 8.h),
          ProfileWasherStarRatingRow(
            filledCount: profile.averageRating.round(),
            iconSize: 32.sp,
          ),
          SizedBox(height: 6.h),
          Text(
            '${profile.ratingsCount} تقييم',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingCard extends StatelessWidget {
  const _RatingCard({required this.rating});
  final CarWasherRatingEntity rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.carWashTeal.withValues(alpha: 0.15),
                child: Icon(Icons.person, size: 20.sp, color: AppColors.carWashTeal),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  rating.userName.isNotEmpty ? rating.userName : 'مجهول',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
              ProfileWasherStarRatingRow(
                filledCount: rating.rating.clamp(0, 5),
                iconSize: 18.sp,
              ),
            ],
          ),
          if (rating.review.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              rating.review,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.lightTextPrimary,
              ),
            ),
          ],
          SizedBox(height: 6.h),
          Text(
            rating.createdAgo.isNotEmpty ? rating.createdAgo : rating.createdAt,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
