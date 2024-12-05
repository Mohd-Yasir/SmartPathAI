import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:smart_path_ai/firebase_options.dart';
import 'package:smart_path_ai/view/chatscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_path_ai/view/login.dart';
import 'package:smart_path_ai/view/signup.dart';

const String Gemini_API_Key = 'AIzaSyATB6PJuCbH2ob6tE3bz7u8yLQwCvBZg1E';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: Gemini_API_Key);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Path AI',
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatScreen(),
    );
  }
}

// VerificationPage('email@email')
