import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shallwe_app/custom_widget/custom_textformfield.dart';
import 'package:shallwe_app/custom_widget/custom_button.dart';
import '../../data/firebase_data_control.dart';
import './sing_in.dart';
import '../../size.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _authInstance = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  late String _userEmail;
  late String _userPassword;
  late bool _pwCheck;
  late String _userName;
  late String _userPhNum;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('회원가입'),
        ),
        body: SingleChildScrollView(child: _signUpBody()),
      ),
    );
  }

  Widget _signUpBody() {
    return Padding(
      padding: EdgeInsets.all(
        (MediaQuery.of(context).size.width - 654 * getScaleWidth(context)) / 2,
      ),
      child: Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
              children: [
                CustomTextField(
                  ValueKey('email'),
                  TextInputType.emailAddress,
                  (value) {
                    return (value!.isEmpty || !value.contains('@'))
                        ? '올바른 이메일 주소를 입력해주세요'
                        : null;
                  },
                  (value) {
                    _userEmail = value!;
                  },
                  Icons.email_rounded,
                  '이메일',
                  '이메일을 입력해주세요',
                  context,
                ),
                CustomTextField(
                  ValueKey('pw'),
                  TextInputType.visiblePassword,
                  (value) {
                    return (value!.isEmpty || value.length < 6)
                        ? '올바른 비밀번호를 입력해주세요'
                        : null;
                  },
                  (value) {
                    _userPassword = value!;
                  },
                  Icons.password_rounded,
                  '비밀번호',
                  '비밀번호를 입력해주세요',
                  context,
                ),
                CustomTextField(
                  ValueKey('pwcheck'),
                  TextInputType.visiblePassword,
                  (value) {
                    return (value!.isEmpty || value != _userPassword)
                        ? '비밀번호가 일치하지 않습니다.'
                        : null;
                  },
                  (value) {
                    _pwCheck = true;
                  },
                  Icons.password_rounded,
                  '비밀번호 확인',
                  '비밀번호를 입력해주세요',
                  context,
                ),
                CustomTextField(
                  ValueKey('name'),
                  TextInputType.name,
                  (value) {
                    return (value.length < 2) ? '이름을 입력해주세요' : null;
                  },
                  (value) {
                    _userName = value!;
                  },
                  Icons.person,
                  '이름',
                  '이름을 입력해주세요',
                  context,
                ),
                CustomTextField(
                  ValueKey('phone'),
                  TextInputType.phone,
                  (value) {
                    return (value.length < 10) ? '이메일 주소를 입력해주세요' : null;
                  },
                  (value) {
                    _userEmail = value!;
                  },
                  Icons.phone,
                  '휴대전화',
                  '전화번호를 입력해주세요',
                  context,
                ),
              ],
            ),
          ),
          SizedBox(height: 57 * getScaleHeight(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customElevatedButton(
                () async {
                  //firebase 가입
                  try {
                    final newUser =
                        await _authInstance.createUserWithEmailAndPassword(
                      email: _userEmail,
                      password: _userPassword,
                    );

                    if (newUser.user != null) {
                      await newUser.user!.updateDisplayName(_userName);

                      //휴대폰 사용은 추후 이야기
                      // newUser.user!.updatePhoneNumber(_userPhNum);
                      Navigator.pop(context);
                      createUserData(_authInstance, _userName);
                    }
                  } catch (e) {
                    print('error: ${e}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('이미 존재하는 계정입니다.')),
                    );
                  }
                },
                '가입하기',
                context,
              ),
              customElevatedButton(
                () {
                  Navigator.pop(context);
                },
                '취소',
                context,
              ),
            ],
          )
        ],
      ),
    );
  }

  signUp() async {
    try {
      final newUser = await _authInstance.signInWithEmailAndPassword(
        email: _userEmail,
        password: _userPassword,
      );
      if (newUser.user != null) {
        Navigator.pop(context);
      }
    } catch (e) {
      print('error: ${e}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('존재하는 계정입니다.')),
      );
    }
  }
}
