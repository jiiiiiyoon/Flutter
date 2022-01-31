import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login/sing_in.dart';
import '../model/user.dart';

final userRef = FirebaseFirestore.instance.collection('user');
final missionRef = FirebaseFirestore.instance.collection('mission');
final quizRef = FirebaseFirestore.instance.collection('quiz');
final newsRef = FirebaseFirestore.instance.collection('news');

//로그인한 유저의 정보를 가져와 전역변수에 저장
setCurrentUser(FirebaseAuth _authInstance, String? userName) async {
  DocumentSnapshot docSnapshot =
      await userRef.doc(_authInstance.currentUser!.uid).get();

  if (!docSnapshot.exists) {
    await createUserData(_authInstance, userName!);
    docSnapshot = await userRef.doc(_authInstance.currentUser!.uid).get();
  }

  currentUser = cUser.fromDocument(docSnapshot);
}

//회원가입 후 유저 db생성
createUserData(FirebaseAuth _authInstance, String userName) async {
  DocumentSnapshot docSnapshot =
      await userRef.doc(_authInstance.currentUser!.uid).get();
  QuerySnapshot<Map<String, dynamic>> missionSnapshot = await missionRef.get();

  Map<String, dynamic> missions = {};
  int docIdx = 0;
  missionSnapshot.docs.forEach((element) {
    missions.addAll({docIdx.toString(): element.data()});
    docIdx++;
  });
  if (!docSnapshot.exists) {
    print('create user DB');
    userRef.doc(_authInstance.currentUser!.uid).set({
      'point_sum': 0,
      'name': userName,
      'mission': missions,
    });
  }
}

updateUserData(
    FirebaseAuth _authInstance, int idx, bool weekCheck, int userPoint) async {
  await userRef.doc(_authInstance.currentUser!.uid).update({
    'mission.${idx}.week_check': weekCheck, //중첩된 필드 업데이트
    'point_sum': userPoint,
  });
}
