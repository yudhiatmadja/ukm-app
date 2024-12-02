import 'package:get/get.dart';

import '../controllers/scoreboard_controller.dart';

class ScoreboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScoreboardController>(
      () => ScoreboardController(),
    );
  }
}
