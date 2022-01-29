import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login/sing_in.dart';
import '../model/user.dart';

final userRef = FirebaseFirestore.instance.collection('user');
final missionRef = FirebaseFirestore.instance.collection('mission');
final quizRef = FirebaseFirestore.instance.collection('quiz');
final newsRef = FirebaseFirestore.instance.collection('news');

//로그인한 유저의 정보를 가져와 전역변수에 저장
setCurrentUser(FirebaseAuth _authInstance) async {
  DocumentSnapshot docSnapshot =
      await userRef.doc(_authInstance.currentUser!.uid).get();
  currentUser = cUser.fromDocument(docSnapshot);
}

//회원가입 후 유저 db생성
createUserData(FirebaseAuth _authInstance, String userName) async {
  DocumentSnapshot docSnapshot =
      await userRef.doc(_authInstance.currentUser!.uid).get();
  QuerySnapshot<Map<String, dynamic>> missionSnapshot = await missionRef.get();

  if (!docSnapshot.exists) {
    print('create user DB');
    userRef.doc(_authInstance.currentUser!.uid).set({
      'point_sum': 0,
      'name': userName,
      'mission': {
        '0': missionSnapshot.docs[0].data(),
        '1': missionSnapshot.docs[1].data(),
        '2': missionSnapshot.docs[2].data(),
        '3': missionSnapshot.docs[3].data(),
      },
    });
  }
}
