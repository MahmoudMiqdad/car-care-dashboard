// advertisements_page_web.dart
import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/utils/app_snackbar.dart';
import 'package:car_care/core/utils/responsive.dart';
import 'package:car_care/core/widgets/Empty_state.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/advertisement/domain/entities/advertisement_entity.dart';
import 'package:car_care/features/advertisement/presentation/cubit/advertisement_cubit.dart';
import 'package:car_care/features/advertisement/presentation/cubit/advertisement_state.dart';
import 'package:car_care/features/advertisement/presentation/widgets/advertisement_widgets.dart';

import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdvertisementsPageWeb extends StatelessWidget {
  const AdvertisementsPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdvertisementCubit>(
      create: (_) => getIt<AdvertisementCubit>()..loadAdvertisements(),
      child: const _AdvertisementsPageWebView(),
    );
  }
}

class _AdvertisementsPageWebView extends StatefulWidget {
  const _AdvertisementsPageWebView();

  @override
  State<_AdvertisementsPageWebView> createState() => _AdvertisementsPageWebViewState();
}

class _AdvertisementsPageWebViewState extends State<_AdvertisementsPageWebView> {
  String _placement = 'all';
  bool? _isActive;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isMobile = Responsive.isMobile(context);

    return AdminLayout(
      currentRoute: 'adminAdvertisements',
      title: strings.advertisementsPageTitle,
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: FilledButton.icon(
  style: FilledButton.styleFrom(

    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), 
  ),
  onPressed: () => context.pushNamed('adminAdvertisementCreate'),
  icon: const Icon(Icons.add_rounded, size: 18),
  label: Text(strings.adCreateNew, style: const TextStyle(fontSize: 15)),
)


        ),
      ],
      child: BlocConsumer<AdvertisementCubit, AdvertisementState>(
        listener: (context, state) {
          if (state is AdvertisementError) AppSnackBar.error(context, state.message);
          if (state is AdvertisementActionSuccess) AppSnackBar.success(context, state.message);
          if (state is AdvertisementDeleted) AppSnackBar.success(context, strings.adDeletedSuccess);
        },
        builder: (context, state) {
          final ads = _adsFromState(state);
          final actionLoadingId = state is AdvertisementListActionLoading ? state.actionAdId : null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: AdvertisementFilterBar(
                        currentPlacement: _placement,
                        currentIsActive: _isActive,
                        onPlacementChanged: (value) {
                          setState(() => _placement = value);
                          context.read<AdvertisementCubit>().loadAdvertisements(
                                isActive: _isActive,
                                placement: value,
                              );
                        },
                        onActiveChanged: (value) {
                          setState(() => _isActive = value);
                          context.read<AdvertisementCubit>().loadAdvertisements(
                                isActive: value,
                                placement: _placement,
                              );
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: strings.refresh,
                    iconSize: 25,
                    onPressed: () => context.read<AdvertisementCubit>().loadAdvertisements(
                          isActive: _isActive,
                          placement: _placement,
                        ),
                    icon: const Icon(Icons.refresh_rounded, color: AppColors.accent),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(child: _buildContent(context, state, ads, actionLoadingId, isMobile)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AdvertisementState state,
    List<AdvertisementEntity> ads,
    int? actionLoadingId,
    bool isMobile,
  ) {
    if (state is AdvertisementLoading || state is AdvertisementInitial) {
      return const Center(child: AppLoadingWidget());
    }
    if (ads.isEmpty) {
      return const Center(child: EmptyStateWidget());
    }

    final cubit = context.read<AdvertisementCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isMobile) const AdvertisementTableHeader(),
        if (!isMobile) const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: ads.length,
            itemBuilder: (context, index) {
              final ad = ads[index];
              return AdvertisementTableRow(
                ad: ad,
                isActionLoading: actionLoadingId == ad.id,
                isMobile: isMobile,
                onViewDetails: () => context.pushNamed(
                  'adminAdvertisementDetails',
                  pathParameters: {'id': ad.id.toString()},
                ),
                onEdit: () => context.pushNamed(
                  'adminAdvertisementEdit',
                  pathParameters: {'id': ad.id.toString()},
                ),
                onActivate: () => cubit.activateAdvertisement(ad.id!),
                onDeactivate: () => cubit.deactivateAdvertisement(ad.id!),
                onDelete: () async {
                  final confirmed = await showAdvertisementDeleteDialog(context);
                  if (confirmed == true) cubit.deleteAdvertisement(ad.id!);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<AdvertisementEntity> _adsFromState(AdvertisementState state) {
    if (state is AdvertisementListLoaded) return state.ads;
    if (state is AdvertisementListActionLoading) return state.ads;
    if (state is AdvertisementActionSuccess) return state.ads;
    if (state is AdvertisementDeleted) return state.ads;
    return const [];
  }
}