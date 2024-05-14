import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/firebase_auth/forgot_password.dart';
import 'package:blood_bank/pages/blood_bank_register.dart';
import 'package:blood_bank/pages/donate_blood/donate_blood_req.dart';
import 'package:blood_bank/home_page/home_page.dart';
import 'package:blood_bank/pages/seeker_register.dart';
import 'package:blood_bank/utils/utils.dart';
import 'package:blood_bank/widgets/redroundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const String id = 'Login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool obsecureText = true;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 83, 83),
              Color(0xff930A0A),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                    height: 150,
                    width: 150,
                    image: AssetImage('assets/images/logo.png')),
                const Text(
                  'Login',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Color(0xffE5E3E3)),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: const TextStyle(
                                color: Color(0xffE5E3E3),
                                fontSize: 18,
                              ),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Color(0xffE5E3E3),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(18)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(18)),
                              errorStyle: TextStyle(color: Colors.yellow),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                              ),
                            ),
                            validator: validateEmail),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    obscureText: obsecureText,
                    controller: passwordController,
                    style: const TextStyle(color: Color(0xffE5E3E3)),
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Color(0xffE5E3E3),
                          fontSize: 18,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xffE5E3E3),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obsecureText = !obsecureText;
                              });
                            },
                            icon: Icon(
                              obsecureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xffE5E3E3),
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffE4E7EB)),
                            borderRadius: BorderRadius.circular(18)),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffE4E7EB)),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        errorStyle: TextStyle(color: Colors.yellow),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        )),
                    validator: validatePassword,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 140),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()));
                    },
                    child: const Center(
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: RedRoundButton(
                      title: 'Login',
                      loading: loading,
                      onTap: () {
                        if (_formKey.currentState?.validate() == true) {
                          setState(() {
                            loading = true;
                          });
                          _auth
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text.toString())
                              .then((value) {
                            utils().toastMessage(value.user!.email.toString());
                            emailController.clear();
                            passwordController.clear();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                            setState(() {
                              loading = false;
                            });
                          }).onError((error, stackTrace) {
                            utils().toastMessage(error.toString());
                            setState(() {
                              loading = false;
                            });
                          });
                        }
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    "Don't have an Account?",
                    style: TextStyle(fontSize: 16, color: whiteColor),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: RedRoundButton(
                        title: 'Sign Up',
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Register as a',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: darkRedButtonColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      button('Seeker', () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SeekerRegister()));
                                      }),
                                      SizedBox(height: 10),
                                      button('Donor', () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DonateBloodReq()));
                                      }),
                                      SizedBox(height: 10),
                                      button('Blood Bank', () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BloodBankRegister()));
                                      }),
                                    ],
                                  ),
                                );
                              });
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
