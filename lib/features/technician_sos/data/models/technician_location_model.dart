class TechnicianLocationModel {
  final bool? success;
  final String? message;
  final TechnicianLocationData? data;

  TechnicianLocationModel({
    this.success,
    this.message,
    this.data,
  });

  factory TechnicianLocationModel.fromJson(Map<String, dynamic> json) =>
      TechnicianLocationModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null
            ? TechnicianLocationData.fromJson(json['data'])
            : null,
      );
}

class TechnicianLocationData {
  final double? lat;
  final double? lng;
  final String? timestamp;

  TechnicianLocationData({
    this.lat,
    this.lng,
    this.timestamp,
  });

  factory TechnicianLocationData.fromJson(Map<String, dynamic> json) =>
      TechnicianLocationData(
        lat: double.tryParse(json['lat'].toString()),
        lng: double.tryParse(json['lng'].toString()),
        timestamp: json['timestamp'],
      );
}