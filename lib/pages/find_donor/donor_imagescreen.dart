import 'package:blood_bank/components/constants.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  const ImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'Donor Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
        backgroundColor: appBannarColor,
        toolbarHeight: 84,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: Center(
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                width: 300, // Adjust as per your design
                height: 300, // Adjust as per your design
                fit: BoxFit.contain, // Adjust how the image fits the container
              )
            : Text('No image available'), // Handle case where imageUrl is empty
      ),
    );
  }
}
