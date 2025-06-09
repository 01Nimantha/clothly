import 'package:clothly/data/google_sign_in_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Image(
                        image: AssetImage(
                          "./assets/Iic_launcher.png",
                        ),
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "About Clothly",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome to Clothly – your one-stop fashion destination!At Clothly, we believe that everyone deserves to look and feel their best. Our app is designed to bring you a smooth and personalized shopping experience right from the comfort of your home. Whether you’re looking for casual T-shirts, stylish hoodies, or trendy jeans, Clothly offers a wide variety of high-quality clothing to suit every taste and budget.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("🛍️ What We Offer:"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "⦿ A curated collection of stylish and comfortable wear.\n⦿ Easy browsing with category filters like T-shirts, Hoodies, and Jeans.\n⦿ User-friendly interface for a seamless shopping journey."),
                ],
              ),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              title: Text("${user.displayName}"),
              subtitle: Text("${user.email}"),
            ),
          ),
          Card(
            child: ElevatedButton.icon(
                style: ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(
                    Size(double.infinity, 50),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Optional: rounded corners
                    ),
                  ),
                ),
                onPressed: () {
                  Provider.of<GoogleSignInProvider>(context, listen: false)
                      .logout();
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                ),
                label: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
