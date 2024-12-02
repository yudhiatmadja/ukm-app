import 'package:get/get.dart';

import '../controllers/admin_controller.dart';

class HomepageABinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageAController>(
      () => HomepageAController(),
    );
  }
}
