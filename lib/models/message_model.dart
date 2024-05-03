class MessageModel {
  final String mesgid;
  final String senderid;
  final String reciverid;
  final String time;
  final String message;

  MessageModel({
    required this.mesgid,
    required this.senderid,
    required this.reciverid,
    required this.time,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'mesgid': mesgid,
        'senderid': senderid,
        'reciverid': reciverid,
        'time': time,
        'message': message,
      };

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      mesgid: json['mesgid'] ?? '',
      senderid: json['senderid'] ?? '',
      reciverid: json['reciverid'] ?? '',
      time: json['time'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
