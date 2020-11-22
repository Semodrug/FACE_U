import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:google_sign_in/google_sign_in.dart';


String google_photo = 'https://firebasestorage.googleapis.com/v0/b/final-5dc57.appspot.com/o/2513B53E55DB206927.png?alt=media&token=96b54435-9d4f-41f8-a195-a437577c7eaf';
String google_email = 'google email';

bool goo = false;
bool anoo = false;

/// Entrypoint example for various sign-in flows with Firebase.
class LogInPage extends StatefulWidget {

  /// The page title.
  final String title = 'Sign In & Out';

  @override
  State<StatefulWidget> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.camera, size: 50,),
            SizedBox(height: 30),
            FlatButton(
              child: Text('홈'),
              onPressed: (){
                Navigator.pushNamed(context, '/home');
              },
            )
            //_AnonymouslySignInSection(),
            //_OtherProvidersSignInSection(),
          ],
        );
      }),
    );
  }

}
/*
class _AnonymouslySignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnonymouslySignInSectionState();
}

class _AnonymouslySignInSectionState extends State<_AnonymouslySignInSection> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _success;
  String _userID;

  String _user_id_ano;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.center,
                  child: SignInButtonBuilder(
                    text: "Guest",
                    icon: Icons.person_outline,
                    backgroundColor: Colors.deepPurple,
                    onPressed: () async
                    {
                      _signInAnonymously();
                    },
                  ),
                ),
                Visibility(
                  visible: _success == null ? false : true,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      _success == null
                          ? ''
                          : (_success
                          ? 'Successfully signed in, uid: ' + _userID
                          : 'Sign in failed'),
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                )
              ],
            )));
  }

  // Example code of how to sign in anonymously.
  void _signInAnonymously() async {
    try {
      final User user = (await _auth.signInAnonymously()).user;
//
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content: Text("Signed in Anonymously as user ${user.uid}"),
//      ));

      anoo = true;
      Navigator.pushNamed(context, '/home');


    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in Anonymously"),
      ));
    }
  }

}

class _OtherProvidersSignInSection extends StatefulWidget {
  _OtherProvidersSignInSection();

  @override
  State<StatefulWidget> createState() => _OtherProvidersSignInSectionState();
}

class _OtherProvidersSignInSectionState
    extends State<_OtherProvidersSignInSection> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(5),
          //padding: const EdgeInsets.only(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.center,
                child: SignInButton(
                  Buttons.GoogleDark,
                  text: "Google",
                  onPressed: () async {
                    _signInWithGoogle();
                  },
                ),
              ),
            ],
          )),
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
        google_photo = googleUser.photoUrl;
        google_email = googleUser.email;

        print(googleUser.photoUrl);
        print(googleUser.email);


        userCredential = await _auth.signInWithCredential(googleAuthCredential);
      }

      final user = userCredential.user;
      //TODO: 이부분 snackbar 없애고, 바로 home으로 가게끔
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content: Text("Sign In ${user.uid} with Google"),
//      ));

      goo = true;
      await Navigator.pushNamed(context, '/home');


    } catch (e) {
      print(e);

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Google: ${e}"),
      ));
    }


  }
}

*/