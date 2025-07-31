import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';

export 'package:gazzer/core/presentation/extensions/enum.dart';

class FavoriteEntity extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String imageUrl;
  final double rate;
  final double? price;
  final FavoriteType type; // e.g., 'restaurant', 'grocery', 'pharmacy'

  const FavoriteEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
    this.description,
    this.rate = 0.0,
    this.price,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrl, rate, price, type];
}
