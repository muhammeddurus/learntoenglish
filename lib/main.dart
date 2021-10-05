import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:game_app_tap/Home/home_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn to English',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildAnimatedSplashScreen(HomePage());
  }

  AnimatedSplashScreen buildAnimatedSplashScreen(Widget widget) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: AssetImage("assets/images/dic.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
      nextScreen: widget,
      backgroundColor: Colors.black,
    );
  }
}
/*
*/
