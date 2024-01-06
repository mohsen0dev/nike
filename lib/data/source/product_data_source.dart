import 'package:dio/dio.dart';
import 'package:nike/data/models/prodoct.dart';
import 'package:nike/utils/validate.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource({required this.httpClient});
  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final response = await httpClient.get('product/list?sort=$sort');
    validateResponse(response);
    final products = (response.data as List).map((e) {
      return ProductEntity.fromJson(e);
    }).toList();
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('product/search?q=$searchTerm');
    validateResponse(response);
    final products = (response.data as List).map((e) {
      return ProductEntity.fromJson(e);
    }).toList();
    return products;
  }
}
