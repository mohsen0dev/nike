import 'package:dio/dio.dart';
import 'package:nike/data/models/prodoct_model.dart';
import 'package:nike/data/source/product_data_source.dart';

final http =
    Dio(BaseOptions(baseUrl: 'http://www.expertdevelopers.ir/api/v1/'));
final productTest =
    ProductRepository(dataSource: ProductRemoteDataSource(httpClient: http));

abstract class IProductRepository {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository({required this.dataSource});
  @override
  Future<List<ProductEntity>> getAll(int sort) => dataSource.getAll(sort);

  @override
  Future<List<ProductEntity>> search(String searchTerm) =>
      dataSource.search(searchTerm);
}
