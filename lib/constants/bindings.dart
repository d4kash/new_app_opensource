import 'package:get/get.dart';
import 'package:news_app/general_news/controller/get_news_controller.dart';

class ControllerBindings extends Bindings{
  @override
  void dependencies() {
      Get.lazyPut(() => GetNewsController());
    Get.find<GetNewsController>();
  }
}