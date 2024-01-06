import 'package:dio/dio.dart';
import 'package:nike/data/models/baner_model.dart';
import 'package:nike/utils/validate.dart';

abstract class IBannerDataSource {
  Future<List<BanerEntity>> getAll();
}

class BannerDataSource implements IBannerDataSource {
  final Dio httpClient;

  BannerDataSource({required this.httpClient});
  @override
  Future<List<BanerEntity>> getAll() async {
    final response = await httpClient.get('banner/slider');
    validateResponse(response);
    final baners = (response.data as List).map((e) {
      return BanerEntity.fromJson(e);
    }).toList();
    return baners;
  }
}
