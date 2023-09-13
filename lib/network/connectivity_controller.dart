import 'dart:async';
import 'dart:developer';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constants/constants.dart';

class ConnectivityService extends GetxController {
  late Connectivity connectivity;

  ConnectivityService(
    this.connectivity,
  );
  RxBool isConnected = true.obs;
  StreamSubscription? subscription;

  void listenToNetworkChanges(BuildContext context) {
    subscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile) {
        isConnected.value = true;
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        log('Now, Connection is on!');
      } else if (connectivityResult == ConnectivityResult.wifi) {
        isConnected.value = true;
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        log('Now, Connection is on!');
      } else {
        isConnected.value = false;
        log('Now, Connection is off!');
        Constant.errorNetworkBanner(context);
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose

    subscription!.cancel();
    super.onClose();
  }
}

class CustomErrorBanner {
  CustomErrorBanner._();


 static errorNetworkBanner(BuildContext context) {
    return ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      
      content: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width:10,),
            Text('No internet Connection!',style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white,fontSize: 14),)
          ],
        ),
      ),
      actions: [Container()],
      backgroundColor: Colors.black,
      
    ));

  }
}
