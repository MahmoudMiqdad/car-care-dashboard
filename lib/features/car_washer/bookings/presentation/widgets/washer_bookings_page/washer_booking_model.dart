class WasherBookingData {
  const WasherBookingData({
    required this.customerName,
    required this.serviceName,
    required this.dateTime,
    required this.price,
    required this.vehicle,
    required this.plateNumber,
    required this.statuses,
  });

  final String customerName;
  final String serviceName;
  final String dateTime;
  final String price;
  final String vehicle;
  final String plateNumber;
  final List<String> statuses;
}
