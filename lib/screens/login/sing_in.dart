import 'package:flutter/material.dart';
import 'package:shallwe_app/config/color_palette.dart';
import '../../size.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();
  late String _userEmail;
  late String _UserPassword;

  void _tryValidation() {
    final isValid = _formkey.currentState!.validate();
    print(isValid);
    if (isValid) {
      _formkey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _SignInBody(),
    );
  }

  Widget _SignInBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 164 * getScaleHeight(context)),
        Container(
          margin: EdgeInsets.only(
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
                    TextFormField(
                      key: ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      validator: (value) {
                        return (value!.isEmpty || !value.contains('@'))
                            ? '이메일 주소를 입력해주세요'
                            : null;
                      },
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email_rounded),
                        hintText: '이메일을 입력해주세요.',
                        hintStyle: TextStyle(
                          color: const Color(0xff999999),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansCJKkr",
                          fontStyle: FontStyle.normal,
                          fontSize: 24.0 * getScaleHeight(context),
                        ),
                        fillColor: Palette.TextFieldColor,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.borderColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20 * getScaleHeight(context)),
                    TextFormField(
                      key: ValueKey('pw'),
                      obscureText: true,
                      autofocus: false,
                      validator: (value) {
                        return (value!.isEmpty || value.length < 6)
                            ? '7자 이상 입력하세요'
                            : null;
                      },
                      onSaved: (value) {
                        _UserPassword = value!;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded),
                        hintText: '비밀번호를 입력해주세요',
                        hintStyle: TextStyle(
                          color: const Color(0xff999999),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansCJKkr",
                          fontStyle: FontStyle.normal,
                          fontSize: 24.0 * getScaleHeight(context),
                        ),
                        fillColor: Palette.TextFieldColor,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.borderColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 54 * getScaleHeight(context)),

              //폼 로그인 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('signin buttom pressed');
                      _tryValidation();
                    },
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        fontFamily: "NotoSansCJKkr",
                        fontStyle: FontStyle.normal,
                        fontSize: 32.0 * getScaleHeight(context),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(322 * getScaleWidth(context),
                          104 * getScaleHeight(context)),
                      shadowColor: Palette.mintColor,
                      elevation: 5.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('signup button clicked');
                    },
                    child: Text('회원가입',
                        style: TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          fontFamily: "NotoSansCJKkr",
                          fontStyle: FontStyle.normal,
                          fontSize: 32.0 * getScaleHeight(context),
                        )),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(322 * getScaleWidth(context),
                          104 * getScaleHeight(context)),
                      shadowColor: Palette.mintColor,
                      elevation: 5.0,
                    ),
                  )
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
