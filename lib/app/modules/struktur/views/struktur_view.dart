import 'package:flutter/material.dart';

class StrukturScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Struktur Organisasi'),
        backgroundColor: Colors.green, // Set the app bar color
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Static image at the top
            Container(
              height: 300.0,
              width: double.infinity,
              child: Image.asset('assets/struktur.png', fit: BoxFit.cover),
            ),
            SizedBox(height: 20),

            // Title section
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Pengurus Organisasi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Grid layout for organizational structure
            GridView.count(
              crossAxisCount: 2, // Two items per row
              shrinkWrap:
                  true, // Prevents the GridView from taking infinite height
              physics: NeverScrollableScrollPhysics(), // Disable scrolling
              padding: EdgeInsets.all(16.0),
              children: [
                _buildMemberCard(
                    'assets/cipung.png', 'Cipung Abubu', 'Ketua Umum'),
                _buildMemberCard(
                    'assets/abe.png', 'Abe Cekut', 'Wakil Ketua Umum'),
                _buildMemberCard('assets/ucel.png', 'Ucel', 'Sekretaris'),
                // Add more members here
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each member card
  Widget _buildMemberCard(String imagePath, String name, String position) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: 120.0,
            width: 120.0,
            child: ClipOval(
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            position,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
