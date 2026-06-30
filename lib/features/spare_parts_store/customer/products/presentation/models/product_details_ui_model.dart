// نموذج بيانات تجريبي محلي لمعاينة شاشة Customer Product Details فقط
class ProductDetailsUiModel {
  const ProductDetailsUiModel({
    required this.name,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.stock,
    required this.isNew,
    required this.category,
    required this.carBrand,
    required this.images,
  });

  final String name;
  final String description;
  final double price;
  final double oldPrice;
  final int stock;
  final bool isNew;
  final String category;
  final String carBrand;
  final List<String> images;

  int get discountPercent =>
      (((oldPrice - price) / oldPrice) * 100).round().clamp(0, 100);

  static const ProductDetailsUiModel sample = ProductDetailsUiModel(
    name: 'طرمبة بنزين أصلية',
    description:
        'طرمبة بنزين أصلية متوافقة مع معظم الموديلات الحديثة، مصنوعة من مواد عالية الجودة وتضمن أداءً موثوقًا وعمرًا طويلًا.',
    price: 450,
    oldPrice: 600,
    stock: 12,
    isNew: true,
    category: 'نظام الوقود',
    carBrand: 'تويوتا',
    images: [
      'https://picsum.photos/seed/spare-part-1/600/600',
      'https://picsum.photos/seed/spare-part-2/600/600',
      'https://picsum.photos/seed/spare-part-3/600/600',
    ],
  );
}
