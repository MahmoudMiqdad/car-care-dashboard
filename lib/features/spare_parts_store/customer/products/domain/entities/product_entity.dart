// كيان المنتج لمتجر قطع الغيار (شراء عميل)
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.finalPrice,
    required this.stockQuantity,
    required this.weightKg,
    required this.dimensions,
    required this.isNew,
    required this.isFeatured,
    required this.carBrandName,
    required this.partCategoryName,
    required this.images,
    required this.primaryImage,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final double finalPrice;
  final int stockQuantity;
  final double? weightKg;
  final String? dimensions;
  final bool isNew;
  final bool isFeatured;
  final String? carBrandName;
  final String? partCategoryName;
  final List<String> images;
  final String? primaryImage;
  final DateTime? createdAt;

  bool get hasDiscount => finalPrice < price;

  int get discountPercent {
    if (!hasDiscount) return 0;
    return (((price - finalPrice) / price) * 100).round().clamp(0, 100);
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    discountPrice,
    finalPrice,
    stockQuantity,
    weightKg,
    dimensions,
    isNew,
    isFeatured,
    carBrandName,
    partCategoryName,
    images,
    primaryImage,
    createdAt,
  ];
}
