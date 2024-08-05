import 'package:blood_bank/home_page/home_page.dart';
import 'package:blood_bank/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyC_mkmL6NvhFA41kQSLgZh1NFg9yYnaHMw',
    appId: '1:375745278835:android:36d21eed3d04528d340b06',
    messagingSenderId: '375745278835',
    projectId: 'blood-bank-d9f7a',
    storageBucket: 'gs://blood-bank-d9f7a.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
