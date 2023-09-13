
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/auth/presentation/email_auth/LoginScree.dart';
import 'package:news_app/constants/animated_page_route.dart';
import 'package:news_app/general_news/presentation/home_page.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signInFunction() async {

   
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExist =
        await firestore.collection('users').doc(userCredential.user!.uid).get();

    if (userExist.exists) {
      print("User Already Exists in Database");
    } else {
      try {
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          "username": userCredential.user!.email,
          'fullName': userCredential.user!.displayName,
          'image': userCredential.user!.photoURL,
          'uid': userCredential.user!.uid,
          'date': DateTime.now(),
          
        });
      } on FirebaseException catch (e) {
        // TODO
        print(e.toString());
      }
    }

    Navigator.pushReplacement(
      context,
      CustomPageRoute(
              transitionDuration:const Duration(milliseconds: 700),
              child: HomeScreen(),
              begin:const Offset(-1, 0)),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/Texting-pana.png",
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Open News",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: ElevatedButton(
                onPressed: () async {
                    Navigator.push(
          context,
          CustomPageRoute(
              transitionDuration:const Duration(milliseconds: 700),
              child: const LoginScreen(),
              // child: HomeScreen(),
              begin:const Offset(-1, 0)));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black,
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                  ),
                ),
                child: const Text(
                  "Email Login",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  await signInFunction();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black,
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                      height: 36,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sign in With Google",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
