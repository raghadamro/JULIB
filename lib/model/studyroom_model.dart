import 'dart:convert';

List<StudyRoom> studyRoomFromJson(String str) =>
    List<StudyRoom>.from(json.decode(str).map((x) => StudyRoom.fromJson(x)));

StudyRoomModel studyRoomModelFromJson(String str) =>
    StudyRoomModel.fromJson(json.decode(str));

String studyRoomModelToJson(StudyRoomModel data) => json.encode(data.toJson());

class StudyRoomModel {
  StudyRoomModel({
    this.studyRooms,
  });

  List<StudyRoom>? studyRooms;

  factory StudyRoomModel.fromJson(Map<String, dynamic> json) => StudyRoomModel(
        studyRooms: List<StudyRoom>.from(
            json["StudyRooms"].map((x) => StudyRoom.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "StudyRooms": List<dynamic>.from(studyRooms!.map((x) => x.toJson())),
      };
}

class StudyRoom {
  StudyRoom({
    this.locationAR,
    this.locationEN,
    this.name,
    this.tabels,
    this.seats,
  });

  String? locationAR;
  String? locationEN;
  String? name;
  List<Tabel>? tabels;
  List<Seat>? seats;

  factory StudyRoom.fromJson(Map<String, dynamic> json) => StudyRoom(
        locationAR: json["locationAR"],
        locationEN: json["locationEN"],
        name: json["name"],
        tabels: json["tabels"] == null
            ? null
            : List<Tabel>.from(json["tabels"].map((x) => Tabel.fromJson(x))),
        seats: json["seats"] == null
            ? null
            : List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "locationAR": locationAR,
        "locationEN": locationEN,
        "name": name,
        "tabels": tabels == null
            ? null
            : List<dynamic>.from(tabels!.map((x) => x.toJson())),
        "seats": seats == null
            ? null
            : List<dynamic>.from(seats!.map((x) => x.toJson())),
      };
}

class Seat {
  Seat({
    this.id,
    this.num,
    this.status,
  });

  dynamic id;
  dynamic num;
  String? status;

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        id: json["id"],
        num: json["num"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "num": num,
        "status": status,
      };
}

class Tabel {
  Tabel({
    this.id,
    this.number,
    this.seats,
    this.status,
  });

  dynamic id;
  dynamic number;
  List<Seat>? seats;
  String? status;

  factory Tabel.fromJson(Map<String, dynamic> json) => Tabel(
        id: json["id"],
        number: json["number"],
        seats: List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "seats": List<dynamic>.from(seats!.map((x) => x.toJson())),
        "status": status,
      };
}
