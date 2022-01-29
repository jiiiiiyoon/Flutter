import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shallwe_app/config/color_palette.dart';
import '../../size.dart';
import '../../custom_widget/custom_textformfield.dart';
import '../../custom_widget/custom_button.dart';
import './sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();
  late String _userEmail;
  late String _UserPassword;

  void _tryValidation() async {
    final isValid = _formkey.currentState!.validate();
    print(isValid);
    if (isValid) {
      _formkey.currentState!.save();
      //firebase 로그인
      await signin();
      print('signin end');
    }
  }

  Future<void> signin() async {
    await Duration(seconds: 3);
    print('signin');
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
                        _UserPassword = value!;
                      },
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
                    () {
                      print('signin buttom pressed');
                      _tryValidation();
                    },
                    '로그인',
                    context,
                  ),
                  customElevatedButton(
                    () {
                      print('signup button clicked');
                      Navigator.push(
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
                      'assets/naver_signin.png',
                      width: 320 * getScaleWidth(context),
                      height: 72 * getScaleWidth(context),
                    ),
                    onTap: () {
                      print('naver login');
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'assets/kakao_signin.png',
                      width: 320 * getScaleWidth(context),
                      height: 72 * getScaleWidth(context),
                    ),
                    onTap: () {
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
}
