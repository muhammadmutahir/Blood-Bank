import 'dart:developer';
import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/home_page/home_page.dart';
import 'package:blood_bank/models/blood_bank_user_model.dart';
import 'package:blood_bank/models/user_model.dart';
import 'package:blood_bank/utils/utils.dart';
import 'package:blood_bank/widgets/whiteroundbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BloodBankRegister extends StatefulWidget {
  const BloodBankRegister({Key? key});

  @override
  State<BloodBankRegister> createState() => _BloodBankRegisterState();
}

class _BloodBankRegisterState extends State<BloodBankRegister> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  String selectedCity = "--Select City--";
  String selectedblood = "Select Blood Type";

  TextEditingController bloodbanknameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bloodgroupController = TextEditingController();
  TextEditingController availablebloodunitController = TextEditingController();
  TextEditingController contactnoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

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
    bloodbanknameController.dispose();
    emailController.dispose();
    bloodgroupController.dispose();
    availablebloodunitController.dispose();
    contactnoController.dispose();
    passwordController.dispose();
    cityController.dispose();

    super.dispose();
  }

  bool obsecureText = true;
  String? validatebloodbankname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter blood bank name';
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

  String? validatebloodgroup(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your blood group';
    }
    return null;
  }

  String? validateavailablebloodunit(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter available blood unit';
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

  String? validatecity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your city';
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
          'Blood Bank Register',
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
                          controller: bloodbanknameController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Color(0xffE5E3E3)),
                          decoration: const InputDecoration(
                              labelText: 'Blood Bank Name',
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
                          validator: validatebloodbankname,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
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
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          controller: availablebloodunitController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Color(0xffE5E3E3)),
                          decoration: const InputDecoration(
                              labelText: 'Available Blood Unit',
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
                          validator: validateavailablebloodunit,
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
                                selection: TextSelection.collapsed(offset: 4),
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
                              errorStyle: TextStyle(color: Colors.yellow),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                              )),
                          validator: validatePassword,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 210, bottom: 10),
                        child: Text(
                          'Select Blood Type:',
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Container(
                          width: 210,
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
                                DropdownMenuItem<String>(
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
                                        style: TextStyle(
                                          color: Color(0xffFF0E0E),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ],
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Color(0xffFF0E0E)),
                              decoration: InputDecoration(
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 210, bottom: 10),
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
                                DropdownMenuItem<String>(
                                  value: "--Select City--",
                                  child: Center(
                                    child: Center(
                                      child: Text(
                                        "--Select City--",
                                        style: TextStyle(
                                          color: Color(0xffFF0E0E),
                                        ),
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
                                        style: TextStyle(
                                          color: Color(0xffFF0E0E),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ],
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Color(0xffFF0E0E)),
                              decoration: InputDecoration(
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
                                    final user = BloodBankUserModel(
                                        bloodbankname:
                                            bloodbanknameController.text,
                                        email: emailController.text,
                                        availablebloodunit: int.parse(
                                            availablebloodunitController.text),
                                        contactno: contactnoController.text,
                                        password: passwordController.text,
                                        bloodgroup: selectedblood,
                                        city: selectedCity,
                                        id: value.user!.uid);
                                    createUser(
                                      user: user,
                                      userId: value.user!.uid,
                                    ).then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));

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
      {required BloodBankUserModel user, required String userId}) async {
    UserModel userModel = UserModel(
      id: user.id,
      name: user.bloodbankname,
      email: user.email,
      userType: "bloodbank",
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userModel.toJson());

    FirebaseFirestore.instance
        .collection('bloodbankdetails')
        .doc(userId)
        .set(user.toJson());
  }
}
