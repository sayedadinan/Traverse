class Coverpic {
  int? id;
  String? imagePath;
  int tripID;
  int userId;
  Coverpic({
    this.id,
    required this.imagePath,
    required this.tripID,
    required this.userId,
  });
  static Coverpic fromJson(map) {
    return Coverpic(
        id: map['id'],
        imagePath: map['imagePath'],
        tripID: map['tripID'],
        userId: map['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'userId': userId,
      'tripID': tripID,
    };
  }
}
