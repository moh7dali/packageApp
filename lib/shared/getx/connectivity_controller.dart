// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get/get.dart';
//
// class ConnectivityService extends GetxController {
//   var connectionStatus = Rx<List<ConnectivityResult>>([ConnectivityResult.none]);
//
//   void checkConnection() async {
//     List<ConnectivityResult> result = await (Connectivity().checkConnectivity());
//     connectionStatus.value = result;
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     Connectivity().onConnectivityChanged.listen((result) {
//       connectionStatus.value = result;
//     });
//   }
// }
