import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haggle_x/utils/constants.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 1000), () => {
      Navigator.pushNamed(context, "/login")
    });
    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(SCREEN_PADDING),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/ic_launcher.png"),
                Padding(padding: EdgeInsets.all(20.0)),
                Text(
                  APP_NAME,
                  style: TextStyle(color: Colors.white, fontSize: MEDIUM_FONT_SIZE),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
