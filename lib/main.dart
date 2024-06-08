import 'package:firebase_core/firebase_core.dart';
import 'package:first_basket/firebase_options.dart';
import 'package:first_basket/pages/login.dart';
import 'package:first_basket/repo/auth_repo.dart';
import 'package:first_basket/repo/courses_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child:  MultiProvider(
          providers: [
         ChangeNotifierProvider(create: (_) => CoursesRepo()),
         ChangeNotifierProvider(create: (_) => LoginRepo()),
          ],
         
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xffec5252),
            scaffoldBackgroundColor: const Color(0xfff5f9fa),
            dialogBackgroundColor:  Colors.white,
            iconTheme:const IconThemeData(color: Colors.grey),
            useMaterial3: true,
          ),
          initialRoute: '/login',
          routes: {
            "/": (_)=>const MyHomePage(),
            "/login": (_)=>const LoginPage()
          },
        ),
      ),
    );
  }
}
