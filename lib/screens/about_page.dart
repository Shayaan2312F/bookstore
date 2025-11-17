import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});
  static const String routeName = '/AboutUsPage';

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late String displayName;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      displayName = user.displayName.toString();
    } else {
      displayName = "Unknown User";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustNavigationDrawer(
        displayName: displayName,
      ),
      appBar: AppBar(
        title: Text(
          'About Us',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
       body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome to BookStore, your ultimate destination for discovering and enjoying books like never before! At BookStore, we are passionate about connecting readers with their next great read. Our mission is to offer a seamless and enjoyable book browsing experience right from your Android device. Whether you\'re searching for the latest bestsellers, timeless classics, or hidden gems, our curated collection and intuitive interface are designed to help you find exactly what you’re looking for. With a user-friendly design and a commitment to excellence, we strive to make your book shopping experience both enjoyable and effortless.',
              style: TextStyle(fontSize: 16,color:Color(0xFFFFFFFF)),
            ),
            SizedBox(height: 20),
            Center(
            child: Text(
              'Meet the Team',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color:Color.fromARGB(255, 248, 237, 22)),
            )),
            SizedBox(height: 10),
            Text(
              'Hammas - Founder & CEO', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color.fromARGB(255, 0, 0, 0)),),
              Text(
              'Hammas is the visionary behind BookStore, dedicated to creating a platform that brings the joy of reading to a broader audience. With a background in technology and a lifelong love for books, Hammas is passionate about merging these two worlds to enhance your reading experience.',
              style: TextStyle(fontSize: 16,color:Color(0xFFFFFFFF)),
            ),
            SizedBox(height: 10),
            Text(
              'Munzir - Chief Technology Officer',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color.fromARGB(255, 0, 0, 0)),),
              Text(
              'Munzir is the tech guru behind the scenes, ensuring that our app runs smoothly and efficiently. With a wealth of experience in Flutter development and a keen eye for detail, Emily ensures that BookStore remains at the cutting edge of technology.',
              style: TextStyle(fontSize: 16,color:Color(0xFFFFFFFF)),
            ),
            SizedBox(height: 10),
            Text(
              'Samyan - Chief Marketing Officer',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color.fromARGB(255, 0, 0, 0)),),
              Text(
              'Samyan is responsible for spreading the word about BookStore and building relationships with our readers and partners. With a background in digital marketing and a passion for literature,Samyan brings creativity and strategic thinking to our marketing efforts.',
              style: TextStyle(fontSize: 16,color:Color(0xFFFFFFFF)),
            ),
            SizedBox(height: 10),
            Text(
              'Jazib - Lead Designer',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color.fromARGB(255, 5, 5, 5)),),
              Text(
              'Jazib is the creative mind behind BookStore elegant and user-friendly design. With a strong background in UI/UX design and a love for books, Jazib ensures that our app not only looks great but also provides an exceptional user experience.',
              style: TextStyle(fontSize: 16,color:Color(0xFFFFFFFF)),
            ),
          ],
    )
       )
       );

  }
}
