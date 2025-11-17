import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_2208e/models/cart.dart';
import 'package:flutter_project_2208e/routes/route_pages.dart';
import 'package:flutter_project_2208e/services/cart_dao.dart';
import 'package:flutter_project_2208e/widgets/item_card.dart';
import '../models/product.dart';
import '../widgets/custom_drawer.dart';

class ProductViewPage extends StatefulWidget {
  const ProductViewPage({super.key});
  static const String routeName = '/ProductViewPage';

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  final cartDao = CartDao();
  late String displayName;
  String? uuid;
  int cartItemCount = 0;
  List<Product> products = [];
  Map<Product, int> productQuantities = {};

  Future<void> getTotalCartItemsCountInitial() async {
    try {
      final count = await cartDao.getTotalCartItemsCount(uuid.toString());
      setState(() {
        cartItemCount = count;
      });
    } catch (error) {
      print("Error unable get cart item count");
    }
  }

  Future<void> handleCartTap(Product prd) async {
    if (prd.status == "out of stock") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("product is out of stock")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("you have selected ${prd.name}")));

      final cart = Cart(
        code: prd.code,
        name: prd.name,
        price: prd.price,
        quantity: productQuantities[prd] ?? 1,
      );

      await cartDao.saveToCart(cart, uuid.toString());
      await getTotalCartItemsCountInitial();
    }
  }

  void incrementQuantity(Product product) {
    setState(() {
      productQuantities[product] = (productQuantities[product] ?? 1) + 1;
    });
  }

  void decrementQuantity(Product product) {
    setState(() {
      if ((productQuantities[product] ?? 1) > 1) {
        productQuantities[product] = (productQuantities[product] ?? 1) - 1;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        displayName = user.displayName.toString();
        uuid = user.uid.toString();
      });
      initProducts();
      final connectedCartRef = cartDao.getMessageQuery(uuid.toString());
      connectedCartRef.keepSynced(true);
      getTotalCartItemsCountInitial();
    } else {
      print("no user sign in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Books View',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              child: IconButton(
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, PageRoutes.cart);
                  },
                  color: cartItemCount > 0 ? Colors.green : Colors.white),
            ),
            const SizedBox(
              width: 5.0,
            ),
            if (cartItemCount > 0)
              Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 12,
                    child: Text(
                      "$cartItemCount",
                    ),
                  )),
            const SizedBox(
              width: 5.0,
            ),
          ],
        ),
        drawer: CustNavigationDrawer(
          displayName: displayName,
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                // child: getItemCard(product: products[0], onCartTap: (){}, onFavoriteTap: (){})
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final prd = products[index];
                        final quantity = productQuantities[prd] ?? 1;
                        return getItemCard(
                          product: prd,
                          quantity: quantity,
                          onCartTap: () => handleCartTap(prd),
                          onFavoriteTap: () {},
                          onDecreaseTap: () => decrementQuantity(prd),
                          onIncreasseTap: () => incrementQuantity(prd),
                        );
                      }),
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsets.all(20.0),
                child: const Center(
                    child: Card(
                        elevation: 10.0,
                        margin: EdgeInsets.all(30),
                        color: Colors.white,
                        child: Card(
                          elevation: 1.0,
                          color: Colors.white,
                          child: ListTile(
                            title: Text('Warning'),
                            subtitle: Text("Please change to prortrat view"),
                          ),
                        ))),
              );
            }
          },
        ));
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


}
