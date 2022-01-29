import './mission.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class cUser {
  late int pointSum;
  late String name;
  late List<Mission> missions;

  cUser({
    required this.pointSum,
    required this.name,
    required this.missions,
  });

  factory cUser.fromDocument(DocumentSnapshot doc) {
    Map getDocs = doc.data() as Map;
    List<Mission> missions = [];
    (getDocs['mission'] as Map).forEach((key, value) {
      missions.add(Mission.fromDocument(value));
    });
    return cUser(
      pointSum: getDocs['point_sum'],
      name: getDocs['name'],
      missions: missions,
    );
  }
}
