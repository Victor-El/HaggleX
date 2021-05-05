import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haggle_x/utils/constants.dart';
import 'package:haggle_x/utils/widgets/custom_button.dart';
import 'package:haggle_x/utils/widgets/form_padding.dart';

class SetupCompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: WillPopScope(
        onWillPop: () {
          SystemNavigator.pop(animated: true);
          return Future.value(true);
        },
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(SCREEN_PADDING),
            child: Column(
              children: [
                Expanded(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(VERIFIED_PHONE, height: 100, width: 100,),
                      FormPadding(0.5),
                      Text("Setup Complete", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),),
                      FormPadding(0.5),
                      Text("Thank you for setting up your HaggleX account.", style: TextStyle(color: Colors.white, fontSize: 12),),
                    ],
                  ),
                )),
                CustomButton(
                  text: "START EXPLORING",
                  textColor: TEXT_BUTTON_COLOR,
                  backgroundColor: Theme.of(context).buttonColor,
                  onClick: () {
                    Navigator.of(context).pushReplacementNamed("/dashboard");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
