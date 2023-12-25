class MediaModel {
  int? id;
  final int userId;
  final int tripId;
  final String mediaImage;
  MediaModel({
    this.id,
    required this.userId,
    required this.tripId,
    required this.mediaImage,
  });

  static MediaModel frommap(map) {
    return MediaModel(
        userId: map['userId'],
        tripId: map['tripId'],
        mediaImage: map['mediaImage']);
  }
}
