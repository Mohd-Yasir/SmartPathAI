import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_path_ai/controller/auth_controller.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();
  final AuthController chatController = Get.put(AuthController());

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            'Chat',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings, color: Colors.white),
            ),
          ],
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            SizedBox(height: 398),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Ask anything...',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
