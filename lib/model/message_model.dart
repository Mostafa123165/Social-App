class MessageModel {

  String? dateTime;
  String? text;
  String? senderId;
  String? receiverId;

  MessageModel({this.text, this.dateTime, this.receiverId, this.senderId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    dateTime = json["dateTime"];
    text = json["text"];
    receiverId = json["receiverId"];
    senderId = json["senderId"];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'text': text,
      'receiverId': receiverId,
      'senderId': senderId,
    };
  }
}
