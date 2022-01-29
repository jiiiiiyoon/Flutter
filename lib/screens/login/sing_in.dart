import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shallwe_app/screens/info/info.dart';
import '../../size.dart';
import '../../custom_widget/custom_textformfield.dart';
import '../../custom_widget/custom_button.dart';
import '../../model/user.dart';
import '../../data/firebase_data_control.dart';
import './sign_up.dart';

late cUser currentUser;

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _authInstance = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  late String _userEmail;
  late String _userPassword;

  void _tryValidation() async {
    final isValid = _formkey.currentState!.validate();
    print(isValid);

    if (isValid) {
      _formkey.currentState!.save();
      print(_userEmail);
      print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('ShellWe?', style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(child: _SignInBody()),
      ),
    );
  }

  Widget _SignInBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 164 * getScaleHeight(context)),
        Padding(
          padding: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width -
                      654 * getScaleWidth(context)) /
                  2),
          child: Text(
            '날씨\n관련 문구\n넣을 곳',
            style: TextStyle(
              color: const Color(0xff000000),
              fontWeight: FontWeight.w700,
              fontFamily: "NotoSansCJKkr",
              fontStyle: FontStyle.normal,
              fontSize: 56.0 * getScaleWidth(context),
            ),
          ),
        ),
        SizedBox(height: 98 * getScaleHeight(context)),

        //로그인정보 입력 컨테이너
        Container(
          margin: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width -
                      654 * getScaleWidth(context)) /
                  2),
          width: 654 * getScaleWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      ValueKey('email'),
                      TextInputType.emailAddress,
                      (value) {
                        return (value!.isEmpty || !value.contains('@'))
                            ? '이메일 주소를 입력해주세요'
                            : null;
                      },
                      (value) {
                        _userEmail = value!;
                      },
                      Icons.email_rounded,
                      '',
                      '이메일을 입력해주세요.',
                      context,
                    ),
                    CustomTextField(
                      ValueKey('pw'),
                      TextInputType.visiblePassword,
                      (value) {
                        return (value!.isEmpty || value.length < 6)
                            ? '7자 이상 입력하세요'
                            : null;
                      },
                      (value) {
                        _userPassword = value!;
                      },
                      Icons.password_rounded,
                      '',
                      '비밀번호를 입력해주세요.',
                      context,
                    ),
                  ],
                ),
              ),

              //폼 로그인 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customElevatedButton(
                    () async {
                      print('signin buttom pressed');
                      _tryValidation();

                      //firebase 로그인

                      await signIn();
                    },
                    '로그인',
                    context,
                  ),
                  customElevatedButton(
                    () async {
                      print('signup button clicked');
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    '회원가입',
                    context,
                  ),
                ],
              ),
              SizedBox(height: 27 * getScaleHeight(context)),

              //플렛폼 로그인(회원가입) 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Image.asset(
                      'assets/google_signin.png',
                      width: 320 * getScaleWidth(context),
                      height: 72 * getScaleWidth(context),
                    ),
                    onTap: () {
                      print('google login');
                      setCurrentUser(_authInstance);
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'assets/kakao_signin.png',
                      width: 320 * getScaleWidth(context),
                      height: 72 * getScaleWidth(context),
                    ),
                    onTap: () async {
                      print('kakao login');
                    },
                  ),
                ],
              ),
              SizedBox(height: 17 * getScaleHeight(context)),
            ],
          ),
        ),
      ],
    );
  }

  //로그인 메서드(이메일, pw)사용
  signIn() async {
    try {
      final newUser = await _authInstance.signInWithEmailAndPassword(
        email: _userEmail,
        password: _userPassword,
      );
      await setCurrentUser(_authInstance);
      if (newUser.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoScreen()));
      }
    } catch (error) {
      print('error: ${error}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디와 비밀번호를 다시 확인해주세요.')),
      );
    }
  }
}
