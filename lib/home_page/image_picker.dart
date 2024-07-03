import 'dart:io';

import 'package:blood_bank/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

class ImagePickerBigWidget extends StatelessWidget {
  final String heading;
  final String description;
  final Function onPressed;
  final PlatformFile? platformFile;
  final String? imgUrl;

  const ImagePickerBigWidget({
    Key? key,
    required this.heading,
    required this.description,
    required this.onPressed,
    required this.platformFile,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: imgUrl != null && platformFile == null
            ? MaterialButton(
                onPressed: () async => onPressed(),
                child: SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: Stack(children: [
                    CircleAvatar(
                      child: Image.network(
                        width: double.infinity,
                        imgUrl!,
                        fit: BoxFit.contain,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: imgUrl != null && platformFile == null,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.transparent.withOpacity(0.3)),
                          alignment: Alignment.center,
                          child: const Text(
                            "Edit Picture",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: whiteColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              )
            : platformFile != null
                ? MaterialButton(
                    onPressed: () async => onPressed(),
                    child: Image.file(
                      File(platformFile!.path!),
                      height: 100,
                      width: 100,
                    ),
                  )
                : SizedBox(
                    width: 100,
                    height: 100,
                    child: MaterialButton(
                      onPressed: () async => onPressed(),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset('assets/images/avatar.jpg'),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 75,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  heading,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
  }
}
