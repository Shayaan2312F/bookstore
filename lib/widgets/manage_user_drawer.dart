import 'package:flutter/material.dart';
import 'package:flutter_project_2208e/pages/sign_out.dart';

import '../routes/route_pages.dart';
import '../services/auth_service.dart';
import 'custom_drawer.dart';

class ManageUserDrawer extends StatelessWidget {
 const ManageUserDrawer({super.key, required this.displayName});
  final String displayName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.blueGrey[900],
      child: ListView(
        children: [
          createDrawerHeader(displayName: displayName),
          createDrawerBodyItem(
              icon: Icons.home,
              text: "Home",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, PageRoutes.home)),
          createDrawerBodyItem(
              icon: Icons.home,
              text: "Manage User",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, PageRoutes.muser)),          
          createDrawerBodyItem(
              icon: Icons.contact_page,
              text: "Log Out",
              onTap: () {
                AuthenticateHelper().signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignOutPage()));
              }),
          const Divider(color: Colors.yellow),
          const ListTile(
            title: Text(
              'App Version - 1.1.0',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ));
  }
}
