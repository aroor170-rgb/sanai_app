import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAdjk5CihMQU8U2idrPFbAMqar4YMsHEQg",
            authDomain: "sanai-87142.firebaseapp.com",
            projectId: "sanai-87142",
            storageBucket: "sanai-87142.firebasestorage.app",
            messagingSenderId: "651968943136",
            appId: "1:651968943136:web:86e76a6187a84cbef3d845",
            measurementId: "G-MGHQD8JETL"));
  } else {
    await Firebase.initializeApp();
  }
}
