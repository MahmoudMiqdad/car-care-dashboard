import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:car_care/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const double kChartHeight = 260;

/// كارد بدون ارتفاع ثابت — ياخد حجمه من محتواه، عشان ما يصير overflow
/// (الصفحة كلها أصلاً جوا SingleChildScrollView)
class DashboardCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget? trailing;

  const DashboardCard({super.key, this.title, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    title!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 14),
          ],
          child,
        ],
      ),
    );
  }
}

/// كارد إحصائية صغيرة — حجم ثابت وآمن للأرقام الكبيرة (FittedBox يمنع الـ overflow)
class StatMiniCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const StatMiniCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 92,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 11.5, color: Colors.black54),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- فلتر التاريخ (نفس نمط InvoiceDateRangeFilter بالضبط) ----------------

class _DateChip extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DateChip({required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today_rounded, size: 13, color: AppColors.primary),
            const SizedBox(width: 6),
            Text('$label: $value', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class DashboardDateRangeFilter extends StatelessWidget {
  final String? from;
  final String? to;
  final ValueChanged<String?> onFromChanged;
  final ValueChanged<String?> onToChanged;
  final VoidCallback onApply;

  const DashboardDateRangeFilter({
    super.key,
    required this.from,
    required this.to,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onApply,
  });

  String _fmt(String? iso) {
    if (iso == null || iso.isEmpty) return '—';
    return iso;
  }

  Future<void> _pick(
    BuildContext context,
    String? initial, {
    required ValueChanged<String?> onChanged,
    DateTime? minDate,
    DateTime? maxDate,
  }) async {
    DateTime? initialDate;
    if (initial != null && initial.isNotEmpty) {
      initialDate = DateTime.tryParse(initial);
    }

    final first = minDate ?? DateTime(2020);
    final last = maxDate ?? DateTime(2100);

    var safeInitial = initialDate ?? DateTime.now();
    if (safeInitial.isBefore(first)) safeInitial = first;
    if (safeInitial.isAfter(last)) safeInitial = last;

    final picked = await showDatePicker(
      context: context,
      initialDate: safeInitial,
      firstDate: first,
      lastDate: last,
      builder: (context, child) {
        final baseTheme = Theme.of(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Theme(
            data: baseTheme.copyWith(
              textTheme: Typography.material2021(platform: baseTheme.platform).black,
              colorScheme: baseTheme.colorScheme.copyWith(primary: AppColors.primary),
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      final formatted =
          '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      onChanged(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    final fromDate = (from != null && from!.isNotEmpty) ? DateTime.tryParse(from!) : null;
    final toDate = (to != null && to!.isNotEmpty) ? DateTime.tryParse(to!) : null;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _DateChip(
          label: strings.reportDateFrom,
          value: _fmt(from),
          onTap: () => _pick(
            context,
            from,
            onChanged: onFromChanged,
            maxDate: toDate,
          ),
        ),
        _DateChip(
          label: strings.reportDateTo,
          value: _fmt(to),
          onTap: () => _pick(
            context,
            to,
            onChanged: onToChanged,
            minDate: fromDate,
          ),
        ),
        if (from != null || to != null)
          TextButton.icon(
            onPressed: () {
              onFromChanged(null);
              onToChanged(null);
              onApply();
            },
            icon: const Icon(Icons.clear_rounded, size: 14),
            label: Text(strings.reportFilterClear, style: const TextStyle(fontSize: 13)),
          ),
        SizedBox(
          height: 34,
          child: FilledButton.icon(
            onPressed: onApply,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
            icon: const Icon(Icons.filter_alt_rounded, size: 14),
            label: Text(strings.reportFilterApply, style: const TextStyle(fontSize: 13)),
          ),
        ),
      ],
    );
  }
}

/// ---------------- Charts ----------------

class ProvidersBarChart extends StatelessWidget {
  final ProvidersStatsEntity? providers;

  const ProvidersBarChart({super.key, required this.providers});

  String _formatCompact(double value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final groups = <String, ProviderTypeStatsEntity?>{
      'Technicians': providers?.technicians,
      'Car Wash': providers?.carWashers,
      'Fuel': providers?.fuelProviders,
      'Shops': providers?.shops,
    };

    final colors = {
      'pending': const Color(0xFFEF6C00),
      'approved': const Color(0xFF2E7D32),
      'rejected': const Color(0xFFC62828),
      'suspended': const Color(0xFF616161),
    };

    double maxY = 0;
    final barGroups = <BarChartGroupData>[];
    var index = 0;
    for (final entry in groups.entries) {
      final stats = entry.value;
      final pending = (stats?.pending ?? 0).toDouble();
      final approved = (stats?.approved ?? 0).toDouble();
      final rejected = (stats?.rejected ?? 0).toDouble();
      final suspended = (stats?.suspended ?? 0).toDouble();

      for (final v in [pending, approved, rejected, suspended]) {
        if (v > maxY) maxY = v;
      }

      barGroups.add(
        BarChartGroupData(
          x: index,
          barsSpace: 4,
          barRods: [
            BarChartRodData(toY: pending, color: colors['pending'], width: 10, borderRadius: BorderRadius.circular(3)),
            BarChartRodData(toY: approved, color: colors['approved'], width: 10, borderRadius: BorderRadius.circular(3)),
            BarChartRodData(toY: rejected, color: colors['rejected'], width: 10, borderRadius: BorderRadius.circular(3)),
            BarChartRodData(toY: suspended, color: colors['suspended'], width: 10, borderRadius: BorderRadius.circular(3)),
          ],
        ),
      );
      index++;
    }

    final labels = groups.keys.toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 14,
          runSpacing: 6,
          children: colors.entries.map((entry) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 10, height: 10, decoration: BoxDecoration(color: entry.value, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text(
                  entry.key[0].toUpperCase() + entry.key.substring(1),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: kChartHeight,
          width: double.infinity,
          child: BarChart(
            BarChartData(
              maxY: maxY == 0 ? 10 : maxY * 1.2,
              alignment: BarChartAlignment.spaceAround,
              barGroups: barGroups,
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.toStringAsFixed(0),
                      const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 34,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        _formatCompact(value),
                        style: const TextStyle(fontSize: 10, color: Colors.black54),
                      );
                    },
                  ),
                ),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final i = value.toInt();
                      if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(labels[i], style: const TextStyle(fontSize: 11)),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class OperationsTotalsPieChart extends StatelessWidget {
  final OperationsTotalsEntity? totals;

  const OperationsTotalsPieChart({super.key, required this.totals});

  @override
  Widget build(BuildContext context) {
    final completed = (totals?.completedOperations ?? 0).toDouble();
    final pending = (totals?.pendingOperations ?? 0).toDouble();
    final total = completed + pending;

    return SizedBox(
      height: kChartHeight,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 3,
                centerSpaceRadius: 45,
                sections: [
                  PieChartSectionData(
                    value: completed,
                    color: const Color(0xFF2E7D32),
                    title: total == 0 ? '' : '${((completed / total) * 100).toStringAsFixed(0)}%',
                    radius: 55,
                    titleStyle: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  PieChartSectionData(
                    value: pending,
                    color: const Color(0xFFEF6C00),
                    title: total == 0 ? '' : '${((pending / total) * 100).toStringAsFixed(0)}%',
                    radius: 55,
                    titleStyle: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _legendDot('Completed', const Color(0xFF2E7D32), completed.toInt()),
              const SizedBox(height: 8),
              _legendDot('Pending', const Color(0xFFEF6C00), pending.toInt()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot(String label, Color color, int value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text('$label ($value)', style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class OperationsTimeSeriesLineChart extends StatelessWidget {
  final DashboardOperationsEntity operations;

  const OperationsTimeSeriesLineChart({super.key, required this.operations});

  String _formatCompact(double value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final series = <String, List<BucketEntity>>{
      'Maintenance': operations.maintenance,
      'SOS': operations.sos,
      'Fuel': operations.fuel,
      'Car Wash': operations.carWash,
      'Spare Parts': operations.spareParts,
    };

    final colors = <String, Color>{
      'Maintenance': const Color(0xFF1565C0),
      'SOS': const Color(0xFFC62828),
      'Fuel': const Color(0xFFEF6C00),
      'Car Wash': const Color(0xFF2E7D32),
      'Spare Parts': const Color(0xFF6A1B9A),
    };

    // نجمع كل الـ buckets الفريدة (تواريخ) من كل السلاسل ونرتبها
    final allBuckets = <String>{};
    for (final list in series.values) {
      for (final b in list) {
        if (b.bucket != null) allBuckets.add(b.bucket!);
      }
    }
    final sortedBuckets = allBuckets.toList()..sort();

    if (sortedBuckets.isEmpty) {
      return SizedBox(
        height: kChartHeight,
        child: const Center(child: Text('لا توجد بيانات', style: TextStyle(color: Colors.black45))),
      );
    }

    // نبني map: bucket -> {label: total} لسهولة الوصول
    final Map<String, Map<String, double>> byBucket = {
      for (final bucket in sortedBuckets) bucket: {for (final label in series.keys) label: 0},
    };

    series.forEach((label, buckets) {
      for (final b in buckets) {
        if (b.bucket != null) {
          byBucket[b.bucket]![label] = (b.total ?? 0).toDouble();
        }
      }
    });

    double maxY = 0;
    final barGroups = <BarChartGroupData>[];

    for (var i = 0; i < sortedBuckets.length; i++) {
      final values = byBucket[sortedBuckets[i]]!;
      double cumulative = 0;
      final stackItems = <BarChartRodStackItem>[];

      for (final label in series.keys) {
        final v = values[label] ?? 0;
        if (v <= 0) continue;
        stackItems.add(BarChartRodStackItem(cumulative, cumulative + v, colors[label]!));
        cumulative += v;
      }

      if (cumulative > maxY) maxY = cumulative;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: cumulative,
              rodStackItems: stackItems,
              width: 16,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 14,
          runSpacing: 6,
          children: series.keys.map((label) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 10, height: 10, decoration: BoxDecoration(color: colors[label], shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text(label, style: const TextStyle(fontSize: 12)),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: kChartHeight,
          width: double.infinity,
          child: BarChart(
            BarChartData(
              maxY: maxY == 0 ? 10 : maxY * 1.2,
              alignment: BarChartAlignment.spaceAround,
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.toStringAsFixed(0),
                      const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 34,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        _formatCompact(value),
                        style: const TextStyle(fontSize: 10, color: Colors.black54),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final i = value.toInt();
                      if (i < 0 || i >= sortedBuckets.length) return const SizedBox.shrink();
                      final bucket = sortedBuckets[i];
                      final short = bucket.length >= 5 ? bucket.substring(5) : bucket;
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(short, style: const TextStyle(fontSize: 10)),
                      );
                    },
                  ),
                ),
              ),
              barGroups: barGroups,
            ),
          ),
        ),
      ],
    );
  }
}

class RevenueBreakdownChart extends StatelessWidget {
  final DashboardRevenueEntity revenue;

  const RevenueBreakdownChart({super.key, required this.revenue});

  String _formatCompact(double value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final gross = revenue.grossRevenue;

    final items = <String, double>{
      'Maintenance': gross?.maintenance ?? 0,
      'Fuel': gross?.fuel ?? 0,
      'Car Wash': gross?.carWash ?? 0,
      'Spare Parts': gross?.spareParts ?? 0,
      'SOS': gross?.sos ?? 0,
    };

    final colors = <String, Color>{
      'Maintenance': const Color(0xFF1565C0),
      'Fuel': const Color(0xFFEF6C00),
      'Car Wash': const Color(0xFF2E7D32),
      'Spare Parts': const Color(0xFF6A1B9A),
      'SOS': const Color(0xFFC62828),
    };

    final maxValue = items.values.fold<double>(0, (a, b) => a > b ? a : b);
    final labels = items.keys.toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'Total: ${gross?.total?.toStringAsFixed(0) ?? 0}',
            maxLines: 1,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: kChartHeight,
          width: double.infinity,
          child: BarChart(
            BarChartData(
              maxY: maxValue == 0 ? 10 : maxValue * 1.2,
              alignment: BarChartAlignment.spaceAround,
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.toStringAsFixed(0),
                      const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 46,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        _formatCompact(value),
                        style: const TextStyle(fontSize: 10, color: Colors.black54),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final i = value.toInt();
                      if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(labels[i], style: const TextStyle(fontSize: 11)),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(labels.length, (i) {
                final key = labels[i];
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: items[key]!,
                      color: colors[key],
                      width: 26,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class AdvertisementsStrip extends StatelessWidget {
  final List<AdvertisementEntity> advertisements;

  const AdvertisementsStrip({super.key, required this.advertisements});

  @override
  Widget build(BuildContext context) {
    if (advertisements.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 140,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: advertisements.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final ad = advertisements[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ad.imageUrl != null
                ? Image.network(
                    ad.imageUrl!,
                    width: 220,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      width: 220,
                      height: 140,
                      color: const Color(0xFFF0F0F0),
                      child: const Icon(Icons.broken_image_outlined),
                    ),
                  )
                : Container(width: 220, height: 140, color: const Color(0xFFF0F0F0)),
          );
        },
      ),
    );
  }
}