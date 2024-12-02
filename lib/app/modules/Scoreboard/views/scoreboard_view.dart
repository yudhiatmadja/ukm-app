import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ukm_app/app/modules/Scoreboard/controllers/scoreboard_controller.dart';

class ScoreboardPage extends GetView<ScoreboardController> {
  const ScoreboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Scoreboard',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Card for user 1
              ScorebordCard(
                profileImage:
                    'URL_PROFILE_IMAGE', // Ganti dengan URL foto profil
                username: 'David',
                rank: '#1',
                score: '10/10',
                percentage: 100,
                progressColor: Colors.green,
                percentageColor: Colors.green,
              ),
              SizedBox(height: 16.0),

              // Card for user 2
              ScorebordCard(
                profileImage: 'URL_PROFILE_PLACEHOLDER', // Gambar placeholder
                username: 'Username',
                rank: '#2',
                score: '7/10',
                percentage: 70,
                progressColor: Colors.green,
                percentageColor: Colors.green,
              ),
              SizedBox(height: 16.0),

              // Card for user 3
              ScorebordCard(
                profileImage: 'URL_PROFILE_PLACEHOLDER',
                username: 'Username',
                rank: '#3',
                score: '5/10',
                percentage: 50,
                progressColor: Colors.yellow,
                percentageColor: Colors.yellow,
              ),
              SizedBox(height: 16.0),

              // Card for user 4
              ScorebordCard(
                profileImage: 'URL_PROFILE_PLACEHOLDER',
                username: 'Username',
                rank: '#4',
                score: '4/10',
                percentage: 40,
                progressColor: Colors.red,
                percentageColor: Colors.red,
              ),
              SizedBox(height: 16.0),

              // Card for user 5
              ScorebordCard(
                profileImage: 'URL_PROFILE_PLACEHOLDER',
                username: 'Username',
                rank: '#5',
                score: '3/10',
                percentage: 30,
                progressColor: Colors.red,
                percentageColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ScorebordCard({
    required String profileImage,
    required String username,
    required String rank,
    required String score,
    required int percentage,
    required Color progressColor,
    required Color percentageColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          // Profile Image
          CircleAvatar(
            backgroundImage: NetworkImage(profileImage),
            radius: 30.0,
          ),
          SizedBox(width: 16.0),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Text(
                      rank,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(score),
                SizedBox(height: 8.0),

                // Progress Bar
                Stack(
                  children: [
                    Container(
                      height: 8.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Container(
                      height: 8.0,
                      width: percentage.toDouble() * 2.0, // Skala progres
                      decoration: BoxDecoration(
                        color: progressColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Percentage Box
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: percentageColor.withOpacity(0.1),
              border: Border.all(color: percentageColor, width: 2.0),
            ),
            child: Text(
              '$percentage%',
              style: TextStyle(color: percentageColor),
            ),
          ),
        ],
      ),
    );
  }
}
