import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constant {
  static final _auth = FirebaseAuth.instance;
  static double height = Get.size.height;
  static double width = Get.size.width;
  static String constuid = _auth.currentUser!.uid;


  
static errorNetworkBanner(BuildContext context) {
    return ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      
      content: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const  Icon(
              Icons.cloud_off_outlined,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 4,),
            Text('No internet Connection!',style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white,fontSize: 14),)
          ],
        ),
      ),
      actions: [Container()],
      backgroundColor: Colors.black,
      
    ));

  }
}
