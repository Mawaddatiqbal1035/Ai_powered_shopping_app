import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';


class AppDependencyInjection {

  Future<void> init()async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      print('error $e');
    }
  }
}
