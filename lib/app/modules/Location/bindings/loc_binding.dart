import 'package:get/get.dart';

import '../controllers/loc_controller.dart';

class LokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LokasiController>(
          () => LokasiController(),
    );
  }
}
