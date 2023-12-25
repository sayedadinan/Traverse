class ExpenseModel {
  int? id;
  String reason;
  String sponsor;
  dynamic amount;
  int tripID;
  int userId;

  ExpenseModel({
    this.id,
    required this.reason,
    required this.sponsor,
    required this.amount,
    required this.tripID,
    required this.userId,
  });

  // Factory method to create an ExpenseModel from a map
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      reason: map['reason'],
      sponsor: map['sponsor'],
      amount: map['amount'],
      tripID: map['tripID'],
      userId: map['userID'],
    );
  }

  // Convert ExpenseModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reason': reason,
      'sponsor': sponsor,
      'amount': amount,
      'tripID': tripID,
      'userID': userId,
    };
  }
}
