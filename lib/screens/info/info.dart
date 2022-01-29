import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login/sing_in.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final _authInstance = FirebaseAuth.instance;
  dynamic loggedUser;
  void getCurrentUser() {
    try {
      final user = _authInstance.currentUser;
      if (user != null) {
        loggedUser = user;

        print(loggedUser.email);
      }
      print(currentUser.missions.length);
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('main info page')),
      body: Column(
        children: [
          Text(loggedUser.uid),
          Text(currentUser.name),
          Text(currentUser.pointSum.toString()),
          Text(currentUser.missions.toString()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentUser();
        },
      ),
    );
  }
}
