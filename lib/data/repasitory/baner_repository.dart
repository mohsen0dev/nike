import 'package:nike/data/models/baner_model.dart';
import 'package:nike/data/source/baner_source.dart';

abstract class IBannerRepository {
  Future<List<BanerEntity>> getAll();
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;

  BannerRepository({required this.dataSource});
  @override
  Future<List<BanerEntity>> getAll() {
    return dataSource.getAll();
  }
}
