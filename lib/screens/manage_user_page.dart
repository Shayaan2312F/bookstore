// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_project_2208e/services/user_profile_dao.dart';
// import 'package:flutter_project_2208e/widgets/manage_user_drawer.dart';
//
// import '../models/user_profile.dart';
// import '../widgets/beveled_button.dart';
//
// class ManageUserPage extends StatefulWidget {
//   const ManageUserPage({super.key});
//   static const String routeName = '/ManageUserPage';
//
//   @override
//   State<ManageUserPage> createState() => _ManageUserPageState();
// }
//
// class _ManageUserPageState extends State<ManageUserPage> {
//   late String displayName;
//   late String uuid;
//   final Future<FirebaseApp> _future = Firebase.initializeApp();
//   UserProfileDao userProfileDao = UserProfileDao();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user != null) {
//       setState(() {
//         displayName = user.displayName.toString();
//         uuid = user.uid.toString();
//       });
//     } else {
//       displayName = "Unknown User";
//     }
//     final connectedRef = userProfileDao.getMessageQuery(uuid);
//     connectedRef.keepSynced(true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         drawer: ManageUserDrawer(
//           displayName: displayName,
//         ),
//         appBar: AppBar(
//           title: Text(
//             'Manage User',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//         ),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: FutureBuilder(
//                 future: _future,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Text(snapshot.error.toString());
//                   } else {
//                     return FirebaseAnimatedList(
//                         query: userProfileDao.getMessageQuery(uuid),
//                         itemBuilder: (context, snapshot, animation, index) {
//                           final json = snapshot.value as Map<dynamic, dynamic>;
//                           final userData = UsersProfile.fromJson(json);
//                           return Card(
//                             elevation: 10.0,
//                             color: Colors.white,
//                             margin: const EdgeInsets.all(20.0),
//                             child: Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   //displayName, mobile, email, city, address
//                                   const Text("Name:"),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(userData.displayName),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   const Text("Mobile No: "),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(userData.mobile),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   const Text("Email:"),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(userData.email),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   const Text("City:"),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(userData.city),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   const Text("Address:"),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(userData.address),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   SizedBox(
//                                       width: MediaQuery.of(context).size.width,
//                                       child: beveledButton(
//                                           title: "Edit User", onTap: () {}))
//                                 ],
//                               ),
//                             ),
//                           );
//                         });
//                   }
//                 }),
//           ),
//         ));
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2208e/services/user_profile_dao.dart';
import 'package:flutter_project_2208e/widgets/manage_user_drawer.dart';

import '../models/user_profile.dart';
import '../widgets/beveled_button.dart';

class ManageUserPage extends StatefulWidget {
  const ManageUserPage({super.key});
  static const String routeName = '/ManageUserPage';

  @override
  State<ManageUserPage> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUserPage> {
  // Initialize with safe defaults instead of 'late' to prevent errors if user is null/loading
  String _displayName = "Loading...";
  String _uuid = "";

  // The Firebase initialization future is correct
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final UserProfileDao _userProfileDao = UserProfileDao();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  // Separate function to load user information and update state
  void _loadUserInfo() {
    // We can use an onAuthStateChanged listener here for real-time updates,
    // but checking currentUser once in initState is often sufficient after a successful login.
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        // Use null-aware operators (??) for safety
        _displayName = user.displayName ?? "No Display Name";
        _uuid = user.uid;
      });
      // The keepSynced call should ideally be handled within the DAO or after FutureBuilder completes.
      // We rely on the query inside the FutureBuilder.
    } else {
      // Handle unauthenticated state
      setState(() {
        _displayName = "Guest User (Please Log In)";
        _uuid = ""; // Set to empty to block queries
      });
    }
  }

  // Helper widget for a cleaner display of user details
  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ManageUserDrawer(
          displayName: _displayName,
        ),
        appBar: AppBar(
          title: Text(
            'Manage User',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  // 1. Handle Initialization Errors (where the URL error shows up)
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Firebase Initialization Error: ${snapshot.error.toString()}\n\nCheck your Realtime Database URL configuration!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    );
                  }

                  // 2. Handle Loading State
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // 3. Handle Firebase Initialized + Authentication Check
                  if (_uuid.isEmpty) {
                    return const Center(
                        child: Text(
                          'User not authenticated. Please log in to view your profile.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ));
                  }

                  // 4. Data Loading (FirebaseAnimatedList)
                  return FirebaseAnimatedList(
                    // Only query if _uuid is valid (checked above)
                      query: _userProfileDao.getMessageQuery(_uuid),
                      itemBuilder: (context, snapshot, animation, index) {
                        // Check if data exists at the path
                        if (snapshot.value == null) {
                          return const Center(child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text(
                              'No user profile found. Please complete your profile.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ));
                        }

                        // Parse data
                        final json = snapshot.value as Map<dynamic, dynamic>;
                        final userData = UsersProfile.fromJson(json);

                        return Card(
                          elevation: 10.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          margin: const EdgeInsets.all(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _buildDetailRow(context, "Name:", userData.displayName),
                                _buildDetailRow(context, "Mobile No: ", userData.mobile),
                                _buildDetailRow(context, "Email:", userData.email),
                                _buildDetailRow(context, "City:", userData.city),
                                _buildDetailRow(context, "Address:", userData.address),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: beveledButton(
                                        title: "Edit User", onTap: () {
                                      // TODO: Implement navigation to edit profile page
                                    }))
                              ],
                            ),
                          ),
                        );
                      });
                }),
          ),
        ));
  }
}