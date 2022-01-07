import 'package:get/get.dart';
import 'package:aactivpay/screen/export.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
