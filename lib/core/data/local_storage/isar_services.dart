// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';

// class IsarServices {
//   late Future<Isar> db;
//   int? currentUserID;
//   IsarServices() {
//     db = openDB();
//   }

// // // ***************** DataBase open *****************
//   Future<Isar> openDB() async {
//     if (Isar.instanceNames.isEmpty) {
//       final path = await getApplicationDocumentsDirectory();
//       return await Isar.open([], directory: path.path, inspector: true);
//     }
//     return Future.value(Isar.getInstance());
//   }
// }
