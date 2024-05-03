import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorsPage extends StatelessWidget {
  final String bloodGroup;

  DonorsPage({required this.bloodGroup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donors for $bloodGroup'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('donordetails')
            .where('bloodgroup', isEqualTo: bloodGroup)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No donors available for $bloodGroup'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['fullname']),
                subtitle: Text(data['email']),
                // Add more donor details here if needed
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
