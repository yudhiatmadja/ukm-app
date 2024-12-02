import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ukm_app/app/modules/Quiz/controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('quizzes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final quizzes = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              var quiz = quizzes[index];
              return buildQuizCard(quiz);
            },
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showAddQuizDialog();
              },
              child: Text('Add Quiz'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ),
          BottomNavigationBar(
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
        ],
      ),
    );
  }

  Widget buildQuizCard(DocumentSnapshot quiz) {
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
                      quiz['title'],
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      quiz['date'].toDate().toString(), // Adjust date format as needed
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    SizedBox(height: 8.0),
                    Text(quiz['description']),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    deleteQuiz(quiz.id);
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                  label: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
                TextButton.icon(
                  onPressed: () {
                    showEditDialog(quiz);
                  },
                  icon: Icon(Icons.edit, color: Colors.grey),
                  label: Text('Edit', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteQuiz(String quizId) {
    FirebaseFirestore.instance.collection('quizzes').doc(quizId).delete().then((_) {
      Get.snackbar('Success', 'Quiz deleted successfully.',
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to delete quiz: $error',
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  void showAddQuizDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final answerControllers = List.generate(4, (index) => TextEditingController());

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Quiz', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 16.0),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Enter quiz title', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Enter quiz description', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16.0),
                Text('Answers:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...['A', 'B', 'C', 'D'].map((option) {
                  int index = ['A', 'B', 'C', 'D'].indexOf(option);
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      controller: answerControllers[index],
                      decoration: InputDecoration(hintText: 'Answer $option', border: OutlineInputBorder()),
                    ),
                  );
                }).toList(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        addQuiz(
                          titleController.text,
                          descriptionController.text,
                          answerControllers.map((controller) => controller.text).toList(),
                        );
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addQuiz(String title, String description, List<String> answers) {
    FirebaseFirestore.instance.collection('quizzes').add({
      'title': title,
      'description': description,
      'date': DateTime.now(),
      'answers': answers,
    }).then((_) {
      Get.snackbar('Success', 'Quiz added successfully.',
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to add quiz: $error',
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  void showEditDialog(DocumentSnapshot quiz) {
    final titleController = TextEditingController(text: quiz['title']);
    final descriptionController = TextEditingController(text: quiz['description']);
    final answerControllers = (quiz['answers'] as List).map((answer) => TextEditingController(text: answer)).toList();

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit Quiz', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 16.0),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Enter quiz title', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Enter quiz description', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16.0),
                Text('Answers:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...['A', 'B', 'C', 'D'].asMap().entries.map((entry) {
                  int index = entry.key;
                  String option = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      controller: answerControllers[index],
                      decoration: InputDecoration(hintText: 'Answer $option', border: OutlineInputBorder()),
                    ),
                  );
                }).toList(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateQuiz(quiz.id, titleController.text, descriptionController.text, answerControllers.map((controller) => controller.text).toList());
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Update'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void updateQuiz(String quizId, String title, String description, List<String> answers) {
    FirebaseFirestore.instance.collection('quizzes').doc(quizId).update({
      'title': title,
      'description': description,
      'answers': answers,
    }).then((_) {
      Get.snackbar('Success', 'Quiz updated successfully.',
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to update quiz: $error',
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  void addQuizToFirestore(String title, String description, List<String> options, String correctAnswer) {
    FirebaseFirestore.instance.collection('quizzes').add({
      'title': title,
      'date': FieldValue.serverTimestamp(),
      'description': description,
      'options': options,
      'correctAnswer': correctAnswer,
    });
  }
}
