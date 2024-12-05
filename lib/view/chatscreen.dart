import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_path_ai/controller/auth_controller.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();
  final AuthController chatController = Get.put(AuthController());
  ChatUser currentUser = ChatUser(id: '0', firstName: 'user');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(title: Text('Chat')), body: _buildUI()),
    );
  }

  Widget _buildUI() {
    return DashChat(
      currentUser: currentUser,
      onSend: onSend,
      messages: messages,
    );
  }

  void onSend() {}
}

// SafeArea buildSafeArea() {
//   return SafeArea(
//   child: Scaffold(
//     appBar: AppBar(
//       leading: IconButton(
//         onPressed: () {},
//         icon: Icon(Icons.arrow_back, color: Colors.white),
//       ),
//       title: Text(
//         'Chat',
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//       ),
//       centerTitle: true,
//       actions: [
//         IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.settings, color: Colors.white),
//         ),
//       ],
//       backgroundColor: Colors.black,
//     ),
//     body: Column(
//       children: [
//         SizedBox(height: 398),
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: TextField(
//             controller: messageController,
//             decoration: InputDecoration(
//               hintText: 'Ask anything...',
//               contentPadding: EdgeInsets.symmetric(
//                 vertical: 10.0,
//                 horizontal: 20.0,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               suffixIcon: IconButton(
//                 onPressed: () {},
//                 icon: Icon(Icons.send),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );
// }
