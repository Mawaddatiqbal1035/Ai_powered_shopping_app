
import 'package:ai_powered_shopping/core/share_service/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/utils/app_authentication_texts_expanded.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = MediaQuery.of(context).size;
    final onBoardControllerSignUp=Get.find<FirebaseAuthentication>();
    return SafeArea(
        child:
        Scaffold(
          backgroundColor: Color(0xFF152049),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    // Top container
                    Container(
                      width: s.width * 0.25,
                      height: s.height * 0.07,
                      decoration: BoxDecoration(
                        color: const Color(0xff00ff75),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          AppAuthenticationTextsExpanded.signup,
                          style: TextStyle(
                            fontSize: s.width * 0.020 + s.height * 0.019,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),


                    // Form
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Name
                          Text(
                            AppAuthenticationTextsExpanded.userName,
                            style:TextStyle(color:  Colors.white,fontSize: s.width * 0.015 + s.height * 0.015,
                              fontWeight: FontWeight.bold,)
                          ),
                          const SizedBox(height: 3),
                          TextField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              hintText: 'UserName',
                              fillColor: const Color(0xff2d418b),
                              helperText: "Enter UserName",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              hintStyle: const TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            textAlign: TextAlign.center,
                          ),

                          // Email
                          const SizedBox(height: 12),
                          Text(
                            AppAuthenticationTextsExpanded.eMail,
                              style:TextStyle(color:  Colors.white,fontSize: s.width * 0.015 + s.height * 0.015,
                                fontWeight: FontWeight.bold,)
                          ),
                          const SizedBox(height: 3),
                          TextField(
                            controller: emailTextController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              fillColor: Colors.white,
                              helperText: "Enter Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              hintStyle: const TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            textAlign: TextAlign.center,
                          ),

                          // Password
                          const SizedBox(height: 12),
                          Text(
                            AppAuthenticationTextsExpanded.signupPassword,
                              style:TextStyle(color:  Colors.white,fontSize: s.width * 0.015 + s.height * 0.015,
                                fontWeight: FontWeight.bold,)
                          ),
                          const SizedBox(height: 3),
                          TextField(
                            controller: passwordTextController,
                            decoration: InputDecoration(
                              hintText: AppAuthenticationTextsExpanded.signupPasswordHintText,
                              fillColor: const Color(0xff00ff75),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              hintStyle: TextStyle(
                                fontSize: s.width * 0.013 + s.height * 0.010,
                                color: Colors.black,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // SignUp Button
                    ElevatedButton(
                      onPressed: () {
                        onBoardControllerSignUp.signUp(
                          emailTextController.text.trim(),
                          passwordTextController.text.trim(),
                          context,
                          userNameController.text.trim(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        shadowColor: Colors.grey,
                        elevation: 4.89,
                        fixedSize: Size(s.width * 0.16, s.height * 0.16),
                        backgroundColor: Color(0xff2d418b),
                      ),
                      child: const Icon(Icons.login, color: Color(0xFF1C1B1F)),
                    ),

                    const SizedBox(height: 20),

                    // Or Signup With
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color:  Color(0xff2d418b),
                            endIndent: 15,
                          ),
                        ),
                        Text(
                          AppAuthenticationTextsExpanded.orSignupWith,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          )
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Color(0xff2d418b),
                            indent: 15,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Social Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2d418b),
                            fixedSize: Size(s.height * 0.130, s.width * 0.080),
                            shape: const BeveledRectangleBorder(),
                          ),
                          child: const Icon(Icons.g_mobiledata_rounded,
                              color: Color(0xff00ff75)),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2d418b),
                            fixedSize: Size(s.height * 0.130, s.width * 0.080),
                            shape: const BeveledRectangleBorder(),
                          ),
                          child: const Icon(Icons.facebook, color: Color(0xff00ff75)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Already have account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppAuthenticationTextsExpanded.alreadyHaveAccount,
                          style: TextStyle(
                            fontSize: s.width * 0.010 + s.height * 0.010,
                            color: const Color(0xff00ff75),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) => LoginScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2d418b),
                          ),
                          child: Text(AppAuthenticationTextsExpanded.loginNow,
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        ));


  }
}
