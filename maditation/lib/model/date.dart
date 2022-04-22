class DataModel {
  int? id;
  String day;
  String minute;

  DataModel({this.id, required this.day, required this.minute});

  factory DataModel.fromMap(Map<String, dynamic> json) =>
      DataModel(id: json['id'], day: json["day"], minute: json["minute"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "day": day,
        "minute": minute,
      };
}
