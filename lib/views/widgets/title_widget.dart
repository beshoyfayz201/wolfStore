import 'package:flutter/material.dart';

import '../../size_config.dart';

class title extends StatelessWidget {
  final String txt;
  const title({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.15,
      width: double.infinity,
      child: Stack(children: [
        Positioned(
            bottom: SizeConfig.screenHeight * 0.04,
            child: Container(
              height: SizeConfig.screenHeight * 0.07,
              width: SizeConfig.screenWidth * 0.5,
              alignment: Alignment.center,
              child: Text(
                txt,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 25,
                    fontFamily: "",
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(30))),
            ))
      ]),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(32))),
    );
  }
}
