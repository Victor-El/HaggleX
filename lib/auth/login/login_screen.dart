import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:haggle_x/utils/constants.dart';
import 'package:haggle_x/utils/utils.dart';
import 'package:haggle_x/utils/widgets/custom_button.dart';
import 'package:haggle_x/utils/widgets/custom_text_form_field.dart';
import 'package:haggle_x/utils/widgets/form_padding.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final loginMutation = """
  mutation loginUser(\$input: LoginInput!) {
  login(data: \$input) {
    token
  }
}
  """;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Mutation(
          options: MutationOptions(
            document: gql(loginMutation),
            onCompleted: (data) {
              if (data != null) {
                Navigator.pushNamed(context, "/dashboard");
              }
            },
            onError: (OperationException operationException) {
              print(operationException.graphqlErrors);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("An error occurred"),
                duration: Duration(seconds: 3),
              ));
            },
          ),
          builder: (runMutation, result) => Container(
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
                            controller: _emailController,
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
                            controller: _passwordController,
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
                          result.isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
                          CustomButton(
                            text: "LOG IN",
                            textColor: TEXT_BUTTON_COLOR,
                            backgroundColor: Theme.of(context).buttonColor,
                            onClick: result.isLoading ? null : () {
                              if (formKey.currentState.validate()) {
                                runMutation({
                                  "input": {
                                    "input": _emailController.text,
                                    "password": _passwordController.text
                                  }
                                });
                              }
                            },
                          ),
                          FormPadding(),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/sign_up");
                            },
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
        ),
      ),
    );
  }
}
