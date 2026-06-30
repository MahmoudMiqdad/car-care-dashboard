import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/products/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IProductsRepository {
  Future<Either<Failure, ProductEntity>> getProductDetails(int id);
}
