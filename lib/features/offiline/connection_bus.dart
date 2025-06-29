// import 'package:gazzer/core/domain/app_bus.dart';
// import 'package:gazzer/features/offiline/connection_events.dart';

// class ConnectionBus extends AppBus {
//   ConnectionBus._();
//   static final _inst = ConnectionBus._();
//   static ConnectionBus get inst => _inst;

//   bool _hasConnection = true;
//   bool get hasConnection => _hasConnection;

//   Future<void> checkConnection() async {
//     fire(ConnectionStatusEvent(RequestStates.loading));
//     final connection = InternetConnection.createInstance(
//       customCheckOptions: [
//         InternetCheckOption(uri: Uri.parse(ApiClient.mainDomain), timeout: const Duration(seconds: 40)),
//       ],
//     );
//     await connection.hasInternetAccess.then((value) {
//       _hasConnection = value;
//       fire(ConnectionStatusEvent(value ? RequestStates.success : RequestStates.error));
//     });
//   }

//   void emitNoConnectionState() {
//     fire(ConnectionStatusEvent(RequestStates.error));
//   }
// }
