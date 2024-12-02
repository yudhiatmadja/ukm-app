import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/modul_controller.dart';

class BacaModulScreen extends StatelessWidget {
  final ModulController _modulController = Get.find(); // Fetch the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modul'),
        backgroundColor: Color(0xFF089E55),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Container(
        width: 435,
        height: 917.90,
        child: Stack(
          children: [
            // Background Container
            Positioned(
              left: 28,
              top: 85,
              child: Container(
                width: 383,
                height: 671,
                decoration: BoxDecoration(color: Color(0xFFF3FFF9)),
                child: Obx(() {
                  final module = _modulController
                      .selectedModule.value; // Get the selected module
                  if (module == null) {
                    return Center(
                      child: Text(
                          "No module selected"), // Handle the case when no module is selected
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module.title, // Access property from ModulModel
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          module.date, // Access property from ModulModel
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 16),
                        Text(
                          module.description, // Access property from ModulModel
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            // Page Indicator
            Positioned(
              left: 291,
              top: 715,
              child: SizedBox(
                width: 107,
                height: 19,
                child: Text(
                  '', // Placeholder for page number
                  style: TextStyle(
                    color: Color(0xFF292929),
                    fontSize: 20.17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            Positioned(
              left: 16,
              top: 700,
              child: SizedBox(
                width: 383,
                height: 51,
                child: Container(
                  decoration: ShapeDecoration(
                    color: Color(0xFFFFC3C3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.48),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Download Modul',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
