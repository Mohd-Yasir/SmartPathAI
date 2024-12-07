import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  ChatUser currentUser = ChatUser(
    id: FirebaseAuth.instance.currentUser?.uid ?? '0',
    firstName: 'user',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Smart Path AI', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Chat Messages
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: chatController.fetchMessages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Failed to load messages'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Start the conversation!'));
                  }

                  // Chat Messages Display
                  return DashChat(
                    currentUser: currentUser,
                    messages: snapshot.data!,
                    onSend: (ChatMessage message) {
                      chatController.sendMessage(message.text);
                    },
                    messageOptions: MessageOptions(
                      showTime: true,
                      showOtherUsersName: true,
                      showOtherUsersAvatar: true,
                    ),
                    // avatarOptions: AvatarOptions(
                    //   avatarBuilder: (ChatUser user) {
                    //     return CircleAvatar(
                    //       backgroundColor: Colors.blue,
                    //       child: Text(
                    //         user.firstName?.substring(0, 1) ?? '',
                    //         style: const TextStyle(color: Colors.white),
                    //       ),
                    //     );
                    //   },
                    // ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
