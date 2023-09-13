import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:news_app/general_news/controller/get_news_controller.dart';
import 'package:news_app/network/connectivity_controller.dart';

class ControllerBindings extends Bindings{
  @override
  void dependencies() {

        Get.put<Connectivity>(Connectivity(),permanent: true);
    Get.put<ConnectivityService>(ConnectivityService(Get.find<Connectivity>()),permanent: true);
      Get.lazyPut(() => GetNewsController());
    Get.find<GetNewsController>();
  }
}