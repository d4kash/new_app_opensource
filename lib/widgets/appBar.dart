import 'dart:async';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/auth/presentation/auth_screen.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/network/connectivity_controller.dart';



class AppBarScreen extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  AppBarScreen({Key? key, required this.title})
      : preferredSize = Size.fromHeight(Constant.height / 7),
        super(key: key);

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();
}

class _AppBarScreenState extends State<AppBarScreen> {
  
  late ConnectivityService _connectivityService;
  @override
  void initState() {
    _connectivityService = Get.find<ConnectivityService>();

    // _connectivityService.listenToNetworkChanges(context);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _connectivityService.listenToNetworkChanges(context);
    super.didChangeDependencies();
  }

final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: IconButton( onPressed: ()async { 
final User? currentUser =  _auth.currentUser;
                              try {
                                if (currentUser!.providerData[0].providerId ==
                                    'google.com') {
                                  print("in if condn");
                                  await GoogleSignIn().signOut().then((value) =>
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => AuthScreen()),
                                          (route) => false));
                                  // await googleSignIn.disconnect();
                                } else {
                                  print("in else condn");
                                  await FirebaseAuth.instance.signOut().then((value) {
                                  
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => AuthScreen()),
                                        (route) => false);
                                  });
                                }
                              } catch (e) {
                                debugPrint("$e");
                  }

             }, icon:const Icon(Icons.logout),),
          ),
        ],
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff3e849c), // <-- SEE HERE
          // statusBarColor: Color.fromARGB(255, 39, 126, 170), // <-- SEE HERE
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        title: Text(widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Constant.height / 28,
            )),
        toolbarHeight: Constant.height / 7.5,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
                colors: [Color(0xff66D7EB), Color(0xff2C5F78)],
                // colors: [Colors.pink, Colors.yellow.shade200],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
        ),
      ),
    );
  }
}

// class ErrorBanner extends StatelessWidget {
//   const ErrorBanner({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
//         backgroundColor: Colors.deepOrange,
//         contentTextStyle:
//             TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
//         content: Row(
//           children: [
//             Icon(Icons.wifi_off_outlined),
//             Text('No Internet or Wifi connection'),
//           ],
//         ),
//         actions: []));
//   }
// }
