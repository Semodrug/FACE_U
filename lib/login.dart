import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return ListView(
          padding: EdgeInsets.all(8),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(height: 280.0),
            Column(
              children: <Widget>[
                Text(
                  '안면인식 장애자를 위한',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w100),
                ),
                Text(
                  'FaceU',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 120.0),
            _OtherProvidersSignInSection(),
          ],
        );
      }),
    );
  }
}

class _OtherProvidersSignInSection extends StatefulWidget {
  _OtherProvidersSignInSection();

  @override
  State<StatefulWidget> createState() => _OtherProvidersSignInSectionState();
}

class _OtherProvidersSignInSectionState
    extends State<_OtherProvidersSignInSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 16.0),
          alignment: Alignment.center,
          child: FlatButton(
            child: Text("구글 아이디로 로그인"),
            minWidth: 343,
            height: 44,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              _signInWithGoogle();
            },
          ),
          // SignInButton(
          //   Buttons.GoogleDark,
          //   text: "구글 아이디로 로그인",
          //   onPressed: () async {
          //     _signInWithGoogle();
          //   },
          // ),
        ),
      ],
    );
  }

  //Example code of how to sign in with Google.
  void _signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final GoogleAuthCredential googleAuthCredential =
            GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
      }

      final user = userCredential.user;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Sign In ${user.uid} with Google"),
      ));
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print(e);

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Google: $e"),
      ));
    }
  }
}
