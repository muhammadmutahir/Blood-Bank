// ignore_for_file: prefer_const_constructors

import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/pages/login.dart';
import 'package:blood_bank/utils/utils.dart';
import 'package:blood_bank/widgets/redroundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Invalid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEE4141),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        title: Text(
          'Seeker Register',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 83, 83),
            Color(0xff930A0A),
            // Color(0xff46d733),
            // Color(0xff5c9b54),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          children: [
            Image(
              height: 150,
              width: 150,
              image: AssetImage('assets/images/logo.png'),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Color(0xffE5E3E3)),
                decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: whiteColor, fontSize: 18),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: whiteColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: whiteColor),
                    ),
                    errorStyle: TextStyle(color: Colors.yellow),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    )),
                validator: validateEmail,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: RedRoundButton(
                  title: 'Forgot',
                  loading: loading,
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    _auth
                        .sendPasswordResetEmail(
                            email: emailController.text.toString())
                        .then((value) {
                      utils().toastMessage(
                          'We have sent you an email to recover passeord. Please check email.');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));

                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
