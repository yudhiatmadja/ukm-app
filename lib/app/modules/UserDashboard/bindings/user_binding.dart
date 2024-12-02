import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class HomepageUBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageUController>(
      () => HomepageUController(),
    );
  }
}
