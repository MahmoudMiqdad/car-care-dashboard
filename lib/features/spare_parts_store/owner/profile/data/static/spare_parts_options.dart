// بيانات الخيارات المحلية لملف متجر المالك.
class SparePartsOption {
  const SparePartsOption(this.id, this.name);

  final int id;
  final String name;
}

class SparePartsOptions {
  SparePartsOptions._();

  static const List<SparePartsOption> businessTypes = [
    SparePartsOption(1, 'قطع غيار جديدة'),
    SparePartsOption(2, 'قطع غيار مستعملة/كسر'),
    SparePartsOption(3, 'إطارات وجنطات'),
    SparePartsOption(4, 'بطاريات وزيوت'),
    SparePartsOption(5, 'اكسسوارات وزينة'),
  ];

  static const List<SparePartsOption> carBrands = [
    SparePartsOption(1, 'Toyota'),
    SparePartsOption(2, 'Mercedes-Benz'),
    SparePartsOption(3, 'Hyundai'),
    SparePartsOption(4, 'Kia'),
    SparePartsOption(5, 'BMW'),
    SparePartsOption(6, 'Mazda'),
    SparePartsOption(7, 'Volkswagen'),
    SparePartsOption(8, 'Chevrolet'),
  ];

  static const List<SparePartsOption> partCategories = [
    SparePartsOption(1, 'ميكانيك عام'),
    SparePartsOption(2, 'كهرباء ونظام إنارة'),
    SparePartsOption(3, 'فلاتر وسيور'),
    SparePartsOption(4, 'فرامل وديسكات'),
    SparePartsOption(5, 'عفشة ودركسيون'),
    SparePartsOption(6, 'هيكل خارجي وصاج'),
  ];

  static SparePartsOption? findById(List<SparePartsOption> lookup, int id) =>
      lookup.where((o) => o.id == id).firstOrNull;

  static SparePartsOption? findByName(
    List<SparePartsOption> lookup,
    String name,
  ) =>
      lookup.where((o) => o.name == name).firstOrNull;

  static List<int> namesToIds(
    List<SparePartsOption> lookup,
    List<String> names,
  ) =>
      names
          .map((n) => findByName(lookup, n))
          .whereType<SparePartsOption>()
          .map((o) => o.id)
          .toList();

  static ({List<int> ids, List<String> unknown}) namesToIdsChecked(
    List<SparePartsOption> lookup,
    List<String> names,
  ) {
    final ids = <int>[];
    final unknown = <String>[];
    for (final n in names) {
      final opt = findByName(lookup, n);
      if (opt != null) {
        ids.add(opt.id);
      } else {
        unknown.add(n);
      }
    }
    return (ids: ids, unknown: unknown);
  }

  static List<String> idsToNames(
    List<SparePartsOption> lookup,
    List<int> ids,
  ) =>
      ids
          .map((id) => findById(lookup, id))
          .whereType<SparePartsOption>()
          .map((o) => o.name)
          .toList();
}
