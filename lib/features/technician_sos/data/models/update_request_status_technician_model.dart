class UpdateRequestStatusTechnicianModel {
  final bool? success;
  final String? message;
  final UpdateRequestStatusTechnicianData? data;

  UpdateRequestStatusTechnicianModel({
    this.success,
    this.message,
    this.data,
  });

  factory UpdateRequestStatusTechnicianModel.fromJson(
      Map<String, dynamic> json) {
    return UpdateRequestStatusTechnicianModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? UpdateRequestStatusTechnicianData.fromJson(json['data'])
          : null,
    );
  }
}
class UpdateRequestStatusTechnicianData {
  final int? id;
  final double? lat;
  final double? lng;
  final String? description;
  final String? status;
  final String? statusText;
  final String? priority;
  final bool? canCancel;
  final String? createdAt;
  final String? createdAgo;

  UpdateRequestStatusTechnicianData({
    this.id,
    this.lat,
    this.lng,
    this.description,
    this.status,
    this.statusText,
    this.priority,
    this.canCancel,
    this.createdAt,
    this.createdAgo,
  });

  factory UpdateRequestStatusTechnicianData.fromJson(
      Map<String, dynamic> json) {
    return UpdateRequestStatusTechnicianData(
      id: json['id'],
      lat: double.tryParse(json['lat'].toString()),
      lng: double.tryParse(json['lng'].toString()),
      description: json['description'],
      status: json['status'],
      statusText: json['status_text'],
      priority: json['priority'],
      canCancel: json['can_cancel'],
      createdAt: json['created_at'],
      createdAgo: json['created_ago'],
    );
  }
}