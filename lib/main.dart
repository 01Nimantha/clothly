import 'package:clothly/data/cart_provider.dart';
import 'package:clothly/data/filter_provider.dart';
import 'package:clothly/pages/loging_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  Stripe.publishableKey = dotenv.env['publishableKey']!;
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
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => FilterProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LogingPage(),
        ),
      ),
    );
  }
}
