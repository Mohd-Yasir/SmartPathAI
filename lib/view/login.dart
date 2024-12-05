import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_path_ai/controller/auth_controller.dart';
import 'package:smart_path_ai/view/signup.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  RxBool _obscureText = true.obs;

  Login({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                'assets/bg.if',
                fit: BoxFit.cover,
                errorBuilder: (content, error, StackTrace) {
                  return Container(color: Colors.blue[900]);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05)),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 130),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome\nBack',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 45,
                        ),
                      ),
                    ),
                    const SizedBox(height: 130),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: 'Enter you email',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            width: 2.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Obx(
                      () => TextField(
                        controller: _passwordController,
                        obscureText: _obscureText.value,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.white),
                          hintText: 'Enter you password',
                          hintStyle: const TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _obscureText.value = !_obscureText.value;
                            },
                            icon: Icon(
                              _obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2.0,
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              width: 2.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    ElevatedButton(
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        if (email.isNotEmpty && password.isNotEmpty) {
                          _authController.login(email, password);
                        } else {
                          Get.snackbar(
                            'Error',
                            'All fields are required',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.white30,
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.off(Signup());
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
