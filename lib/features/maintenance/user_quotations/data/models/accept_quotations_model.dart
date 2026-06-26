
class AcceptQuotationsModel {
    bool success;
    String message;
    Data data;

    AcceptQuotationsModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory AcceptQuotationsModel.fromJson(Map<String, dynamic> json) => AcceptQuotationsModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

 
}

class Data {
    Quotation quotation;
    ServiceJob serviceJob;

    Data({
        required this.quotation,
        required this.serviceJob,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        quotation: Quotation.fromJson(json["quotation"]),
        serviceJob: ServiceJob.fromJson(json["service_job"]),
    );


}

class Quotation {
    int id;
    int price;
    String priceFormatted;
    int estimatedDays;
    String notes;
    bool partsIncluded;
    String status;
    String statusText;
    Technician technician;
    DateTime createdAt;
    String createdAgo;

    Quotation({
        required this.id,
        required this.price,
        required this.priceFormatted,
        required this.estimatedDays,
        required this.notes,
        required this.partsIncluded,
        required this.status,
        required this.statusText,
        required this.technician,
        required this.createdAt,
        required this.createdAgo,
    });

    factory Quotation.fromJson(Map<String, dynamic> json) => Quotation(
        id: json["id"],
        price: json["price"],
        priceFormatted: json["price_formatted"],
        estimatedDays: json["estimated_days"],
        notes: json["notes"],
        partsIncluded: json["parts_included"],
        status: json["status"],
        statusText: json["status_text"],
        technician: Technician.fromJson(json["technician"]),
        createdAt: DateTime.parse(json["created_at"]),
        createdAgo: json["created_ago"],
    );


}

class Technician {
    int id;
    String name;
    String phone;
    TechnicianProfile technicianProfile;

    Technician({
        required this.id,
        required this.name,
        required this.phone,
        required this.technicianProfile,
    });

    factory Technician.fromJson(Map<String, dynamic> json) => Technician(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        technicianProfile: TechnicianProfile.fromJson(json["technician_profile"]),
    );


}

class CurrentLocation {
  final double lat;
  final double lng;
  final String updatedAt;

  CurrentLocation({
    required this.lat,
    required this.lng,
    required this.updatedAt,
  });

  factory CurrentLocation.fromJson(Map<String, dynamic> json) => CurrentLocation(
    lat: (json["lat"] as num).toDouble(),
    lng: (json["lng"] as num).toDouble(),
    updatedAt: json["updated_at"],
  );
}

class TechnicianProfile {
  String? specialization;
  int? experienceYears;
  CurrentLocation? currentLocation;

  TechnicianProfile({
    this.specialization,
    this.experienceYears,
    this.currentLocation,
  });

  factory TechnicianProfile.fromJson(Map<String, dynamic> json) => TechnicianProfile(
    specialization: json["specialization"],
    experienceYears: json["experience_years"],
    currentLocation: json["current_location"] != null
        ? CurrentLocation.fromJson(json["current_location"])
        : null,
  );
}
class ServiceJob {
    int maintenanceRequestId;
    int quotationId;
    int technicianId;
    String status;
    DateTime scheduledDate;
    String notes;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    ServiceJob({
        required this.maintenanceRequestId,
        required this.quotationId,
        required this.technicianId,
        required this.status,
        required this.scheduledDate,
        required this.notes,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory ServiceJob.fromJson(Map<String, dynamic> json) => ServiceJob(
        maintenanceRequestId: json["maintenance_request_id"],
        quotationId: json["quotation_id"],
        technicianId: json["technician_id"],
        status: json["status"],
        scheduledDate: DateTime.parse(json["scheduled_date"]),
        notes: json["notes"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );


}
