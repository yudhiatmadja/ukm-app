import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Get the user role from Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();

      if (userDoc.exists) {
        String role = userDoc['role'] ?? 'user'; // Default to 'user' if role is not found

        // Redirect based on the role
        if (role == 'admin') {
          Get.snackbar('Success', 'Login successful as Admin', backgroundColor: Colors.green);
          Get.offAllNamed('/homepage_a'); // Redirect to admin homepage
        } else {
          Get.snackbar('Success', 'Login successful as User', backgroundColor: Colors.green);
          Get.offAllNamed('/homepage_u'); // Redirect to user homepage
        }
      } else {
        Get.snackbar('Error', 'User role not found', backgroundColor: Colors.red);
      }
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential = await _auth.signInWithCredential(credential);

        // Get the user role from Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();

        if (userDoc.exists) {
          String role = userDoc['role'] ?? 'user'; // Default to 'user' if role is not found

          // Redirect based on the role
          if (role == 'admin') {
            Get.snackbar('Success', 'Logged in with Google as Admin', backgroundColor: Colors.green);
            Get.offAllNamed('/homepage_a'); // Redirect to admin homepage
          } else {
            Get.snackbar('Success', 'Logged in with Google as User', backgroundColor: Colors.green);
            Get.offAllNamed('/homepage_u'); // Redirect to user homepage
          }
        } else {
          Get.snackbar('Error', 'User role not found', backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
