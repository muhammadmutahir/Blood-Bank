import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String mesgid;
  final String senderid;
  final String reciverid;
  //final String time;
  final String message;
  final Timestamp timestamp; // <-- Added this field

  MessageModel({
    required this.mesgid,
    required this.senderid,
    required this.reciverid,
    //required this.time,
    required this.message,
    required this.timestamp, // <-- Added this parameter
  });

  Map<String, dynamic> toJson() => {
        'mesgid': mesgid,
        'senderid': senderid,
        'reciverid': reciverid,
        // 'time': time,
        'message': message,
        'timestamp': timestamp, // <-- Added this field
      };

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      mesgid: json['mesgid'] ?? '',
      senderid: json['senderid'] ?? '',
      reciverid: json['reciverid'] ?? '',
      // time: json['time'] ?? '',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] != null
          ? Timestamp.fromMillisecondsSinceEpoch(
              json['timestamp'].millisecondsSinceEpoch)
          : Timestamp.now(), // <-- Updated this line
    );
  }
}
