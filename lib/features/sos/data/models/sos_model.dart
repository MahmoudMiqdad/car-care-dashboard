class SosModel {
  final bool? success;
  final String? message;
  final SosData? data;

  SosModel({this.success, this.message, this.data});

  factory SosModel.fromJson(Map<String, dynamic> json) => SosModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? SosData.fromJson(json['data']) : null,
      );
}

class SosData {
  final int? id;
  final double? lat;
  final double? lng;
  final String? description;
  final String? status;
  final String? statusText;
  final String? priority;
  final Vehicle? vehicle;
  final bool? canCancel;

  SosData({
    this.id,
    this.lat,
    this.lng,
    this.description,
    this.status,
    this.statusText,
    this.priority,
    this.vehicle,
    this.canCancel,
  });

  factory SosData.fromJson(Map<String, dynamic> json) => SosData(
        id: json['id'],
        lat: double.tryParse(json['lat'].toString()),
        lng: double.tryParse(json['lng'].toString()),
        description: json['description'],
        status: json['status'],
        statusText: json['status_text'],
        priority: json['priority'],
        vehicle:
            json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
        canCancel: json['can_cancel'],
      );
}

class Vehicle {
  final int? id;
  final String? brand;
  final String? model;

  Vehicle({this.id, this.brand, this.model});

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json['id'],
        brand: json['brand'],
        model: json['model'],
      );
}