// نموذج بيانات المنتج القادم من API، يُحوَّل إلى ProductEntity
import 'package:car_care/core/config/env.dart';
import 'package:car_care/features/spare_parts_store/customer/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.discountPrice,
    required super.finalPrice,
    required super.stockQuantity,
    required super.weightKg,
    required super.dimensions,
    required super.isNew,
    required super.isFeatured,
    required super.carBrandName,
    required super.partCategoryName,
    required super.images,
    required super.primaryImage,
    required super.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: _toInt(json['id']),
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      price: _toDouble(json['price']),
      discountPrice: json['discount_price'] == null
          ? null
          : _toDouble(json['discount_price']),
      finalPrice: _toDouble(json['final_price']),
      stockQuantity: _toInt(json['stock_quantity']),
      weightKg: json['weight_kg'] == null ? null : _toDouble(json['weight_kg']),
      dimensions: json['dimensions']?.toString(),
      isNew: json['condition']?.toString().toLowerCase() == 'new',
      isFeatured: json['is_featured'] == true,
      carBrandName: _nestedName(json['car_brand']),
      partCategoryName: _nestedName(json['part_category']),
      images: _parseImages(json['images']),
      primaryImage: _resolveImageUrl(json['primary_image']),
      createdAt: DateTime.tryParse((json['created_at'] ?? '').toString()),
    );
  }

  static String? _nestedName(dynamic value) {
    if (value is String) return value.trim().isEmpty ? null : value.trim();
    if (value is Map) return value['name']?.toString();
    return null;
  }

  static List<String> _parseImages(dynamic value) {
    if (value is! List) return <String>[];
    return value
        .map(_resolveImageUrl)
        .whereType<String>()
        .toList();
  }

  static String? _resolveImageUrl(dynamic value) {
    String? raw;
    if (value is String) {
      raw = value;
    } else if (value is Map) {
      raw = (value['url'] ?? value['image_url'] ?? value['image'])?.toString();
    }

    raw = raw?.trim();
    if (raw == null || raw.isEmpty) return null;
    if (raw.startsWith('http')) return raw;

    final base = Uri.parse(Env.baseUrl);
    final origin = '${base.scheme}://${base.authority}';
    final normalized = raw.startsWith('/') ? raw.substring(1) : raw;
    return '$origin/storage/$normalized';
  }

  static int _toInt(dynamic v, {int fallback = 0}) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? fallback;
    return fallback;
  }

  static double _toDouble(dynamic v, {double fallback = 0}) {
    if (v is double) return v;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? fallback;
    return fallback;
  }
}
