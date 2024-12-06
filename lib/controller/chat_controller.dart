import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

    String geminiResponse = await getGeminiResponse(message);

    await _firestore.collection('chats').add({
      'uid': user.uid,
      'message': geminiResponse,
      'time': FieldValue.serverTimestamp(),
      'user': 'ai',
    });
  }

  Future<String> getGeminiResponse(String message) async {
    try {
      final response = await gemini.prompt(parts: [Part.text(message)]);
      return response?.output ?? 'No response from Gemini.';
    } catch (e) {
      return 'Error: $e';
    }
  }

  Stream<List<ChatMessage>> fetchMessages() {
    return _firestore
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ChatMessage(
              text: doc['text'],
              user: ChatUser(id: doc['uid'], firstName: doc['sender']),
              createdAt: (doc['item'] as Timestamp).toDate(),
            );
          }).toList();
        });
  }
}
