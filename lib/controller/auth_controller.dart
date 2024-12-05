import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_path_ai/view/chatscreen.dart';
import 'package:smart_path_ai/view/verificationpage.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(String email, String password) async {
    try {
      print('Starting signup process for email: $email');

      // Create user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('User created successfully. User ID: ${userCredential.user?.uid}');

      User? user = userCredential.user;
      if (user == null) {
        print('User is null after creation');
        throw FirebaseAuthException(
          code: 'user-null',
          message: 'User instance is null after signup.',
        );
      }

      // Get the user's UID
      String uid = user.uid;
      print('Attempting to save user data with UID: $uid');

      // Save user data in Firestore (optional, since you removed username)
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('User data saved to Firestore successfully');

      // Send email verification
      await user.sendEmailVerification();
      print('Verification email sent');

      Get.to(VerificationPage(email));

      // Get.snackbar(
      //   'Verification Email Sent',
      //   'Please check your email to verify your account.',
      //   snackPosition: SnackPosition.BOTTOM,
      // );

      // Listen for auth state changes
      // _auth.authStateChanges().listen((User? currentUser) async {
      //
      //   print('Auth state changed. Current user: ${currentUser?.uid}');
      //
      //   if (currentUser != null) {
      //     await currentUser.reload(); // Refresh user data
      //     print('Email verified: ${currentUser.emailVerified}');
      //
      //     if (currentUser.emailVerified) {
      //       print('Navigating to ChatScreen');
      //       Get.offAll(() => ChatScreen());
      //     } else {
      //       print('Email not verified');
      //       Get.snackbar(
      //         'Email Not Verified',
      //         'Please verify your email before proceeding.',
      //         snackPosition: SnackPosition.BOTTOM,
      //       );
      //     }
      //   }
      // });
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException occurred');
      print('Error Code: ${e.code}');
      print('Error Message: ${e.message}');

      String errorMessage = 'An error occurred';
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled.';
          break;
        default:
          errorMessage = e.message ?? 'Unknown error occurred';
      }

      Get.snackbar(
        'SignUp Failed',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Unexpected error during signup');
      print('Error: $e');

      Get.snackbar(
        'SignUp Failed',
        'Something went wrong: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Future<void> signUp(String username, String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     String uid = userCredential.user!.uid;
  //     await _firestore.collection('users').doc(uid).set({
  //       'username': username,
  //       'email': email,
  //     });
  //
  //     await userCredential.user?.sendEmailVerification();
  //
  //     Get.snackbar(
  //       'Verification email Sent',
  //       'Please check your email to verify your email',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     await userCredential.user?.updateProfile(displayName: username);
  //
  //     Get.snackbar(
  //       'Success',
  //       'Signup successful! Welcome $username',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //
  //     _auth.authStateChanges().listen((User? user) {
  //       if (user != null && user.emailVerified) {
  //         Get.offAll(() => ChatScreen());
  //       }
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     String errorMessage = 'An error occurred';
  //     if (e.code == 'weak-password') {
  //       errorMessage = 'The password is too weak.';
  //     } else if (e.code == 'email-already-in-use') {
  //       errorMessage = 'The account already exists for that email.';
  //     }
  //     Get.snackbar(
  //       'SignUp Failed',
  //       errorMessage,
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.redAccent,
  //       colorText: Colors.white,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'SignUp Failed',
  //       'Something went wrong.',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        if (user.emailVerified) {
          Get.offAll(ChatScreen());
        } else {
          Get.snackbar(
            'Email not verified',
            'Please verify your email before logging in.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect Password';
          break;
        case 'network-request-failed':
          errorMessage = 'Please check you internet connection';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later';
      }
      Get.snackbar(
        'Login Failed',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
