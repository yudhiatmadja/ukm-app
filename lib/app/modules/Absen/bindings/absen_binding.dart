import 'package:get/get.dart';
import 'package:ukm_app/app/modules/Absen/controllers/absen_controller.dart';

class AbsenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbsenController>(
      () => AbsenController(),
    );
  }
}
