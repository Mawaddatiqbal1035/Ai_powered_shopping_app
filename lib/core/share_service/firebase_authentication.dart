import 'package:ai_powered_shopping/features/ai_based_shopping/presentation/screens/ai_shopping_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:either_dart/either.dart';

import '../error_handling/auth_failure.dart';
import '../utils/app_authentication_texts_expanded.dart';

class FirebaseAuthentication extends GetxController{

Rx<bool> isLogin=false.obs;
 FirebaseAuth auth=FirebaseAuth.instance;
Rx<User?> _user = Rx<User?>(null);
User? get currentUser => _user.value;

final emailController=TextEditingController();
final passwordController=TextEditingController();


bool isValidEmail(String? email) {
 if (email == null || email.isEmpty) return false;

 final emailRegex = RegExp(
     r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
 return emailRegex.hasMatch(email);
}

Future<void> login({required String email, required String password,required
BuildContext context}) async {
 _user = Rx<User?>(auth.currentUser);
 try {
  await auth.signInWithEmailAndPassword(email: email, password: password);
  Navigator.push(context, MaterialPageRoute(builder: (context)=>AiShoppingScreen()));
 } catch (e) {
  if (e is FirebaseAuthException) {
   Get.snackbar("Login Failed", e.message ?? "Error in login",
       backgroundColor: Colors.red);
  } else {
   Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
  }
 }
}


signUp(String email, String password,
    BuildContext context,String userName) async {
 try {
  final signUser=  await auth.createUserWithEmailAndPassword(
      email: email, password: password);
  signUser.user?.updateDisplayName(userName);
  signUser.user?.reload();
  final currentUser = auth.currentUser;
   Navigator.push(context, MaterialPageRoute(builder: (context)=>AiShoppingScreen()));
 } catch (e) {
  if (e is FirebaseAuthException) {
   switch (e.code) {
    case 'user-not-found':
     return Left(AuthFailure(
         field: 'email',
         code: e.code,
         Message: AppAuthenticationTextsExpanded.noUserFound));
    case 'wrong-password':
     return Left(AuthFailure(
         field: 'password',
         code: e.code,
         Message: AppAuthenticationTextsExpanded.incorrectPassword));
    case 'invalid-email':
     return Left(AuthFailure(
         field: 'email',
         code: e.code,
         Message: AppAuthenticationTextsExpanded.invalidEmail));
    case 'user-disabled':
     return Left(AuthFailure(
         field: 'email',
         code: e.code,
         Message: AppAuthenticationTextsExpanded.userDisabled));
    case 'too-many-requests':
     return Left(AuthFailure(
         code: e.code,
         Message: AppAuthenticationTextsExpanded.tooManyRequests));
    case 'network-request-failed':
     return Left(AuthFailure(
         code: e.code,
         Message: AppAuthenticationTextsExpanded.networkError));
    case 'invalid-credential':
     return Left(AuthFailure(
         code: e.code,
         Message: AppAuthenticationTextsExpanded.invalidCredential));
    default:
     return Left(AuthFailure(
         code: e.code,
         Message:
         "${AppAuthenticationTextsExpanded.authError} ${e.code} ${e
             .message}"));
   }
  }
 }
}



Rx<String> passward='123'.obs;
Rx<String> eMail='123'.obs;
Rx<bool> isError=false.obs;
Rx<bool> ischeck=false.obs;
Rx<bool> forGet=false.obs;




login1({required String passw,required String userEmail}){
 isLogin.value=  passw==passward.value&&userEmail==eMail.value?  true:false;
 print(isLogin);
}


signUp2({required String userPassword,required String confirmPass,required String userName}){
 if(userPassword==passward.value&&confirmPass==userPassword)
 {
  isLogin.value=   true;
  isError.value=  false;


 }
 else
 {
  isLogin.value=false;
  isError.value=true;

 };
}





}

