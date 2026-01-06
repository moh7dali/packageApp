import 'dart:convert';

PushNotificationModel pushNotificationModelFromMap(String str) => PushNotificationModel.fromMap(json.decode(str));

String pushNotificationModelToMap(PushNotificationModel data) => json.encode(data.toMap());

class PushNotificationModel {
  int? tid;
  DateTime? time;
  int? trg;
  dynamic bri;
  String? title;
  String? body;
  String? image;

  PushNotificationModel({
    this.tid,
    this.time,
    this.trg,
    this.bri,
    this.title,
    this.body,
    this.image,
  });

  factory PushNotificationModel.fromMap(Map<String, dynamic> json) => PushNotificationModel(
        tid: json["tid"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        trg: json["trg"],
        bri: json["bri"],
        title: json["title"],
        body: json["body"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "tid": tid,
        "time": time?.toIso8601String(),
        "trg": trg,
        "bri": bri,
        "title": title,
        "body": body,
        "image": image,
      };
}
