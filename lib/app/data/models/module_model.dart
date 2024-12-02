// module_model.dart
class ModuleModel {
  String id; // Document ID from Firestore
  String title; // 'judul'
  String author; // 'penulis'
  String description; // 'deskripsi'
  String date; // 'date'

  ModuleModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.date,
  });

  // Convert ModuleModel to Firestore-compatible format
  Map<String, dynamic> toJson() {
    return {
      'judul': title,
      'penulis': author,
      'deskripsi': description,
      'date': date,
    };
  }

  // Create ModuleModel from Firestore document
  factory ModuleModel.fromJson(Map<String, dynamic> json, String id) {
    return ModuleModel(
      id: id,
      title: json['judul'],
      author: json['penulis'],
      description: json['deskripsi'],
      date: json['date'],
    );
  }
}
