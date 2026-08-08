// lib/features/reports/presentation/widgets/tabs/advertisements_tab.dart
import 'package:car_care/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_state.dart';
import 'package:car_care/features/reports/presentation/widgets/reports_common_widgets.dart';
import 'package:car_care/core/widgets/loding.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvertisementsTab extends StatefulWidget {
  const AdvertisementsTab({super.key});

  @override
  State<AdvertisementsTab> createState() => _AdvertisementsTabState();
}

class _AdvertisementsTabState extends State<AdvertisementsTab> {
  DateTime? _from;
  DateTime? _to;
  String? _placement;
  bool? _isActive;

  @override
  void initState() {
    super.initState();
    context.read<ReportsCubit>().loadAdvertisements();
  }

  void _apply() {
    context.read<ReportsCubit>().loadAdvertisements(
          from: _from?.toIso8601String().split('T').first,
          to: _to?.toIso8601String().split('T').first,
          placement: _placement,
          isActive: _isActive,
        );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        final placements = state.advertisements?.adsByPlacement.keys.toList() ?? [];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReportSectionCard(
                child: Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    DateRangeFilterBar(
                      from: _from,
                      to: _to,
                      onFromChanged: (d) => setState(() => _from = d),
                      onToChanged: (d) => setState(() => _to = d),
                      onApply: _apply,
                    ),
                    if (placements.isNotEmpty)
                      ReportDropdownFilter(
                        label: strings.filterPlacement,
                        value: _placement,
                        options: placements,
                        onChanged: (v) {
                          setState(() => _placement = v);
                          _apply();
                        },
                      ),
                    SizedBox(
                      width: 160,
                      child: DropdownButtonFormField<bool>(
                        value: _isActive,
                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                        decoration: InputDecoration(
                          labelText: strings.filterStatus,
                          labelStyle: const TextStyle(fontSize: 13),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        items: [
                          DropdownMenuItem<bool>(value: null, child: Text(strings.reportFilterAll, style: const TextStyle(fontSize: 13))),
                          DropdownMenuItem<bool>(value: true, child: Text(strings.adStatusActive, style: const TextStyle(fontSize: 13))),
                          DropdownMenuItem<bool>(value: false, child: Text(strings.adStatusInactive, style: const TextStyle(fontSize: 13))),
                        ],
                        onChanged: (v) {
                          setState(() => _isActive = v);
                          _apply();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (state.advertisementsLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(child: AppLoadingWidget()),
                )
              else if (state.advertisementsError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ReportErrorView(message: state.advertisementsError!, onRetry: _apply),
                )
              else if (state.advertisements != null) ...[
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    ReportStatCard(title: strings.adsTotal, value: '${state.advertisements!.totalAds ?? 0}'),
                    ReportStatCard(title: strings.adsActive, value: '${state.advertisements!.activeAds ?? 0}', color: const Color(0xFF2E7D32)),
                    ReportStatCard(title: strings.adsInactive, value: '${state.advertisements!.inactiveAds ?? 0}'),
                    ReportStatCard(title: strings.adsExpired, value: '${state.advertisements!.expiredAds ?? 0}', color: const Color(0xFFC62828)),
                    ReportStatCard(title: strings.adsScheduled, value: '${state.advertisements!.scheduledAds ?? 0}'),
                  ],
                ),
                const SizedBox(height: 16),
                ReportSectionCard(
                  title: strings.adsByPlacementTitle,
                  child: Wrap(
                    spacing: 10,
                    children: state.advertisements!.adsByPlacement.entries
                        .map((e) => Chip(
                              label: Text('${e.key}: ${e.value}', style: const TextStyle(fontSize: 12)),
                              visualDensity: VisualDensity.compact,
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
                ReportSectionCard(
                  title: strings.adsLatestTitle,
                  child: state.advertisements!.latestAds.isEmpty
                      ? Text(strings.adsEmpty, style: const TextStyle(fontSize: 13, color: Colors.black54))
                      : Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: state.advertisements!.latestAds.map((ad) {
                            return Container(
                              width: 200,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () => showFullImagePreview(context, ad.imageUrl),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        ad.imageUrl ?? '',
                                        height: 90,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (c, e, s) => Container(
                                          height: 90,
                                          color: const Color(0xFFF0F0F0),
                                          child: const Icon(Icons.broken_image_outlined),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(ad.title ?? '—', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(ad.placement ?? '', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                                      Icon(
                                        ad.isActive == true ? Icons.check_circle : Icons.cancel,
                                        size: 13,
                                        color: ad.isActive == true ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}