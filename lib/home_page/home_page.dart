import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/pages/donate_blood/donate_blood_req.dart';
import 'package:blood_bank/pages/find_bloodbank/find_blood_bank_request.dart';
import 'package:blood_bank/pages/find_donor/find_donor_request.dart';
import 'package:blood_bank/pages/login.dart';
import 'package:blood_bank/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = "HomePage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(100),
                    child: Text(
                      '___show name___',
                      style: TextStyle(color: whiteColor, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: Center(
                    child: Container(
                      height: 290,
                      width: 360,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Color.fromARGB(255, 139, 128, 128),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        ],
                      ),
                      child: CarouselSlider(
                        items: [
                          Image.asset('assets/images/give_blood_save_life.png'),
                          Image.asset('assets/images/donateimage1.png'),
                          Image.asset('assets/images/donateimage2.png'),
                          Image.asset('assets/images/donateimage3.png'),
                          Image.asset('assets/images/donateimage4.png'),
                        ],
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayInterval: const Duration(seconds: 3),
                          enableInfiniteScroll: true,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            button('Find Donor', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FindDonorRequest()));
            }),
            const SizedBox(
              height: 15,
            ),
            button('Find Blood Bank', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FindBloodBankRequest()));
            }),
            const SizedBox(
              height: 15,
            ),
            button('Donate Blood', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DonateBloodReq()));
            }),
          ],
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Color(0xffFF7676),
                  // Red container
                  child: Padding(
                    padding: const EdgeInsets.only(right: 180, top: 120),
                    child: Center(
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.red,
                  ),
                  title: Text('Update Profile'),
                  onTap: () {},
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.red,
                  ),
                  title: Text('Settings'),
                  onTap: () {},
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.history,
                    color: Colors.red,
                  ),
                  title: Text('History'),
                  onTap: () {},
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.local_hospital,
                    color: Colors.red,
                  ),
                  title: Text('Donation'),
                  onTap: () {},
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200, left: 20),
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: TextButton(
                      onPressed: () {
                        _auth.signOut().then((value) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        }).onError((error, stackTrace) {
                          utils().toastMessage(error.toString());
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button(String text, VoidCallback onPressed) {
    return Container(
      height: 55,
      width: 297,
      decoration: BoxDecoration(
        color: darkRedButtonColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
