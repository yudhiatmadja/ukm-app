import 'package:get/get.dart';

import '../controllers/addkegiatan_controller.dart';

class AddkegiatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddkegiatanController>(
      () => AddkegiatanController(),
    );
  }
}
