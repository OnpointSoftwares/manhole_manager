import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manhole_manager/login.dart';
import 'package:manhole_manager/registration.dart';
import 'package:manhole_manager/userInfo.dart';
import 'package:manhole_manager/Home.dart';
import 'package:manhole_manager/technician.dart';
import 'package:manhole_manager/firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyB7SkseaHxFWUaX_qTnwCENC6brp-9sXg0',
    appId: '1:555409444571:android:b8b83e0cc052efff9046fe',
    messagingSenderId: '555409444571',
    projectId: 'missingbooknotificationsystem',
    databaseURL: 'https://missingbooknotificationsystem-default-rtdb.firebaseio.com',
    storageBucket: 'missingbooknotificationsystem.appspot.com',
  );
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const FibreOpticsApp());
}

class FibreOpticsApp extends StatelessWidget {
  const FibreOpticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red[300],
          scaffoldBackgroundColor: Colors.white,
       backgroundColor: Colors.white,
          bottomAppBarColor: Colors.redAccent,
        ),
        home: const LoginScreen(),
        routes: {
          'login': (context) => const LoginScreen(),
          'register': (context) => const RegistrationScreen(),
          'userInfo':(context) => const UserInfoScreen(),
          'adminHome':(context) => const AdminHomeScreen(),
          'technician':(context) => const TechnicianPage(),
        });
  }
}

