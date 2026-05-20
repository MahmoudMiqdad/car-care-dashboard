import 'package:car_care/core/routing/routes.dart';
import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/widgets/custom_appbar.dart';
import 'package:car_care/core/widgets/image_background.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/car_washer/profile_washer/presentation/cubit/profile_washer_cubit.dart';
import 'package:car_care/features/car_washer/profile_washer/presentation/cubit/profile_washer_state.dart';
import 'package:car_care/features/car_washer/profile_washer/presentation/widgets/edit_profile_page/edit_profile_washer_loaded_form.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfileWasherPage extends StatelessWidget {
  const EditProfileWasherPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => getIt<ProfileWasherCubit>()..load(),
      child: _EditProfileWasherView(),
    );
  }
}

class _EditProfileWasherView extends StatefulWidget {
  @override
  State<_EditProfileWasherView> createState() => _EditProfileWasherViewState();
}

class _EditProfileWasherViewState extends State<_EditProfileWasherView> {
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PopScope(
    
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && _saved) {
        
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightScaffold,
        appBar: CustomAppBar(
          title: l10n.profileWasherEditPageTitle,
          showBackButton: true,
          backgroundColor: AppColors.carWashTeal,
          onBackTapped: () {
            if (context.canPop()) {
              context.pop(_saved);
            } else {
              context.go(Routes.profile_washer);
            }
          },
        ),
        body: ImageBackground(
          child: BlocConsumer<ProfileWasherCubit, ProfileWasherState>(
            listener: (context, state) {
              if (state is ProfileWasherLoaded && _saved) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('تم حفظ التعديلات بنجاح'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                    ),
                  );
                context.pop(true);
              }

              if (state is ProfileWasherError) {
                _saved = false;
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                    ),
                  );
              }

              if (state is ProfileWasherSaving) {
                _saved = true;
              }
            },
            buildWhen: (prev, curr) =>
                curr is ProfileWasherLoaded ||
                curr is ProfileWasherLoading ||
                curr is ProfileWasherSaving,
            builder: (context, state) {
              if (state is ProfileWasherLoading) {
                return const Center(child: AppLoadingWidget());
              }

              if (state is ProfileWasherLoaded) {
                return EditProfileWasherLoadedForm(profile: state.profile);
              }

              if (state is ProfileWasherSaving) {
                return const Center(child: AppLoadingWidget());
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
