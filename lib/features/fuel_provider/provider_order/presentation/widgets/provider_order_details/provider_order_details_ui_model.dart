import 'package:car_care/features/fuel_provider/provider_available_orders/presentation/widgets/provider_available_orders/provider_available_orders_ui_model.dart';
import 'package:car_care/features/fuel_provider/provider_order/presentation/widgets/provider_order/provider_order_ui_model.dart';

class ProviderOrderDetailsUiModel {
  const ProviderOrderDetailsUiModel({
    required this.vehicleTitle,
    required this.plateNumber,
    required this.fuel,
    required this.price,
    required this.customerName,
    required this.customerPhone,
    this.vehicleImageAsset,
    this.latitude,
    this.longitude,
  });

  final String vehicleTitle;
  final String plateNumber;
  final String fuel;
  final String price;
  final String customerName;
  final String customerPhone;
  final String? vehicleImageAsset;
  final double? latitude;
  final double? longitude;

  factory ProviderOrderDetailsUiModel.fromAvailableOrder(
    ProviderAvailableOrderUiModel order,
  ) {
    return ProviderOrderDetailsUiModel(
      vehicleTitle: order.vehicle,
      plateNumber: preview.plateNumber,
      fuel: order.fuel,
      price: order.price.replaceAll(r'$', '').trim(),
      customerName: preview.customerName,
      customerPhone: preview.customerPhone,
      latitude: preview.latitude,
      longitude: preview.longitude,
    );
  }

  factory ProviderOrderDetailsUiModel.fromMyOrder(
    ProviderOrderUiModel order,
  ) {
    return ProviderOrderDetailsUiModel(
      vehicleTitle: preview.vehicleTitle,
      plateNumber: preview.plateNumber,
      fuel: order.fuel,
      price: order.price.replaceAll(r'$', '').trim(),
      customerName: preview.customerName,
      customerPhone: preview.customerPhone,
      latitude: preview.latitude,
      longitude: preview.longitude,
    );
  }

  static const ProviderOrderDetailsUiModel preview = ProviderOrderDetailsUiModel(
    vehicleTitle: 'سابا سيدان 2003',
    plateNumber: '328797',
    fuel: 'OCT 98 / 50L',
    price: '99',
    customerName: 'محمود المحمود',
    customerPhone: '0982504754',
    latitude: 33.3152,
    longitude: 44.3661,
  );
}
