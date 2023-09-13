import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/presentation/auth_screen.dart';
import 'package:news_app/general_news/presentation/home_page.dart';

class UserLoggedIn extends StatelessWidget {
 const UserLoggedIn({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              //  FlutterNativeSplash.remove();
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else {
                if (snapshot.hasData) {
                  // print("sign in Handler data : ${snapshot.data}");
                  // debugPrint("sent to Loding Page : ${snapshot.data!}");
                  // UserModel userModel = UserModel.fromJson(snapshot.data!);
                  return HomeScreen();
                  // return HomePage(
                  //   user: snapshot.data!,
                  // );
                } else {
                  // return LoginScreen();
                  return AuthScreen();
                }
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ));
  }

}
