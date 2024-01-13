import 'package:traverse_1/data/models/trip/companion_model.dart';

class Tripmodel {
  final int? userid;
  int? id;
  final String tripname;
  final String destination;
  final double budget;
  final String transport;
  final String triptype;
  final String startingDate;
  final String endingDate;
  final dynamic coverpic;
  List<CompanionModel> companions;
  List<String> imagePaths;
  Tripmodel({
    required this.tripname,
    required this.destination,
    required this.budget,
    required this.transport,
    required this.triptype,
    required this.startingDate,
    required this.endingDate,
    this.coverpic,
    this.id,
    this.companions = const [],
    this.imagePaths = const [],
    this.userid,
  });

  static Tripmodel fromMap(Map<String, dynamic> map) {
    final id = map['id'] as int;
    final tripname = map['tripname'] as String;
    final destination = map['destination'] as String;
    final budget = map['budget'] as double;
    final transport = map['transport'] as String;
    final triptype = map['triptype'] as String;
    final startingDate = map['startingDate'] as String;
    final endingDate = map['endingDate'] as String;
    final coverpic = map['coverpic'] as dynamic;
    final userid = map['userid'] as int;
    return Tripmodel(
        tripname: tripname,
        destination: destination,
        budget: budget,
        transport: transport,
        triptype: triptype,
        startingDate: startingDate,
        endingDate: endingDate,
        coverpic: coverpic,
        id: id,
        userid: userid);
  }

  toMap() {}
}
