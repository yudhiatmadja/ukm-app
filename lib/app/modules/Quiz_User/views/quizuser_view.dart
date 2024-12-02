import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../controllers/quizuser_controller.dart';

class QuizUserView extends GetView<QuizUserController> {
  const QuizUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          FirebaseAuth.instance.currentUser?.email ?? 'User',
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('quizzes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No quizzes available'));
          }
          final quizzes = snapshot.data!.docs;
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              final quizData = quizzes[index];
              // Convert the timestamp to a readable string
              String formattedDate = '';
              if (quizData['date'] is Timestamp) {
                formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(quizData['date'].toDate());
              }

              return buildQuizCard(
                quizData['title'],
                formattedDate,
                quizData['description'],
                quizData['correctAnswer'], // Access the correct answer
                quizData['options'], // Access the options
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Modules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildQuizCard(String title, String date, String description, String correctAnswer, List<dynamic> options) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.image, size: 50.0),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    Text(date, style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                    SizedBox(height: 8.0),
                    Text(description),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            buildAnswerSection(options, correctAnswer), // Pass the correct answer to the answer section
          ],
        ),
      ),
    );
  }

  Widget buildAnswerSection(List<dynamic> options, String correctAnswer) {
    String? selectedOption; // Track selected option

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose an answer:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...options.map((option) {
          return RadioListTile(
            title: Text(option),
            value: option,
            groupValue: selectedOption, // Set the currently selected option
            onChanged: (value) {
              selectedOption = value as String;
              // Check if the selected answer is correct
              if (selectedOption == correctAnswer) {
                // Show success animation
                showSuccessAnimation();
              } else {
                // Handle incorrect answer without showing animation
                Get.snackbar('Incorrect', 'Try again!',
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
          );
        }).toList(),
      ],
    );
  }

  void showSuccessAnimation() {
    Get.dialog(
      AlertDialog(
        content: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 40),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Correct Answer!',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    // Close the dialog after a delay
    Future.delayed(Duration(seconds: 2), () {
      Get.back(); // Close the dialog
    });
  }
}

void main() {
  runApp(GetMaterialApp(
    home: QuizUserView(),
  ));
}
