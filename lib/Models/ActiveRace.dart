import 'package:exdata_collector/Models/AbstractModel.dart';

class ActiveRace implements AbstractModel {
  int raceId;
  List<int> boatIds;

  ActiveRace({
    required this.raceId,
    required this.boatIds,
  });

  factory ActiveRace.fromJson(Map<String, dynamic> json) {
    return ActiveRace(
      raceId: json['raceId'] ?? json['rcid'] ?? 0,
      boatIds: json['boatIds'] != null
          ? List<int>.from((json['boatIds'] as List).map((e) => (e as num).toInt()))
          : [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'raceId': raceId,
      'boatIds': boatIds,
    };
  }

  @override
  String toString() {
    return '{raceId: $raceId, boatIds: $boatIds}';
  }
}
