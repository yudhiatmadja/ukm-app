import 'package:get/get.dart';

import '../controllers/admin_absen_controller.dart';

class AdminAbsenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAbsenController>(
      () => AdminAbsenController(),
    );
  }
}
