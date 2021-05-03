import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haggle_x/utils/constants.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 1000), () =>
    {
      Navigator.pushNamed(context, "/login")
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          HAGGLEX_IMAGE_PATH, frameBuilder: (ctx, child, frame, synced) {
          return Container(
            color: Theme
                .of(context)
                .primaryColor,
            padding: EdgeInsets.all(SCREEN_PADDING),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  child,
                  Padding(padding: EdgeInsets.all(10.0)),
                  Text(
                    APP_NAME,
                    style: TextStyle(
                        color: Colors.white, fontSize: MEDIUM_FONT_SIZE),
                  ),
                ],
              ),
            ),
          );
        },),
      ),
    );
  }
}
