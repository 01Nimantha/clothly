import 'package:clothly/data/google_sign_in_provider.dart';
import 'package:clothly/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LogingPage extends StatelessWidget {
  const LogingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(color: const Color.fromARGB(255, 48, 167, 171)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  image: AssetImage(
                    "./assets/ic_launcher_foreground.png",
                  ),
                  width: 500,
                  height: 500,
                ),
              ),
              Text(
                "Hey There,\nWelcome Back",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Login to your account to continue",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Signin(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                label: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
