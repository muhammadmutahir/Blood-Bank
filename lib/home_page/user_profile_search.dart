import 'package:blood_bank/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileSearch extends StatefulWidget {
  @override
  _UserProfileSearchState createState() => _UserProfileSearchState();
}

class _UserProfileSearchState extends State<UserProfileSearch> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();

  String? name, email, userType, imageUrl;
  bool isLoading = false;
  bool userFound = false;

  Future<void> searchUserProfile() async {
    setState(() {
      isLoading = true;
      userFound = false;
    });

    try {
      final usersCollection = _firestore.collection('users');
      final userQuery = await usersCollection
          .where('email', isEqualTo: _emailController.text)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userData = userQuery.docs.first.data();
        setState(() {
          name = userData['name'];
          email = userData['email'];
          userType = userData['userType'];
          imageUrl = userData['imageUrl'];
          userFound = true;
        });
      } else {
        setState(() {
          userFound = false;
        });
      }
    } catch (e) {
      print("Error searching user: $e");
    }

    setState(() {
      isLoading = false;
    });
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
          'Search User Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Enter Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: searchUserProfile,
                child: const Text("Search"),
              ),
              const SizedBox(height: 16.0),
              if (isLoading)
                const CircularProgressIndicator()
              else if (userFound == true)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // imageUrl != null
                    //     ? Image.network(imageUrl!)
                    //     : Icon(Icons.account_circle, size: 100),

                    Text("Name: $name"),
                    Text("Email: $email"),
                    Text("userType: $userType"),
                    const SizedBox(height: 8.0),
                    imageUrl != null
                        ? Image.network(imageUrl!)
                        : const Icon(Icons.account_circle, size: 100),
                  ],
                )
              else if (userFound == false)
                const Text("User not found"),
            ],
          ),
        ),
      ),
    );
  }
}
