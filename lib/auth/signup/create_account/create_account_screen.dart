import 'package:flutter/material.dart';
import 'package:haggle_x/auth/signup/country_codes/blocs/country_code_change_notifier.dart';
import 'package:haggle_x/utils/constants.dart';
import 'package:haggle_x/utils/utils.dart';
import 'package:haggle_x/utils/widgets/custom_back_button.dart';
import 'package:haggle_x/utils/widgets/custom_button.dart';
import 'package:haggle_x/utils/widgets/custom_text_form_field.dart';
import 'package:haggle_x/utils/widgets/form_padding.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: CustomBackButton()
      ),
      body: Container(
        padding: EdgeInsets.all(SCREEN_PADDING),
        child: Container(
          padding: EdgeInsets.all(SCREEN_PADDING),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create a new account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  FormPadding(),
                  CustomTextFormField(
                    hintText: "Email Address",
                    floatingText: "Email",
                    isPasswordField: false,
                    enabledBorderColor: Colors.black,
                    controller: TextEditingController(),
                    textColor: Colors.black,
                    validator: emailValidator,
                    hintColor: Colors.black87,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  FormPadding(0.5),
                  CustomTextFormField(
                    hintText: "Password (Min. 8 characters)",
                    floatingText: "Password",
                    isPasswordField: true,
                    enabledBorderColor: Colors.black,
                    controller: TextEditingController(),
                    textColor: Colors.black,
                    validator: passwordValidator,
                    hintColor: Colors.black87,
                    keyboardType: TextInputType.text,
                  ),
                  FormPadding(0.5),
                  CustomTextFormField(
                    hintText: "Create a username",
                    floatingText: "Create a username",
                    isPasswordField: false,
                    enabledBorderColor: Colors.black,
                    controller: TextEditingController(),
                    textColor: Colors.black,
                    validator: usernameValidator,
                    hintColor: Colors.black87,
                    keyboardType: TextInputType.text,
                  ),
                  FormPadding(0.5),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.grey.shade100),
                          child: IconButton(
                              icon: Row(
                                children: [
                                  Image.network(
                                      Provider.of<CountryCodeChangeNotifier>(
                                              context)
                                          .getCountryCode()
                                          .flag),
                                  Expanded(
                                    child: Text(Provider.of<CountryCodeChangeNotifier>(
                                            context)
                                        .getCountryCode()
                                        .dialCode),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed("/country_codes");
                              }),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                      Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          hintText: "Enter your phone number",
                          floatingText: "Enter your phone number",
                          isPasswordField: false,
                          enabledBorderColor: Colors.black,
                          controller: TextEditingController(),
                          textColor: Colors.black,
                          validator: phoneNumberValidator,
                          hintColor: Colors.black87,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  FormPadding(0.5),
                  CustomTextFormField(
                    hintText: "Referral link(optional)",
                    floatingText: "Referral link",
                    isPasswordField: false,
                    enabledBorderColor: Colors.black,
                    controller: TextEditingController(),
                    textColor: Colors.black,
                    validator: referralLinkValidator,
                    hintColor: Colors.black87,
                    keyboardType: TextInputType.url,
                  ),
                  FormPadding(),
                  Text("By signing up, you agree to HaggleX terms and privacy policy", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                  FormPadding(),
                  CustomButton(
                    text: "SIGN UP",
                    textColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    onClick: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
