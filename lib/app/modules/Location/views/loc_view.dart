import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/loc_controller.dart';

class LokasiView extends GetView<LokasiController> {
  final LokasiController locationController = Get.put(LokasiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE1D0),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Saya Tersesat",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => locationController.getCurrentLocation(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(
                "Titik Koordinat\nLintang: ${locationController.latitude.value}\nBujur: ${locationController.longitude.value}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => locationController.getCurrentLocation(),
                child: const Text("Cari Lokasi"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => locationController.openGoogleMaps(),
                child: const Text("Buka Google Maps"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}