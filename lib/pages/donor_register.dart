import 'dart:async';
import 'dart:developer';

import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/models/donor_user_model.dart';
import 'package:blood_bank/home_page/home_page.dart';
import 'package:blood_bank/models/user_model.dart';
import 'package:blood_bank/utils/utils.dart';
import 'package:blood_bank/widgets/whiteroundbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonorRegister extends StatefulWidget {
  const DonorRegister({
    super.key,
  });

  static const String id = 'DonorRegister';

  @override
  State<DonorRegister> createState() => _DonorRegisterState();
}

class _DonorRegisterState extends State<DonorRegister> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  String selectedCity = "--Select City--";
  String selectedblood = "Select Blood Type";

  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController bloodgroupController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController contactnoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> cities = [
    "Lahore",
    "Multan",
    "Islamabad",
    "Faisalabad",
  ];

  List<String> bloodtypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    ageController.dispose();
    bloodgroupController.dispose();
    cityController.dispose();
    contactnoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool obsecureText = true;
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validateage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    return null;
  }

  String? validatebloodgroup(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your blood group';
    }
    return null;
  }

  String? validatecity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your city';
    }
    return null;
  }

  String? validatecontactno(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your contact no';
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
      appBar: AppBar(
        backgroundColor: const Color(0xffEE4141),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        title: const Text(
          'Become a Donor',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 83, 83),
                Color(0xff930A0A),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                  height: 150,
                  width: 150,
                  image: AssetImage('assets/images/logo.png'),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          controller: fullnameController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Color(0xffE5E3E3)),
                          decoration: const InputDecoration(
                              labelText: 'Full Name',
                              labelStyle:
                                  TextStyle(color: whiteColor, fontSize: 18),
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
                          validator: validateFullName,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Color(0xffE5E3E3)),
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle:
                                  TextStyle(color: whiteColor, fontSize: 18),
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: TextFormField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Color(0xffE5E3E3)),
                          decoration: const InputDecoration(
                              labelText: 'Age',
                              labelStyle:
                                  TextStyle(color: whiteColor, fontSize: 18),
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
                          validator: validateage,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          controller: contactnoController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Color(0xffE5E3E3)),
                          decoration: const InputDecoration(
                            labelText: 'Contact No',
                            labelStyle:
                                TextStyle(color: whiteColor, fontSize: 18),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: whiteColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: whiteColor),
                            ),
                            errorStyle: TextStyle(color: Colors.yellow),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow),
                            ),
                          ),
                          onTap: () {
                            if (contactnoController.text.isEmpty) {
                              contactnoController.text = '+92';
                              contactnoController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: contactnoController.text.length));
                            }
                          },
                          onChanged: (value) {
                            if (!value.startsWith('+92')) {
                              contactnoController.value = TextEditingValue(
                                text: '+92$value',
                                selection:
                                    const TextSelection.collapsed(offset: 4),
                              );
                            }
                          },
                          validator: validatecontactno,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          obscureText: obsecureText,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Color(0xffE5E3E3)),
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                color: whiteColor,
                                fontSize: 18,
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
                                  color: whiteColor,
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: whiteColor),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: whiteColor),
                              ),
                              errorStyle: const TextStyle(color: Colors.yellow),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                              )),
                          validator: validatePassword,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 10, right: 210, bottom: 10),
                        child: Text(
                          'Select Blood Type:',
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 16),
                        child: Container(
                          width: 205,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Center(
                            child: DropdownButtonFormField<String>(
                              value: selectedblood,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedblood = newValue!;
                                  print("Selected blood: $selectedblood");
                                });
                              },
                              items: [
                                const DropdownMenuItem<String>(
                                  value: "Select Blood Type",
                                  child: Center(
                                    child: Text(
                                      "Select Blood Type",
                                      style: TextStyle(
                                        color: Color(0xffFF0E0E),
                                      ),
                                    ),
                                  ),
                                ),
                                ...bloodtypes.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: Color(0xffFF0E0E),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Color(0xffFF0E0E)),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 10, right: 210, bottom: 10),
                        child: Text(
                          'Select City:',
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Center(
                            child: DropdownButtonFormField<String>(
                              //controller: cityController,
                              value: selectedCity,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCity = newValue!;
                                  print("Selected city: $selectedCity");
                                });
                              },

                              items: [
                                const DropdownMenuItem<String>(
                                  value: "--Select City--",
                                  child: Center(
                                    child: Text(
                                      "--Select City--",
                                      style: TextStyle(
                                        color: Color(0xffFF0E0E),
                                      ),
                                    ),
                                  ),
                                ),
                                ...cities.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value.toLowerCase(),
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: Color(0xffFF0E0E),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Color(0xffFF0E0E)),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: WhiteRoundButton(
                            title: 'Register',
                            loading: loading,
                            onTap: () {
                              if (_formKey.currentState?.validate() == true) {
                                setState(() {
                                  loading = true;
                                });

                                try {
                                  _auth
                                      .createUserWithEmailAndPassword(
                                          email:
                                              emailController.text.toString(),
                                          password: passwordController.text
                                              .toString())
                                      .then((value) {
                                    final user = DonorUserModel(
                                      fullname: fullnameController.text,
                                      email: emailController.text,
                                      age: int.parse(ageController.text),
                                      city: selectedCity,
                                      bloodgroup: selectedblood,
                                      contactno: contactnoController.text,
                                      password: passwordController.text,
                                      id: value.user!.uid,
                                    );
                                    createUser(
                                      user: user,
                                      userId: value.user!.uid,
                                    ).then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()));
                                      setState(() {
                                        loading = false;
                                      });
                                      utils().toastMessage(
                                          'Register Successfully');
                                    }).onError((error, stackTrace) {
                                      utils().toastMessage(error.toString());
                                      setState(() {
                                        loading = false;
                                      });
                                    });
                                  });
                                } catch (e) {
                                  log(e.toString());
                                }
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future createUser(
      {required DonorUserModel user, required String userId}) async {
    UserModel userModel = UserModel(
      id: user.id,
      name: user.fullname,
      email: user.email,
      userType: "donor",
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userModel.toJson());
    FirebaseFirestore.instance
        .collection('donordetails')
        .doc(userId)
        .set(user.toJson());
  }
}
