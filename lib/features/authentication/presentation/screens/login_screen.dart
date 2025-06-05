import 'package:ai_powered_shopping/core/share_service/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_authentication_texts_expanded.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordTextController = TextEditingController();
  final eMailTextController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final onBoardControllerSignUp = Get.find<FirebaseAuthentication>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF152049),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Login Button
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: s.width * 0.27,
                        height: s.height * 0.07,
                        decoration: BoxDecoration(
                          color: const Color(0xff00ff75),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            AppAuthenticationTextsExpanded.login,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: s.width * 0.020 + s.height * 0.020,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Image
                SvgPicture.asset(
                  'assets/login.svg',
                  height: s.height * 0.250 + s.width * 0.200,
                ),
                const SizedBox(height: 1),

                // Email TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: eMailTextController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Color(0xff2d418b),
                      helperText: "Enter Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Password TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: passwordTextController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      fillColor: Colors.white,
                      helperText: "Enter Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Remember Me & Forget Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Color(0xff00ff75),
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                          ),
                          Text(
                            AppAuthenticationTextsExpanded.rememberMe,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Login Icon Button
                ElevatedButton(
                  onPressed: () {
                    print('Pressed elevated button');
                    onBoardControllerSignUp.login(
                      email: eMailTextController.text.trim(),
                      password: passwordTextController.text.trim(),
                      context: context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff00ff75),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    elevation: 4.5,
                    fixedSize: Size(s.width * 0.19, s.height * 0.19),
                  ),
                  child: const Icon(Icons.login),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
