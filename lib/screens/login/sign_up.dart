import 'package:flutter/material.dart';
import 'package:shallwe_app/custom_widget/custom_textformfield.dart';
import 'package:shallwe_app/custom_widget/custom_button.dart';
import '../../size.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                    _userEmail = value!;
                  },
                  '비밀번호',
                  '비밀번호를 입력해주세요',
                  context,
                ),
                CustomTextField(
                  ValueKey('pwcheck'),
                  TextInputType.visiblePassword,
                  (value) {
                    return (value!.isEmpty || value == _userPassword)
                        ? '비밀번호가 일치하지 않습니다.'
                        : null;
                  },
                  (value) {
                    _pwCheck = true;
                  },
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
                () {
                  //firebase 가입
                  print('signup firebase');
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
}
