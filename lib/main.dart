import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_vendor_shop_app/screens/main_screen.dart';
import 'package:multi_vendor_shop_app/screens/on_boarding_screen.dart';

 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //For time being will keep theme color as orange
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Lato'

      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context)=>const SplashScreen(),
        OnBoardingScreen.id:(context)=>const OnBoardingScreen(),
        MainScreen.id:(context)=>const MainScreen()

      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String id='splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(
      seconds: 3

    ),()=>{
      //First while starting app,app will check weather this user already seen onBoarding screen or not
      //For that it should read getStorage
      Navigator.pushReplacementNamed(context, OnBoardingScreen.id)
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,overlays: []);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/Smile.png'),
      ),
    );
  }
}


