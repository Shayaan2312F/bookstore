import 'package:flutter/material.dart';
import 'package:flutter_project_2208e/pages/sign_out.dart';
import 'package:flutter_project_2208e/services/auth_service.dart';

import '../routes/route_pages.dart';

class CustNavigationDrawer extends StatelessWidget {
  const CustNavigationDrawer({super.key, required this.displayName});
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
              icon: Icons.contact_page,
              text: "Books View",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, PageRoutes.prodview)),
          createDrawerBodyItem(
              icon: Icons.contact_page,
              text: "Manage Cart",
              onTap: () => Navigator.pushReplacementNamed(
                  context, PageRoutes.cart)),         
          createDrawerBodyItem(
              icon: Icons.contact_page,
              text: "My Orders",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, PageRoutes.order)),
          createDrawerBodyItem(
              icon: Icons.contact_page,
              text: "Approved orders",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, PageRoutes.approvedorder)),
           createDrawerBodyItem(
              icon: Icons.contact_page,
              text: "Manage User",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, PageRoutes.muser)),        
          createDrawerBodyItem(
              icon: Icons.contact_page,
              text: "About Us",
              onTap: () =>
                  Navigator.pushReplacementNamed(context, PageRoutes.about)),
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

Widget createDrawerBodyItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon, color: Colors.red),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}

Widget createDrawerHeader({required String displayName}) {
  return SizedBox(
    height: 250,
    child: DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/banner.jpg'), fit: BoxFit.fill)),
      child: Card(
        elevation: 10,
        color: Colors.black.withOpacity(0.6),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.yellow,
              child: CircleAvatar(
                radius: 50,
                //backgroundImage: AssetImage(""),
                backgroundColor: Colors.green,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(displayName, style: TextStyle(color: Colors.yellow[800]))
          ],
        ),
      ),
    ),
  );
}
