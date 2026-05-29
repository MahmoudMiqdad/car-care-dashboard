class LocationModel {
  final double? lat;
  final double? lng;
  final DateTime? updatedAt;

  LocationModel({
    this.lat,
    this.lng,
    this.updatedAt,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}