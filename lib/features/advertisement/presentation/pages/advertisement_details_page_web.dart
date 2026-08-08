// advertisement_details_page_web.dart
import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/widgets/admin_layout.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/features/advertisement/presentation/cubit/advertisement_cubit.dart';
import 'package:car_care/features/advertisement/presentation/cubit/advertisement_state.dart';
import 'package:car_care/features/advertisement/presentation/widgets/advertisement_widgets.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdvertisementDetailsPageWeb extends StatelessWidget {
  final int advertisementId;

  const AdvertisementDetailsPageWeb({super.key, required this.advertisementId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdvertisementCubit>(
      create: (_) => getIt<AdvertisementCubit>()..loadAdvertisementDetails(advertisementId),
      child: _AdvertisementDetailsView(advertisementId: advertisementId),
    );
  }
}

class _AdvertisementDetailsView extends StatelessWidget {
  final int advertisementId;
  const _AdvertisementDetailsView({required this.advertisementId});

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '—';
    try {
      final d = DateTime.parse(iso);
      return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return AdminLayout(
      currentRoute: 'adminAdvertisements',
      title: strings.advertisementDetailsTitle,
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: OutlinedButton.icon(
            onPressed: () => context.pushNamed(
              'adminAdvertisementEdit',
              pathParameters: {'id': advertisementId.toString()},
            ),
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: Text(strings.adActionEdit),
          ),
        ),
      ],
      child: BlocBuilder<AdvertisementCubit, AdvertisementState>(
        builder: (context, state) {
          if (state is AdvertisementLoading || state is AdvertisementInitial) {
            return const Center(child: AppLoadingWidget());
          }
          if (state is AdvertisementError) {
            return Center(child: Text(state.message));
          }
          if (state is AdvertisementDetailsLoaded) {
            final ad = state.ad;
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ad.imageUrl != null
                            ? Image.network(
                                ad.imageUrl!,
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stack) => Container(
                                  height: 220,
                                  color: const Color(0xFFF0F0F0),
                                  child: const Icon(Icons.broken_image_outlined, size: 40, color: Colors.black26),
                                ),
                              )
                            : Container(
                                height: 220,
                                color: const Color(0xFFF0F0F0),
                                child: const Icon(Icons.image_outlined, size: 40, color: Colors.black26),
                              ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 252, 252, 252),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    ad.title ?? '—',
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                AdvertisementStatusBadge(isActive: ad.isActive),
                              ],
                            ),
                            const Divider(height: 32),
                            _row(strings.adColumnPlacement, ad.placement ?? '—'),
                            _row(strings.adFormLinkLabel, ad.linkUrl ?? '—'),
                            _row(strings.adFormStartsLabel, _formatDate(ad.startsAt)),
                            _row(strings.adFormEndsLabel, _formatDate(ad.endsAt)),
                            _row(strings.adColumnSortOrder, '${ad.sortOrder ?? 0}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}