import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/crashlytics_repo_imp.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/best_popular/data/repositories/best_popular_repository_impl.dart';
import 'package:gazzer/features/home/best_popular/domain/repositories/best_popular_repository.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class BestPopularCubit extends Cubit<BestPopularStates> {
  final BestPopularRepository _repository;

  BestPopularCubit({required BestPopularRepository repository}) : _repository = repository, super(BestPopularLoadingState());

  static BestPopularCubit create() {
    return BestPopularCubit(
      repository: BestPopularRepositoryImpl(
        ApiClient(),
        CrashlyticsRepoImp(),
      ),
    );
  }

  Future<void> getBestPopularStores() async {
    emit(BestPopularLoadingState());

    final result = await _repository.getBestPopularStores();

    switch (result) {
      case Ok<List<StoreEntity>> ok:
        emit(BestPopularSuccessState(stores: ok.value));
        break;
      case Err<List<StoreEntity>> err:
        emit(BestPopularErrorState(error: err.error.message));
        break;
    }
  }
}
