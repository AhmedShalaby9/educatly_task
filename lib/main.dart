import 'package:api/my_app.dart';
import 'package:api/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDZ320LvVqxeXRwLeW93762qzB2tbaUfjE",
      appId: "1:489339870133:android:a310c541ef79cd599897fc",
      messagingSenderId: "489339870133",
      projectId: "eductalt-task",
    ),
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  ));
}
