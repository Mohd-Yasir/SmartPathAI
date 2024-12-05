import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final response;
  final Gemini gemini = Gemini.instance;

  Future<void> sendMessage(String message) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return;
    }
    await _firestore.collection('chats').add({
      'uid': user.uid,
      'message': message,
      'time': FieldValue.serverTimestamp(),
      'sender': 'user',
    });

    Future<String> GetGeminiResponse(String message) async {
      try {
        response = await gemini.prompt(parts: [Part.text(message)]);
        return response?.output ?? 'No response from Gemini.';
      } catch (e) {
        return 'Error: $e';
      }
    }

    await _firestore.collection('chats').add({
      'uid': user.uid,
      'message': response,
      'time': FieldValue.serverTimestamp(),
      'user': 'ai',
    });
  }
}
