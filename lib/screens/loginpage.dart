import 'package:flutter/material.dart';
import 'package:test_app/auth/google_auth.dart';
import 'package:test_app/utility/assets.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18))),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(AppAssets.whether),
                ),
                const Positioned(
                  bottom: 35,
                  child: Text(
                    "WEATHER",
                    style: TextStyle(fontSize: 45, color: Colors.black26),
                  ),
                ),
                const Positioned(
                  bottom: 20,
                  child: Text(
                    "Log in to your account !",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              FirebaseService.signInwithGoogle(context);
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(
                  left: 55,
                  right: 55,
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        height: 30,
                        width: 30,
                        child: Image.asset(AppAssets.googlelogo)),
                    const Text(
                      "Sign in with Google",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text("Or"),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(
                  left: 55,
                  right: 55,
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        height: 30,
                        width: 30,
                        child: Image.asset(AppAssets.facebook)),
                    const Text(
                      "Sign in with Facebook",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
