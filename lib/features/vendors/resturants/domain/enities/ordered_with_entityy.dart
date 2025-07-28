import 'package:equatable/equatable.dart';

class OrderedWithEntityy extends Equatable {
  final int id;
  final String name;
  final String image;
  final double rate;
  final double price;

  const OrderedWithEntityy({
    required this.id,
    required this.name,
    required this.image,
    required this.rate,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, image, rate, price];
}
