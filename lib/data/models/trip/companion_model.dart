class CompanionModel {
  int? id;
  String name;
  String number;
  int? tripID;

  CompanionModel(
      {required this.id,
      required this.name,
      required this.number,
      required this.tripID});

  static CompanionModel fromJson(map) {
    return CompanionModel(
        id: map['id'],
        name: map['name'],
        number: map['number'],
        tripID: map['tripID']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'tripID': tripID,
    };
  }
}
