import 'dart:async';

import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int counter = 0;

  void loadingStatus() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        counter += 25;
      });
      loadingStatus();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadingStatus();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.fill)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Loading: $counter%',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CircularProgressIndicator(backgroundColor: Colors.white),
                const SizedBox(
                  height: 10,
                ),
                const Text('App Powered by Muhammad Umer',
                    style: TextStyle(color: Colors.white))
              ],
            ),
          )),
    );
  }
}
