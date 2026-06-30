// ملخص بيانات مالك المتجر القادم ضمن استجابة Shop للعميل (ليس Shop Owner Flow الكامل)
//مهم الانتباااه
import 'package:equatable/equatable.dart';

class ShopOwnerSummaryEntity extends Equatable {
  const ShopOwnerSummaryEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  final int? id;
  final String? name;
  final String? email;

  @override
  List<Object?> get props => [id, name, email];
}
