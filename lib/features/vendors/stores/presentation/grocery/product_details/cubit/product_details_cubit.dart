import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/product_details_response.dart';
import 'package:gazzer/features/vendors/stores/domain/stores_repo.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/cubit/product_details_states.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final StoresRepo _repo;
  final int productId;
  ProductDetailsCubit(this._repo, this.productId) : super(ProductDetailsInitial()) {
    loadProductDetails();
  }

  Future<void> loadProductDetails() async {
    emit(ProductDetailsLoading());
    final result = await _repo.loadProductDetails(productId);
    switch (result) {
      case Ok<ProductDetailsResponse> ok:
        emit(ProductDetailsLoaded(product: ok.value.product, orderedWith: ok.value.orderedWith));
        break;
      case Err error:
        emit(ProductDetailsError(error.error.message));
        break;
    }
  }

  @override
  void emit(ProductDetailsState state) {
    if (isClosed) return;
    super.emit(state);
  }
}
