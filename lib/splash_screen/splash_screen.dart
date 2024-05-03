
import 'package:blood_bank/splash_screen/splash_screen_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashScreenServices splashScreen = SplashScreenServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xffFA4848),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 255, 83, 83), Color(0xff930A0A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    height: 220,
                    width: 220,
                    image: AssetImage('assets/images/logo.png'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
