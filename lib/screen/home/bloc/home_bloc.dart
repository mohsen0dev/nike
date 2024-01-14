import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/data/models/baner_model.dart';
import 'package:nike/data/models/prodoct_model.dart';
import 'package:nike/data/repasitory/baner_repository.dart';
import 'package:nike/data/repasitory/product_repository.dart';
import 'package:nike/utils/exeptions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;
  HomeBloc({required this.bannerRepository, required this.productRepository})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          final banners = await bannerRepository.getAll();
          final latestProducts = await productRepository.getAll(1);
          final popularProducts = await productRepository.getAll(2);
          emit(HomeSuccess(
              banner: banners,
              latestProduct: latestProducts,
              popularProduct: popularProducts));
        } catch (e) {
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
