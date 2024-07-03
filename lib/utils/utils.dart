import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class utils {
  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<String?> uploadFile(
    PlatformFile? platformFile,
    String folderName,
  ) async {
    if (platformFile == null) return null;
    String path = "";
    path = 'files/$folderName/${DateTime.now().millisecond}';
    final file = File(platformFile.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    final TaskSnapshot taskSnapshot = await ref.putFile(file);
    return await taskSnapshot.ref.getDownloadURL();
  }

// ignore: body_might_complete_normally_nullable
  static Future<PlatformFile?> selectFile() async {
    PermissionStatus permissionStatus = await Permission.storage.request();
    try {
      if (permissionStatus == PermissionStatus.granted) {
        PlatformFile platformFile;
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: [
            'jpg',
            'jpeg',
            'png',
          ],
          allowMultiple: false,
        );
        if (result == null) return null;
        platformFile = result.files.first;
        log(platformFile.path.toString());
        log(platformFile.toString());
        return platformFile;
      }
    } catch (e) {
      log("Exception at selecting file: ${e.toString()}");
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    }
    print('No Image Seleted');
  }
}
