import 'package:flutter/cupertino.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:go_router/go_router.dart';

part 'add_edit_address_screen.g.dart';

@TypedGoRoute<AddEditAddressRoute>(path: AddEditAddressScreen.routeWzExtra)
@immutable
class AddEditAddressRoute extends GoRouteData with _$AddEditAddressRoute {
  const AddEditAddressRoute({required this.$extra});
  final AddressEntity? $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddEditAddressScreen(address: $extra);
  }
}

class AddEditAddressScreen extends StatefulWidget {
  const AddEditAddressScreen({super.key, this.address});
  static const routeWzExtra = '/address';
  final AddressEntity? address;
  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
