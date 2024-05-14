import 'dart:async';

import 'package:blood_bank/home_page/home_page.dart';
import 'package:blood_bank/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenServices {
  void islogin(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final User = _auth.currentUser;

    if (User != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              ));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              ));
    }
  }
}
