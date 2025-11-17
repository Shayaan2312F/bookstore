// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_project_2208e/widgets/item_card.dart';
// import '../models/product.dart';
// import '../widgets/custom_drawer.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   static const String routeName = '/HomePage';

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late String displayName;
//   List<Product> products = [];
//   List<Product> venderRecomended = [];
//   List<Product> topSelling = [];

//   @override
//   void initState() {
//     super.initState();
//     // TODO: implement initState
//     final user = FirebaseAuth.instance.currentUser;
//     initProducts();
//     filterVenderRecommendedProducts();
//     filterTopSellingProducts();
//     if (user != null) {
//       displayName = user.displayName.toString();
//     } else {
//       displayName = "Unknown User";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Home',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//         ),
//         drawer: CustNavigationDrawer(
//           displayName: displayName,
//         ),
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             if (orientation == Orientation.portrait) {
//               return Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   // child: getItemCard(product: products[0], onCartTap: (){}, onFavoriteTap: (){})
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         color:Colors.white,
//                         width: MediaQuery.of(context).size.width,
//                         child: const Text("Vender's Recommended")),
//                       Expanded(
//                         flex: 1,
//                         child: ListView(
//                           children: [
//                             CarouselSlider(
//                               items: venderRecomended
//                                   .map((prd) => getItemCardCar(product: prd))
//                                   .toList(),
//                               options: CarouselOptions(
//                                 height: 220.0,
//                                 enlargeCenterPage: false,
//                                 autoPlay: true,
//                                 // aspectRatio: 16 / 9,
//                                 autoPlayCurve: Curves.fastOutSlowIn,
//                                 enableInfiniteScroll: true,
//                                 autoPlayAnimationDuration:
//                                     const Duration(milliseconds: 800),
//                                 viewportFraction: 0.4,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),

//                       Container(
//                        color: Colors.white,
//                        width: MediaQuery.of(context).size.width,
//                        child: const Text("Product List")),
//                       Expanded(
//                         flex: 2,
//                         child: Container(
//                           padding: const EdgeInsets.all(10.0),
//                           child: ListView.builder(
//                               itemCount: products.length,
//                               itemBuilder: (context, index) {
//                                 final prd = products[index];

//                                 return getItemCardSimple(product: prd);
//                               }),
//                         ),
//                       ),
//                       Container(
//                         color:Colors.white,
//                         width: MediaQuery.of(context).size.width,
//                         child: const Text("Top Selling")),
//                       Expanded(
//                         flex: 1,
//                         child: ListView(
//                           children: [
//                             CarouselSlider(
//                               items:
//                                   topSelling.map((prd) => getItemCardCar(product: prd))
//                                   .toList(),
//                               options: CarouselOptions(
//                                 height: 220.0,
//                                 enlargeCenterPage: false,
//                                 autoPlay: true,
//                                 // aspectRatio: 16 / 9,
//                                 autoPlayCurve: Curves.fastOutSlowIn,
//                                 enableInfiniteScroll: true,
//                                 autoPlayAnimationDuration:
//                                     const Duration(milliseconds: 800),
//                                 viewportFraction: 0.4,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),

//                     ],
//                   ));
//             } else {
//               return Container(
//                 padding: const EdgeInsets.all(20.0),
//                 child: const Center(
//                     child: Card(
//                         elevation: 10.0,
//                         margin: EdgeInsets.all(30),
//                         color: Colors.white,
//                         child: Card(
//                           elevation: 1.0,
//                           color: Colors.white,
//                           child: ListTile(
//                             title: Text('Warning'),
//                             subtitle: Text("Please change to prortrat view"),
//                           ),
//                         ))),
//               );
//             }
//           },
//         ));
//   }

//   @Deprecated(
//       'to be deleted in future, products list will be loaded from firebase')
//   void initProducts() {
//     products.add(Product(
//       code: "ring_heart_01",
//       name: "Ring Heart Supper",
//       price: 10500,
//       image: "prod_1.jpg",
//       status: "available",
//       desc: "ring forged in silver with elegant craftmenship",
//     ));
//     products.add(Product(
//       code: "pendent_heart_01",
//       name: "Pendent Heart Ruby",
//       price: 20500,
//       image: "prod_2.jpg",
//       status: "available",
//       desc: "pendent forged in silver with elegant craftmenship",
//     ));
//     products.add(Product(
//       code: "ring_heart_02",
//       name: "Ring Heart Male",
//       price: 10500,
//       image: "prod_3.jpg",
//       status: "out of stock",
//       desc:
//           "ring forged in silver with elegant craftmenship for authoritative personality",
//     ));
//     products.add(Product(
//       code: "ring_dark_01",
//       name: "Ring Darker Supper",
//       price: 40500,
//       image: "prod_4.jpg",
//       status: "available",
//       desc:
//           "ring forged in silver with elegant craftmenship for darker pesonalities",
//     ));
//     products.add(Product(
//       code: "ring_mist_01",
//       name: "Ring Magic Blood Stone",
//       price: 500500,
//       image: "prod_5.jpg",
//       status: "vender recommended",
//       desc: "ring forged in mistery metal with dark magic",
//     ));
//     products.add(Product(
//       code: "ring_pair_01",
//       name: "Ring Cube Pair",
//       price: 10500,
//       image: "prod_6.jpg",
//       status: "top selling",
//       desc: "ring forged in silver with elegant craftmenship for love birds",
//     ));
//     products.add(Product(
//       code: "NFT_01",
//       name: "Jullu Man",
//       price: 200599,
//       image: "prod_7.jpg",
//       status: "vender recommended",
//       desc: "picture with misterous power of jealousy",
//     ));
//     products.add(Product(
//       code: "NFT_02",
//       name: "Dark Army",
//       price: 299599,
//       image: "prod_8.jpg",
//       status: "top selling",
//       desc: "mesterous powers for clearing online exam of aptech garden center",
//     ));
//     products.add(Product(
//       code: "NFT_03",
//       name: "Groom of Karsaz Bride",
//       price: 200599,
//       image: "prod_9.jpg",
//       status: "available",
//       desc: "demon summoned for kidnapping your interest",
//     ));
//   }

//   void filterVenderRecommendedProducts() {
//     for (var product in products) {
//       if (product.status == "vender recommended") {
//         venderRecomended.add(product);
//       }
//     }
//   }

//   void filterTopSellingProducts() {
//     for (var product in products) {
//       if (product.status == "top selling") {
//         topSelling.add(product);
//       }
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_project_2208e/widgets/item_card.dart';
// import '../models/product.dart';
// import '../widgets/custom_drawer.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   static const String routeName = '/HomePage';

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late String displayName;
//   List<Product> products = [];
//   List<Product> venderRecomended = [];
//   List<Product> topSelling = [];

//   @override
//   void initState() {
//     super.initState();
//     final user = FirebaseAuth.instance.currentUser;
//     initProducts();
//     filterVenderRecommendedProducts();
//     filterTopSellingProducts();
//     displayName = user?.displayName ?? "Unknown User";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Home',
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//       ),
//       drawer: CustNavigationDrawer(displayName: displayName),
//       body: OrientationBuilder(
//         builder: (context, orientation) {
//           if (orientation == Orientation.portrait) {
//             return Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   sectionTitle(context, "Vendor's Recommended"),
//                   Flexible(child: carouselSection(venderRecomended)),
//                   sectionTitle(context, "Product List"),
//                   expandedListSection(products),
//                   sectionTitle(context, "Top Selling"),
//                   Flexible(child: carouselSection(topSelling)),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(
//               child: Card(
//                 elevation: 10.0,
//                 margin: EdgeInsets.all(30),
//                 color: Colors.white,
//                 child: Padding(
//                   padding: EdgeInsets.all(20.0),
//                   child: ListTile(
//                     title: Text('Warning'),
//                     subtitle: Text("Please change to portrait view"),
//                   ),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget sectionTitle(BuildContext context, String title) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Text(
//         title,
//         style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.blueGrey),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   Widget carouselSection(List<Product> products) {
//     return CarouselSlider(
//       items: products.map((prd) => getItemCardCar(product: prd)).toList(),
//       options: CarouselOptions(
//         height: 350.0,
//         enlargeCenterPage: false,
//         autoPlay: true,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enableInfiniteScroll: true,
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         viewportFraction: 0.4,
//       ),
//     );
//   }

//   Widget expandedListSection(List<Product> products) {
//     return Expanded(
//       flex: 2,
//       child: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return getItemCardSimple(product: product);
//         },
//       ),
//     );
//   }

//   @Deprecated('to be deleted in future, products list will be loaded from firebase')
//   void initProducts() {
//     products.add(Product(
//       code: "ring_heart_01",
//       name: "Ring Heart Supper",
//       price: 10500,
//       image: "prod_1.jpg",
//       status: "available",
//       desc: "ring forged in silver with elegant craftmenship",
//     ));
//     products.add(Product(
//       code: "pendent_heart_01",
//       name: "Pendent Heart Ruby",
//       price: 20500,
//       image: "prod_2.jpg",
//       status: "available",
//       desc: "pendent forged in silver with elegant craftmenship",
//     ));
//     products.add(Product(
//       code: "ring_heart_02",
//       name: "Ring Heart Male",
//       price: 10500,
//       image: "prod_3.jpg",
//       status: "out of stock",
//       desc: "ring forged in silver with elegant craftmenship for authoritative personality",
//     ));
//     products.add(Product(
//       code: "ring_dark_01",
//       name: "Ring Darker Supper",
//       price: 40500,
//       image: "prod_4.jpg",
//       status: "available",
//       desc: "ring forged in silver with elegant craftmenship for darker pesonalities",
//     ));
//     products.add(Product(
//       code: "ring_mist_01",
//       name: "Ring Magic Blood Stone",
//       price: 500500,
//       image: "prod_5.jpg",
//       status: "vender recommended",
//       desc: "ring forged in mistery metal with dark magic",
//     ));
//     products.add(Product(
//       code: "ring_pair_01",
//       name: "Ring Cube Pair",
//       price: 10500,
//       image: "prod_6.jpg",
//       status: "top selling",
//       desc: "ring forged in silver with elegant craftmenship for love birds",
//     ));
//     products.add(Product(
//       code: "NFT_01",
//       name: "Jullu Man",
//       price: 200599,
//       image: "prod_7.jpg",
//       status: "vender recommended",
//       desc: "picture with misterous power of jealousy",
//     ));
//     products.add(Product(
//       code: "NFT_02",
//       name: "Dark Army",
//       price: 299599,
//       image: "prod_8.jpg",
//       status: "top selling",
//       desc: "mesterous powers for clearing online exam of aptech garden center",
//     ));
//     products.add(Product(
//       code: "NFT_03",
//       name: "Groom of Karsaz Bride",
//       price: 200599,
//       image: "prod_9.jpg",
//       status: "available",
//       desc: "demon summoned for kidnapping your interest",
//     ));
//   }

//   void filterVenderRecommendedProducts() {
//     venderRecomended = products.where((product) => product.status == "vender recommended").toList();
//   }

//   void filterTopSellingProducts() {
//     topSelling = products.where((product) => product.status == "top selling").toList();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart' as slider;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_project_2208e/widgets/item_card.dart';
// import '../models/product.dart';
// import '../widgets/custom_drawer.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   static const String routeName = '/HomePage';

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late String displayName;
//   List<Product> products = [];
//   List<Product> venderRecomended = [];
//   List<Product> topSelling = [];

//   @override
//   void initState() {
//     super.initState();
//     final user = FirebaseAuth.instance.currentUser;
//     initProducts();
//     filterVenderRecommendedProducts();
//     filterTopSellingProducts();
//     displayName = user?.displayName ?? "Unknown User";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Home',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//       drawer: CustNavigationDrawer(displayName: displayName),
//       body: OrientationBuilder(
//         builder: (context, orientation) {
//           if (orientation == Orientation.portrait) {
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   sectionTitle(context, "Vendor's Recommended"),
//                   carouselSection(venderRecomended),
//                   sectionTitle(context, "Product List"),
//                   listSection(products),
//                   sectionTitle(context, "Top Selling"),
//                   carouselSection(topSelling),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(
//               child: Card(
//                 elevation: 10.0,
//                 margin: EdgeInsets.all(30),
//                 color: Colors.white,
//                 child: Padding(
//                   padding: EdgeInsets.all(20.0),
//                   child: ListTile(
//                     title: Text('Warning'),
//                     subtitle: Text("Please change to portrait view"),
//                   ),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget sectionTitle(BuildContext context, String title) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Text(
//         title,
//         style: Theme.of(context)
//             .textTheme
//             .headlineSmall
//             ?.copyWith(color: Colors.blueGrey),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   Widget carouselSection(List<Product> products) {
//     return slider.CarouselSlider(
//       items: products.map((prd) => getItemCardCar(product: prd)).toList(),
//       options: slider.CarouselOptions(
//         height: 170.0,
//         enlargeCenterPage: false,
//         autoPlay: true,
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enableInfiniteScroll: true,
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         viewportFraction: 0.4,
//       ),
//     );
//   }

//   Widget listSection(List<Product> products) {
//     return Container(
//       height: 350.0, // Adjust height as needed
//       child: ListView.builder(
//         // physics: const NeverScrollableScrollPhysics(), // Prevents scrolling inside the list view
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return getItemCardSimple(product: product);
//         },
//       ),
//     );
//   }

//   @Deprecated(
//       'to be deleted in future, products list will be loaded from firebase')
//   void initProducts() {
//     products.add(Product(
//       code: "ring_heart_01",
//       name: "Ring Heart Supper",
//       price: 10500,
//       image: "prod_1.jpg",
//       status: "available",
//       desc: "ring forged in silver with elegant craftmenship",
//     ));
//     products.add(Product(
//       code: "pendent_heart_01",
//       name: "Pendent Heart Ruby",
//       price: 20500,
//       image: "prod_2.jpg",
//       status: "available",
//       desc: "pendent forged in silver with elegant craftmenship",
//     ));
//     products.add(Product(
//       code: "ring_heart_02",
//       name: "Ring Heart Male",
//       price: 10500,
//       image: "prod_3.jpg",
//       status: "out of stock",
//       desc:
//           "ring forged in silver with elegant craftmenship for authoritative personality",
//     ));
//     products.add(Product(
//       code: "ring_dark_01",
//       name: "Ring Darker Supper",
//       price: 40500,
//       image: "prod_4.jpg",
//       status: "available",
//       desc:
//           "ring forged in silver with elegant craftmenship for darker pesonalities",
//     ));
//     products.add(Product(
//       code: "ring_mist_01",
//       name: "Ring Magic Blood Stone",
//       price: 500500,
//       image: "prod_5.jpg",
//       status: "vender recommended",
//       desc: "ring forged in mistery metal with dark magic",
//     ));
//     products.add(Product(
//       code: "ring_pair_01",
//       name: "Ring Cube Pair",
//       price: 10500,
//       image: "prod_6.jpg",
//       status: "top selling",
//       desc: "ring forged in silver with elegant craftmenship for love birds",
//     ));
//     products.add(Product(
//       code: "NFT_01",
//       name: "Jullu Man",
//       price: 200599,
//       image: "prod_7.jpg",
//       status: "vender recommended",
//       desc: "picture with misterous power of jealousy",
//     ));
//     products.add(Product(
//       code: "NFT_02",
//       name: "Dark Army",
//       price: 299599,
//       image: "prod_8.jpg",
//       status: "top selling",
//       desc: "mesterous powers for clearing online exam of aptech garden center",
//     ));
//     products.add(Product(
//       code: "NFT_03",
//       name: "Groom of Karsaz Bride",
//       price: 200599,
//       image: "prod_9.jpg",
//       status: "available",
//       desc: "demon summoned for kidnapping your interest",
//     ));
//   }

//   void filterVenderRecommendedProducts() {
//     venderRecomended = products
//         .where((product) => product.status == "vender recommended")
//         .toList();
//   }

//   void filterTopSellingProducts() {
//     topSelling =
//         products.where((product) => product.status == "top selling").toList();
//   }
// }






import 'package:flutter/material.dart' hide CarouselController ;
import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_2208e/widgets/item_card.dart';
import '../models/product.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String displayName;
  List<Product> products = [];
  List<Product> venderRecomended = [];
  List<Product> topSelling = [];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    initProducts();
    filterVenderRecommendedProducts();
    filterTopSellingProducts();
    displayName = user?.displayName ?? "Unknown User";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      drawer: CustNavigationDrawer(displayName: displayName),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  sectionTitle(context, "Vendor's Recommended"),
                  carouselSection(venderRecomended),
                  sectionTitle(context, "Books List"),
                  listSection(products),
                  sectionTitle(context, "Top Seller"),
                  carouselSection(topSelling),
                ],
              ),
            );
          } else {
            return const Center(
              child: Card(
                elevation: 10.0,
                margin: EdgeInsets.all(30),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ListTile(
                    title: Text('Warning'),
                    subtitle: Text("Please change to portrait view"),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget sectionTitle(BuildContext context, String title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget carouselSection(List<Product> products) {
    return slider.CarouselSlider(
      items: products.map((prd) => getItemCardCar(product: prd)).toList(),
      options: slider.CarouselOptions(
        height: 170.0,
        enlargeCenterPage: false,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.4,
      ),
    );
  }

  Widget listSection(List<Product> products) {
    return Container(
      height: 350.0, // Adjust height as needed
      child: ListView.builder(
        // physics: const NeverScrollableScrollPhysics(), // Prevents scrolling inside the list view
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return getItemCardSimple(product: product);
        },
      ),
    );
  }

  @Deprecated(
      'to be deleted in future, products list will be loaded from firebase')
    void initProducts() {
    products.add(Product(
      code: "the_spirit_demon",
      name: "The Spirit Demon",
      price: 10500,
      image: "pic1.jpg",
      status: "available",
      desc: "The Spirit Spear Saga",
    ));
    products.add(Product(
      code: "it_ends_with_us",
      name: "It Ends With Us",
      price: 20500,
      image: "pic2.jpg",
      status: "available",
      desc: "Every person with a heartbeats should read this book",
    ));
    products.add(Product(
      code: "hide_and_seek",
      name: "Hide And Seek",
      price: 10500,
      image: "pic3.jpg",
      status: "out of stock",
      desc:
          "You must know what is comming",
    ));
    products.add(Product(
      code: "midnight_caller",
      name: "Midnight Caller",
      price: 40500,
      image: "pic4.jpg",
      status: "available",
      desc:
          "Explore the depth of human desire",
    ));
    products.add(Product(
      code: "the_mind_of_a_leader",
      name: "The Mind Of A Leader",
      price: 500500,
      image: "pic5.jpg",
      status: "vender recommended",
      desc: "How to lead yourself, your people & you organization",
    ));
    products.add(Product(
      code: "the_silent_patient",
      name: "The Silent Patient",
      price: 10500,
      image: "pic6.jpg",
      status: "top selling",
      desc: "New York times best seller",
    ));
    products.add(Product(
      code: "the_dragon_heir",
      name: "The Dragon Heir",
      price: 200599,
      image: "pic7.jpg",
      status: "vender recommended",
      desc: "The first novel in the DRAGON HEIR series",
    ));
    products.add(Product(
      code: "brat",
      name: "Brat",
      price: 299599,
      image: "pic8.jpg",
      status: "top selling",
      desc: "A ghost story",
    ));
    products.add(Product(
      code: "the_tree_of_life",
      name: "The Tree Of Life",
      price: 200599,
      image: "pic9.jpg",
      status: "available",
      desc: "demon summoned for kidnapping your interest",
    ));
  }    
  
  void filterVenderRecommendedProducts() {
    venderRecomended = products
        .where((product) => product.status == "vender recommended")
        .toList();
  }

  void filterTopSellingProducts() {
    topSelling =
        products.where((product) => product.status == "top selling").toList();
  }
}
