class BookingModel {
  String studyRoomName;
  String? tabelNum;
  String seatNum;
  String studyRoomIndex;
  String? tabelIndex;
  String seatIndex;
  String bookingTime;
  String? validTime;
  String bookingStatus;

  BookingModel({
    required this.studyRoomName,
     this.tabelNum,
    required this.seatNum,
    required this.studyRoomIndex,
     this.tabelIndex,
   required this.seatIndex,
   required this.bookingTime,
   required this.validTime,
    required this.bookingStatus,
  });
}
