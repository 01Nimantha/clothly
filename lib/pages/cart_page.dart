import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clothly/data/cart_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeItem(Map<String, dynamic> value) {
    Provider.of<CartProvider>(context, listen: false).removefromCart(value);
  }

  double totalprice = 0;
  double getTotalPrice(List<Map<String, dynamic>> listmap) {
    double total = 0;
    for (Map<String, dynamic> x in listmap) {
      total += x["price"];
    }
    return total;
  }

  @override
  void didChangeDependencies() {
    totalprice = getTotalPrice(Provider.of<CartProvider>(context).cartArr);
    super.didChangeDependencies();
  }

  Map<String, dynamic>? intentPaymentData;

  showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        intentPaymentData = null;
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Payment Successful!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            content: Text(
                "Thank you for your purchase. Your payment has been processed successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );

        Provider.of<CartProvider>(context, listen: false).resetCart();
      }).onError((errorMessage, sTrace) {
        if (kDebugMode) {
          print(errorMessage.toString() + sTrace.toString());
        }
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Cancelled"),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  makeIntentForPayment(amount, currency) async {
    try {
      Map<String, dynamic> paymentInfo = {
        "amount": (int.parse(amount) * 100).toString(),
        "currency": currency,
        "payment_method_types[]": "card",
      };

      var responseFromStripeAPI = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: paymentInfo,
          headers: {
            "Authorization": "Bearer ${dotenv.env['secretKey'].toString()}",
            "Content-Type": "application/x-www-form-urlencoded"
          });
      if (kDebugMode) {
        print("responseFromStripeAPI : $responseFromStripeAPI");
      }

      return jsonDecode(responseFromStripeAPI.body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  paymentSheetInitialization(amount, currency) async {
    try {
      intentPaymentData = await makeIntentForPayment(amount, currency);
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  allowsDelayedPaymentMethods: true,
                  paymentIntentClientSecret:
                      intentPaymentData!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: "Clothly"))
          .then((value) {
        if (kDebugMode) {
          print(value);
        }
      });

      showPaymentSheet();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Provider.of<CartProvider>(context).cartArr.isEmpty
              ? Expanded(
                  child: Image(
                  image: AssetImage("./assets/empty-cart.png"),
                ))
              : Expanded(
                  child: ListView.builder(
                    itemCount:
                        Provider.of<CartProvider>(context).cartArr.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      Provider.of<CartProvider>(context)
                                          .cartArr[index]["imageLink"])),
                            ),
                          ),
                          title: Text(
                            Provider.of<CartProvider>(context).cartArr[index]
                                ["name"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                              "Price : US\$ ${Provider.of<CartProvider>(context).cartArr[index]["price"].toString()} \nSize : ${Provider.of<CartProvider>(context).cartArr[index]["selectedSize"]}"),
                          trailing: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Delete Product",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                        "Are you sure you want to remove the product from your cart?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            removeItem(
                                                Provider.of<CartProvider>(
                                                        context,
                                                        listen: false)
                                                    .cartArr[index]);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.delete,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 237, 237),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Total Price : ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      "US\$ $totalprice",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    paymentSheetInitialization(
                      totalprice.round().toString(),
                      "USD",
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 27, 27, 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Proceed to checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
