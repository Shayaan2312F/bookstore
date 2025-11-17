import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2208e/pages/register_page.dart';
import 'package:flutter_project_2208e/screens/home_page.dart';
import 'package:flutter_project_2208e/services/auth_service.dart';
import 'package:flutter_project_2208e/services/validation.dart';
import 'package:flutter_project_2208e/widgets/beveled_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late bool _obscured;
  final togglePasswordFocusNode = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  String? email;
  String? password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscured = false;
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login Page",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.yellow,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.black,
                              //backgroundImage: AssetImage(""),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLength: 30,
                            focusNode: _focusEmail,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                labelText: "User Email",
                                hintText: "Enter User Email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                            onSaved: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLength: 8,
                            focusNode: _focusPassword,
                            obscureText: !_obscured,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.key),
                                labelText: "User Password",
                                hintText: "Enter User Password",
                                suffixIcon: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  child: GestureDetector(
                                    onTap: _toggleObscured,
                                    child: Icon(_obscured
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded),
                                  ),
                                )),
                            keyboardType: TextInputType.number,
                            validator: validatePass,
                            onSaved: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          beveledButton(
                              title: "Login",
                              onTap: () {
                                onPressSubmit();
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          beveledButton(
                              title: "Register",
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()));
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  void onPressSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // if (email.toString()=="umer@aptechgdn.net" && password.toString()=="12345678") {
      //    Navigator.pushReplacement(
      //                             context,
      //                             MaterialPageRoute(
      //                                 builder: (context) => const HomePage()));
      // }
      AuthenticateHelper()
          .signIn(email: email.toString(), password: password.toString())
          .then((result) {
        if (result == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
      });
    }
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (togglePasswordFocusNode.hasPrimaryFocus) {
        return;
      }
      togglePasswordFocusNode.canRequestFocus = false;
    });
  }
}
