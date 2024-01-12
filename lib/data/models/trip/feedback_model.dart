class FeedbackModel {
  int? id;
  String? feedback;
  String? feedbackdate;
  int? tripID;
  String? imagepath;
  FeedbackModel(
      {this.id,
      required this.tripID,
      required this.feedback,
      required this.feedbackdate,
      required this.imagepath});
  static FeedbackModel fromJson(map) {
    return FeedbackModel(
        id: map['id'],
        feedback: map['feedback'],
        feedbackdate: map['feedbackdate'],
        imagepath: map['imagepath'],
        tripID: map['tripID']);
  }

  Map<String, dynamic> toJson() {
    return {
      'feedback': feedback,
      'tripID': tripID,
      'imagepath': imagepath,
      'feedbackdate': feedbackdate
    };
  }
}
