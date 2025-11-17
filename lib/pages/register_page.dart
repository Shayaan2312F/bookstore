// import 'package:flutter/material.dart';
// import 'package:flutter_project_2208e/pages/create_profile.dart';
// import 'package:flutter_project_2208e/pages/login_page.dart';
//
// import '../services/auth_service.dart';
// import '../services/validation.dart';
// import '../widgets/beveled_button.dart';
//
// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});
//
//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   final _formKey = GlobalKey<FormState>();
//   late bool _obscured;
//   final togglePasswordFocusNode = FocusNode();
//   final _focusEmail = FocusNode();
//   final _focusPassword = FocusNode();
//
//   String? email;
//   String? password;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _obscured = false;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Register Page',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         automaticallyImplyLeading: false,
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//             child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Card(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           const CircleAvatar(
//                             radius: 50,
//                             backgroundColor: Colors.yellow,
//                             child: CircleAvatar(
//                               radius: 40,
//                               backgroundColor: Colors.black,
//                               //backgroundImage: AssetImage(""),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           TextFormField(
//                             style: Theme.of(context).textTheme.bodyMedium,
//                             maxLength: 30,
//                             focusNode: _focusEmail,
//                             decoration: const InputDecoration(
//                                 prefixIcon: Icon(Icons.email_outlined),
//                                 labelText: "User Email",
//                                 hintText: "Enter User Email"),
//                             keyboardType: TextInputType.emailAddress,
//                             validator: validateEmail,
//                             onSaved: (value) {
//                               setState(() {
//                                 email = value;
//                               });
//                             },
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           TextFormField(
//                             style: Theme.of(context).textTheme.bodyMedium,
//                             maxLength: 8,
//                             focusNode: _focusPassword,
//                             obscureText: !_obscured,
//                             decoration: InputDecoration(
//                                 prefixIcon: const Icon(Icons.key),
//                                 labelText: "User Password",
//                                 hintText: "Enter User Password",
//                                 suffixIcon: Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(0, 0, 4, 0),
//                                   child: GestureDetector(
//                                     onTap: _toggleObscured,
//                                     child: Icon(_obscured
//                                         ? Icons.visibility_rounded
//                                         : Icons.visibility_off_rounded),
//                                   ),
//                                 )),
//                             keyboardType: TextInputType.number,
//                             validator: validatePass,
//                             onSaved: (value) {
//                               setState(() {
//                                 password = value;
//                               });
//                             },
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           beveledButton(
//                               title: "Create User",
//                               onTap: () {
//                                 onPressSubmit();
//                               }),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           beveledButton(
//                               title: "Login",
//                               onTap: () {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const LoginPage()));
//                               }),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )),
//       ),
//     );
//   }
//
//   void onPressSubmit() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       AuthenticateHelper()
//           .signUp(email: email.toString(), password: password.toString())
//           .then((result) {
//         // AuthenticateHelper().signOut();
//         if (result == null) {
//           Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => UserProfile(
//                         email: email.toString(),
//                       )));
//         } else {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text(result)));
//         }
//       });
//       //  Navigator.pushReplacement(
//       //                               context,
//       //                               MaterialPageRoute(
//       //                                   builder: (context) =>  UserProfile(email: email.toString(),)));
//     }
//   }
//
//   void _toggleObscured() {
//     setState(() {
//       _obscured = !_obscured;
//       if (togglePasswordFocusNode.hasPrimaryFocus) {
//         return;
//       }
//       togglePasswordFocusNode.canRequestFocus = false;
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_project_2208e/pages/create_profile.dart';
import 'package:flutter_project_2208e/pages/login_page.dart';

import '../services/auth_service.dart';
import '../services/validation.dart';
import '../widgets/beveled_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late bool _obscured;

  // Initializing FocusNodes for resource management
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  String? email;
  String? password;

  @override
  void initState() {
    _obscured = false;
    super.initState();
  }

  // IMPORTANT: Dispose of FocusNodes to prevent memory leaks
  @override
  void dispose() {
    _focusEmail.dispose();
    _focusPassword.dispose();
    super.dispose();
  }

  // Toggles the visibility of the password
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  // Handles form submission, validation, and sign-up logic
  void onPressSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Use the local variables populated by onSaved
      AuthenticateHelper()
          .signUp(email: email.toString(), password: password.toString())
          .then((result) {
        if (result == null) {
          // Success: Navigate to profile creation page
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => UserProfile(
                    email: email.toString(),
                  )));
        } else {
          // Failure: Show error message
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Page',
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
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
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
                                  child: Icon(Icons.person_add, color: Colors.white, size: 40),
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
                                  email = value;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyMedium,
                                // Removed restrictive maxLength: 8 for better security
                                focusNode: _focusPassword,
                                obscureText: !_obscured,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock_outline),
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
                                // Changed keyboardType from .number to .text for full password support
                                keyboardType: TextInputType.text,
                                validator: validatePass,
                                onSaved: (value) {
                                  password = value;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              beveledButton(
                                  title: "Create Account",
                                  onTap: onPressSubmit),
                              const SizedBox(
                                height: 20,
                              ),
                              beveledButton(
                                  title: "Go to Login",
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const LoginPage()));
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
}