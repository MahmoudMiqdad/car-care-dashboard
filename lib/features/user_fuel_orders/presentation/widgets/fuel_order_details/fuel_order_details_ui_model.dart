class FuelOrderDetailsUiModel {
  const FuelOrderDetailsUiModel({
    required this.vehicleTitle,
    required this.plateNumber,
    required this.fuel,
    required this.price,
    required this.providerName,
    required this.providerPhone,
    this.vehicleImageAsset,
    this.latitude,
    this.longitude,
  });

  final String vehicleTitle;
  final String plateNumber;
  final String fuel;
  final String price;
  final String providerName;
  final String providerPhone;
  final String? vehicleImageAsset;
  final double? latitude;
  final double? longitude;

  factory FuelOrderDetailsUiModel.fromListPreview({
    required String vehicleTitle,
    required String fuel,
    required String price,
  }) {
    return FuelOrderDetailsUiModel(
      vehicleTitle: vehicleTitle,
      plateNumber: preview.plateNumber,
      fuel: fuel,
      price: price.replaceAll(r'$', '').trim(),
      providerName: preview.providerName,
      providerPhone: preview.providerPhone,
      latitude: preview.latitude,
      longitude: preview.longitude,
    );
  }

  static const FuelOrderDetailsUiModel preview = FuelOrderDetailsUiModel(
    vehicleTitle: 'سابا سيدان 2003',
    plateNumber: '328797',
    fuel: 'OCT 98 / 50L',
    price: '99',
    providerName: 'محطة المهندس للوقود',
    providerPhone: '0982504754',
    latitude: 33.3152,
    longitude: 44.3661,
  );
}
