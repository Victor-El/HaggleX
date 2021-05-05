import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:haggle_x/utils/constants.dart';
import 'package:haggle_x/utils/utils.dart';
import 'package:haggle_x/utils/widgets/custom_back_button.dart';
import 'package:haggle_x/utils/widgets/custom_button.dart';
import 'package:haggle_x/utils/widgets/custom_text_form_field.dart';
import 'package:haggle_x/utils/widgets/form_padding.dart';

class VerifyAccountScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _verificationController = TextEditingController();

  final _verificationCodeQuery = """
  query resendVerification(\$input: EmailInput) {
  
  resendVerificationCode(data: \$input)
  
}
  """;

  final _verificationMutation = """
  mutation verifyUser(\$input: VerifyUserInput) {
  verifyUser(data: \$input) {
    token
  }
}
  """;

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: CustomBackButton(),
      ),
      body: Mutation(
        options: MutationOptions(
          document: gql(_verificationMutation),
          onCompleted: (data) {
            if (data != null) {
              Navigator.of(context).pushReplacementNamed("/setup_complete");
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
          padding: EdgeInsets.all(SCREEN_PADDING * 0.5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FormPadding(),
                Text(
                  "Verify your account",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                FormPadding(),
                Container(
                  padding: EdgeInsets.all(SCREEN_PADDING),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          VERIFY_PHONE,
                          width: 100,
                          height: 100,
                        ),
                        FormPadding(),
                        Text(
                          "We just sent a verification code to your email. \n Please enter the code",
                          textAlign: TextAlign.center,
                        ),
                        FormPadding(),
                        CustomTextFormField(
                          hintText: "Verification code",
                          floatingText: "Verification code",
                          isPasswordField: false,
                          enabledBorderColor: Colors.black,
                          validator: verificationCodeValidator,
                          keyboardType: TextInputType.number,
                          hintColor: Colors.black87,
                          textColor: Colors.black,
                          controller: _verificationController,
                        ),
                        FormPadding(),
                        CustomButton(
                          text: "VERIFY ME",
                          textColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          onClick: () {
                            runMutation({
                              "input": {
                                "code": int.parse(_verificationController.text)
                              }
                            });
                          },
                        ),
                        FormPadding(),
                        Text(
                          "This code will expire in 10 minutes",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                        FormPadding(),
                        InkWell(
                          child: Text(
                            "Resend Code",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            var client = GraphQLProvider.of(context).value;
                            var hello = client.query(QueryOptions(
                              document: gql(_verificationCodeQuery),variables: {
                              "input": {
                                "email": email
                              }
                            },
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
