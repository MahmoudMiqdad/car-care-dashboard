class ProviderAvailableOrderUiModel {
  const ProviderAvailableOrderUiModel({
    required this.address,
    required this.vehicle,
    required this.fuel,
    required this.price,
    required this.notes,
    required this.dateTime,
  });

  final String address;
  final String vehicle;
  final String fuel;
  final String price;
  final String notes;
  final String dateTime;

  static const ProviderAvailableOrderUiModel preview =
      ProviderAvailableOrderUiModel(
    address: 'دمشق - ساحة العباسيين - مدخل ساحة القصور',
    vehicle: 'كيا ريو 2009',
    fuel: 'OCT 98 / 50L',
    price: '\$99',
    notes: '',
    dateTime: '12/12/2026 - 7:55 PM',
  );

  static const List<ProviderAvailableOrderUiModel> previewList = [
    preview,

  ];
}
