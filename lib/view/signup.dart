import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_path_ai/controller/auth_controller.dart';
import 'login.dart';

class Signup extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  final RxBool _obscureText = true.obs;

  Signup({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                'assets/bg.gf',
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
                        'Create\nAccount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    const SizedBox(height: 15.0),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: 'Enter your email',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2.5,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
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
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    ElevatedButton(
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        if (email.isNotEmpty && password.isNotEmpty) {
                          authController.signUp(email, password);
                        } else {
                          Get.snackbar(
                            'Error',
                            'All fields are required',
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.white30,
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Row(
                      children: [
                        SizedBox(width: 70.0),
                        Expanded(
                          child: Divider(color: Colors.white, thickness: 1.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: Colors.white, thickness: 1.0),
                        ),
                        SizedBox(width: 70.0),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Color(0xFF4285F4),
                            size: 24,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: Color(0xFFDB4437),
                            size: 24,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Already have an account ?',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.off(Login());
                          },
                          child: const Text(
                            'Log in',
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
