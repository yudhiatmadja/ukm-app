import 'package:get/get.dart';
import 'package:ukm_app/app/data/services/weather_service.dart';

class HomepageUController extends GetxController {
  final weather = {}.obs;
  final WeatherService weatherService = WeatherService();

  @override
  void onInit() {
    super.onInit();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      final data = await weatherService.getWeather('Malang');
      weather.value = data;
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }
}
