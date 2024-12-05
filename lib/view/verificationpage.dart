import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smart_path_ai/view/login.dart';

class VerificationPage extends StatelessWidget {
  late String email;
  VerificationPage(this.email);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 43, top: 25),
          child: Card(
            color: Colors.white,
            shadowColor: Colors.grey,
            elevation: 50,
            child: SizedBox(
              height: 240,
              width: 300,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Email Verification Sent',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        text: "A verification email has been sent to",
                        children: [
                          TextSpan(
                            text: ' $email. ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                'Please check your inbox and click the verification link to activate your account.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Get.off(Login());
                      },
                      child: Text(
                        'back to login page',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
