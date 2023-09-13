import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/constants/date_formatter.dart';
import 'package:news_app/constants/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  

  const ShimmerWidget(
      {super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
       itemCount: 6,
       itemBuilder: (context, index) {
        return Container(
        padding: const EdgeInsets.all(8),
        height: Constant.height / 5,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
              width: 130,
              height: 30,
              decoration: BoxDecoration(
                        color: appTheme.primaryColor,
                      ),
              ),
            ),
            ListTile(
              title: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                        color: appTheme.primaryColor,
                      ),
              ),
              subtitle:  Padding(
                padding:  const EdgeInsets.only(top: 8.0),
                child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                        color: appTheme.primaryColor,
                      ),
              ),
              ),
              trailing:  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      width: Constant.width / 4.2,
                      height: Constant.height / 2,
                      decoration: BoxDecoration(
                        color: appTheme.primaryColor,
                      ),
                     
                    )
            
                    
            ),
          ],
        ),
      );}))
    );
  }
}
