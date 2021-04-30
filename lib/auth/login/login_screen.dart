import 'package:flutter/material.dart';
import 'package:haggle_x/utils/constants.dart';
import 'package:haggle_x/utils/utils.dart';
import 'package:haggle_x/utils/widgets/custom_button.dart';
import 'package:haggle_x/utils/widgets/custom_text_form_field.dart';
import 'package:haggle_x/utils/widgets/form_padding.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(SCREEN_PADDING),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.all(SCREEN_PADDING * 1.8)),
              Text(
                "Welcome!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: LARGE_FONT_SIZE,
                    fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(SCREEN_PADDING)),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        hintText: "Email address",
                        floatingText: "Email Address",
                        hintColor: Colors.white54,
                        isPasswordField: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: emailValidator,
                        controller: TextEditingController(),
                        textColor: Colors.white,
                        enabledBorderColor: Colors.white,
                      ),
                      FormPadding(),
                      CustomTextFormField(
                        hintText: "Password (Min. 8 characters)",
                        floatingText: "Password",
                        hintColor: Colors.white54,
                        isPasswordField: true,
                        keyboardType: TextInputType.text,
                        validator: passwordValidator,
                        controller: TextEditingController(),
                        textColor: Colors.white,
                        enabledBorderColor: Colors.white,
                      ),
                      FormPadding(),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      FormPadding(2),
                      CustomButton(
                        text: "LOG IN",
                        textColor: TEXT_BUTTON_COLOR,
                        backgroundColor: Theme.of(context).buttonColor,
                        onClick: () {},
                      ),
                      FormPadding(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "New User? Create Account",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
