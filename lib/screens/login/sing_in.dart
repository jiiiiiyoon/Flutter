import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shallwe_app/screens/info/info.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  @override
  void initState() {
    _checkPermission();
    super.initState();
  }

  @override
  void dispose() {
    _authInstance.signOut();
    super.dispose();
  }

  _tryValidation() async {
    final isValid = _formkey.currentState!.validate();
    print('valid : ${isValid}');
    if (isValid) {
      _formkey.currentState!.save();
      await signIn();
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
          title: Text('티끌', style: TextStyle(color: Colors.white)),
          elevation: 0,
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
            '티끌 :\n지구를 생각하는 \n작은 마음',
            style: TextStyle(
              color: const Color(0xff000000),
              fontWeight: FontWeight.w700,
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
                        return (value!.isEmpty || value.length < 7)
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
                      FocusScope.of(context).unfocus();
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
                    onTap: () async {
                      print('google login');
                      await signInWithGoogle();
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'assets/facebook_signin.png',
                      width: 320 * getScaleWidth(context),
                      height: 72 * getScaleWidth(context),
                    ),
                    onTap: () async {
                      print('facebook login');
                      await signInWithFacebook();
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

      if (newUser.user != null) {
        await setCurrentUser(_authInstance, null);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoScreen(key: UniqueKey())));
      }
    } catch (error) {
      print('error: ${error}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디와 비밀번호를 다시 확인해주세요.')),
      );
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final newUser = await _authInstance.signInWithCredential(credential);
      if (newUser.user != null) {
        print(newUser.user!.displayName);

        // await createUserData(_authInstance, );
        await setCurrentUser(_authInstance, newUser.user!.displayName!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoScreen(key: UniqueKey())));
      }
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('동일한 이메일로 가입된 계정이 있습니다.')),
      );
    }
  }

  signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final newUser = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      if (newUser.user != null) {
        print(newUser.user!.displayName);

        // await createUserData(_authInstance, );
        await setCurrentUser(_authInstance, newUser.user!.displayName!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoScreen(key: UniqueKey())));
      }
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('동일한 이메일로 가입된 계정이 있습니다.')),
      );
    }
  }
}

_checkPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
}
