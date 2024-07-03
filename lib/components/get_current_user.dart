import 'package:blood_bank/models/blood_bank_user_model.dart';
import 'package:blood_bank/models/donor_user_model.dart';
import 'package:blood_bank/models/seeker_user_model.dart';
import 'package:flutter/material.dart';

class getCurrentUser extends StatefulWidget {
  const getCurrentUser({
    super.key,
    required this.seekerUserModel,
    required this.donorUserModel,
    required this.bloodBankUserModel,
  });

  final SeekerUserModel? seekerUserModel;
  final DonorUserModel? donorUserModel;
  final BloodBankUserModel? bloodBankUserModel;

  @override
  State<getCurrentUser> createState() => _getCurrentUserState();
}

class _getCurrentUserState extends State<getCurrentUser> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
