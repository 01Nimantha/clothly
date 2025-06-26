import 'package:clothly/data/cart_provider.dart';
import 'package:clothly/data/filter_provider.dart';
import 'package:clothly/data/google_sign_in_provider.dart';
import 'package:clothly/pages/loging_page.dart';
import 'package:clothly/pages/navigation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
  );

  await dotenv.load(fileName: '.env');

  Stripe.publishableKey = dotenv.env['publishableKey'].toString();
  await Stripe.instance.applySettings();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => GoogleSignInProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: NavigationPage(),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something went wrong!"),
                  );
                }
                if (snapshot.hasData) {
                  return NavigationPage();
                }
                return LogingPage();
              }),
        ),
      ),
    );
  }
}
