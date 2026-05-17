class SosRequestListDummyItem {
  const SosRequestListDummyItem({
    required this.id,
    required this.vehicle,
    required this.description,
    this.hoursAgo,
    this.minutesAgo,
  }) : assert(
         hoursAgo != null || minutesAgo != null,
         'Provide either hoursAgo or minutesAgo',
       );

  final String id;
  final String vehicle;
  final String description;
  final int? hoursAgo;
  final int? minutesAgo;
}

const kSosRequestListDummyItems = <SosRequestListDummyItem>[
  SosRequestListDummyItem(
    id: '781128',
    vehicle: 'كيا ريو 2009',
    description: 'عطل في الاطارات الاربعة و اختلال في حركة السيارة',
    hoursAgo: 2,
  ),
  SosRequestListDummyItem(
    id: '771002',
    vehicle: 'هيونداي اكسنت 2012',
    description: 'نفاد البنزين على الطريق السريع',
    minutesAgo: 30,
  ),
];
