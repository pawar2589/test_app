import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/whether_provider.dart';
import 'package:test_app/screens/loginpage.dart';
import 'package:test_app/utility/toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
        apiKey: "AIzaSyCFNG6yPjlML_mYlX1steSFaFG5qnUXRcM",
        appId: "1:787196880585:android:2b1763afba6732f89d8f18",
        messagingSenderId: "1:787196880585:android:2b1763afba6732f89d8f18",
        projectId: "test-app-b5e92",
        storageBucket: "test-app-b5e92.appspot.com"),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

late Connectivity _connectivity;
late StreamSubscription<ConnectivityResult> _connectivitySubscription;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        commonToast("Internet connection lost");
      } else {
        commonToast("Internet connected");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Loginpage(),
    );
  }
}
