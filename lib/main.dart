import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:haggle_x/auth/login/login_screen.dart';
import 'package:haggle_x/auth/signup/country_codes/blocs/country_code_change_notifier.dart';
import 'package:haggle_x/auth/signup/create_account/create_account_screen.dart';
import 'package:haggle_x/auth/verify_account/verify_account_screen.dart';
import 'package:haggle_x/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'auth/signup/country_codes/country_codes_screen.dart';

void main() async {
  await initHiveForFlutter();

  runApp(HaggleXApp());
}

class HaggleXApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink("https://hagglex-backend-staging.herokuapp.com/graphql");
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
          link: httpLink,
          cache: GraphQLCache(
            store: HiveStore(),
          )),
    );
    return GraphQLProvider(
      client: client,
      child: ChangeNotifierProvider<CountryCodeChangeNotifier>(
        create: (context) => CountryCodeChangeNotifier(),
        child: MaterialApp(
          routes: {
            "/": (ctx) => SplashScreen(),
            "/login": (ctx) => LoginScreen(),
            "/country_codes": (ctx) => CountryCodeScreen(),
            "/sign_up": (ctx) => CreateAccountScreen(),
            "/verify_account": (ctx) => VerifyAccountScreen(),
          },
          theme: ThemeData(
            primaryColor: Color(0xFF2E1963),
            scaffoldBackgroundColor: Color(0xFF2E1963),
            accentColor: Color(0xFFBA3AF9),
            buttonColor: Color(0xFFFFC175),
          ),
        ),
      ),
    );
  }
}
