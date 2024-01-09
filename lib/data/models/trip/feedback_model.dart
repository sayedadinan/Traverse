class FeedbackModel {
  int? id;
  String? feedback;
  String? feedbackdate;
  int? tripID;
  FeedbackModel(
      {this.id,
      required this.tripID,
      required this.feedback,
      required this.feedbackdate});
  static FeedbackModel fromJson(map) {
    return FeedbackModel(
        id: map['id'],
        feedback: map['feedback'],
        feedbackdate: map[''],
        tripID: map['tripID']);
  }

  Map<String, dynamic> toJson() {
    return {
      'feedback': feedback,
      'tripID': tripID,
    };
  }
}
