import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class DocsController {
  XFile? pickedFile;
  VideoPlayerController? videoController;
  final AudioPlayer audioPlayer = AudioPlayer();
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  String? recordedAudioPath;
  bool _isRecording = false;  // Track recording state
  stt.SpeechToText _speech = stt.SpeechToText();
  String _spokenText = '';

  // Firebase instances
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Future<XFile?> takePhoto() async {
    final picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.camera);
  }

  Future<XFile?> recordVideo() async {
    final picker = ImagePicker();
    return await picker.pickVideo(source: ImageSource.camera);
  }

  Future<VideoPlayerController?> initializeVideo(String path) async {
    final controller = VideoPlayerController.file(File(path));
    await controller.initialize();
    return controller;
  }

  Future<void> playAudio(String path) async {
    await audioPlayer.play(AssetSource(path));
  }

  Future<String?> recordAudio() async {
    try {
      if (_audioRecorder.isRecording) {
        print("Already recording.");
        return null;
      }

      final directory = await Directory.systemTemp.createTemp();
      final audioPath = '${directory.path}/audio_recording.aac';

      await _audioRecorder.startRecorder(toFile: audioPath);
      print("Recording started: $audioPath");
      _isRecording = true;
      return audioPath;
    } catch (e) {
      print("Error starting recording: $e");
      return null;
    }
  }

  Future<void> stopRecording() async {
    if (_isRecording) {
      try {
        await _audioRecorder.stopRecorder();
        print("Recording stopped.");
        _isRecording = false;
      } catch (e) {
        print("Error stopping recording: $e");
      }
    }
  }

  Future<void> uploadFile(XFile file, String fileType) async {
    try {
      // Upload the file to Firebase Storage
      String filePath = 'docs/${DateTime.now().millisecondsSinceEpoch}_${file.name}';
      UploadTask uploadTask = _storage.ref(filePath).putFile(File(file.path));

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Save file metadata in Firestore
      await _firestore.collection('docs').add({
        'filePath': downloadUrl,
        'fileType': fileType,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error uploading file: $e");
    }
  }

  Future<void> uploadAudio(String audioPath) async {
    try {
      // Upload audio to Firebase Storage
      String filePath = 'docs/audio/${DateTime.now().millisecondsSinceEpoch}_audio.aac';
      UploadTask uploadTask = _storage.ref(filePath).putFile(File(audioPath));

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Save audio metadata in Firestore
      await _firestore.collection('docs').add({
        'filePath': downloadUrl,
        'fileType': 'audio',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error uploading audio: $e");
    }
  }

  // Upload photo, video, or audio based on the current file type
  Future<void> handleFileUpload() async {
    if (pickedFile != null) {
      if (pickedFile!.path.endsWith(".mp4")) {
        // If it's a video
        await uploadFile(pickedFile!, 'video');
      } else if (pickedFile!.path.endsWith(".jpg") || pickedFile!.path.endsWith(".png")) {
        // If it's a photo
        await uploadFile(pickedFile!, 'photo');
      }
    } else if (recordedAudioPath != null) {
      // If audio is recorded
      await uploadAudio(recordedAudioPath!);
    }
  }

  // Initialize recorder
  Future<void> initializeRecorder() async {
    try {
      await _audioRecorder.openRecorder();
      print("Recorder initialized.");
    } catch (e) {
      print("Error initializing recorder: $e");
    }
  }

  // Dispose resources
  void dispose() {
    _audioRecorder.closeRecorder();
    videoController?.dispose();
    audioPlayer.dispose();
    _speech.stop();
  }
}
