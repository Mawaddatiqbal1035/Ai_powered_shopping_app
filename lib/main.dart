import 'package:ai_powered_shopping/core/share_service/firebase_authentication.dart';
import 'package:ai_powered_shopping/features/ai_based_shopping/presentation/screens/ai_shopping_screen.dart';
import 'package:ai_powered_shopping/features/authentication/presentation/screens/login_screen.dart';
import 'package:ai_powered_shopping/features/authentication/presentation/screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'core/dependency_injections/app_dependency_injection.dart';
import 'core/share_service/firbase_firestore_database.dart';
import 'features/ai_based_shopping/presentation/controller/gemini_recommend_product_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencyInjection().init();
  final apiKey="AIzaSyBx1TtxkLfxz0rJFl97dNKqoR3O667jFi4";
  Gemini.init(apiKey: apiKey);
  final geminiController=Get.put(GeminiRecommendProductController());
  final firebaseFirstore=Get.put( FirbaseFirestoreDatabase());
  final firebaseAuthenticationController=Get.put(FirebaseAuthentication());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
   home:Obx((){
     final firebaseAuthenticationController=Get.find<FirebaseAuthentication>();
     return firebaseAuthenticationController.isLogin.value==true?AiShoppingScreen():SignupScreen();
   })
    );
  }
}
