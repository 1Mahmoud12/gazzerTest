import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/ordered_with_entityy.dart';

sealed class OrderedWithStates {
  final List<OrderedWithEntityy> items;
  OrderedWithStates({required this.items});
}

class OrderedWithInitial extends OrderedWithStates {
  OrderedWithInitial() : super(items: []);
}

class OrderedWithLoading extends OrderedWithStates {
  OrderedWithLoading()
    : super(
        items: List.generate(
          3,
          (index) => OrderedWithEntityy(id: index, name: 'Item index', image: Fakers.netWorkImage, price: 0, rate: 3),
        ),
      );
}

class OrderedWithLoaded extends OrderedWithStates {
  OrderedWithLoaded({required super.items});
}

class OrderedWithError extends OrderedWithStates {
  final String message;
  OrderedWithError({required this.message}) : super(items: []);
}
