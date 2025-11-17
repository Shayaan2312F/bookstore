// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_project_2208e/models/cart.dart';
// import 'package:flutter_project_2208e/models/order.dart';
// import 'package:flutter_project_2208e/models/user_profile.dart';
// import 'package:flutter_project_2208e/pages/checkout_page.dart';
// import 'package:flutter_project_2208e/services/cart_dao.dart';
// import 'package:flutter_project_2208e/services/user_profile_dao.dart';
// import 'package:flutter_project_2208e/widgets/beveled_button.dart';
// import '../widgets/custom_drawer.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({super.key});
//   static const String routeName = '/CartPage';

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   late String displayName;
//   late String uuid;
//   UsersProfile? userProfile;
//   double totalOrderPrice = 0.0;
//   final Future<FirebaseApp> _future = Firebase.initializeApp();
//   CartDao cartDao = CartDao();
//   final userProfileDao = UserProfileDao();
//   List<Cart> cartItems = [];

//   void placeOrder() {
    
//     if (cartItems.isEmpty) {
//       // Show an alert dialog if the cart is empty
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Cart is empty"),
//             content: const Text(
//                 "Please add items to your cart before placing an order."),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text("OK"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//       return; // Exit the method if the cart is empty
//     }

//     Order order = Order(
//       uuid: uuid.toString(),
//       contacName: userProfile!.displayName,
//       address: userProfile!.address,
//       mobile: userProfile!.mobile,
//       city: userProfile!.city,
//       email: userProfile!.email,
//       orderDate: DateTime.now().toLocal().toString(),
//       orderDetail: cartItems,
//       amount: totalOrderPrice,
//       status: "pending",
//       comments: "order is pending, need approval",
//     );

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CheckoutPage(
//           order: order,
//         ),
//       ),
//     );
//   }
// void loadCartItems() {
//   final cartRef = cartDao.getMessageQuery(uuid);

//   cartRef.onValue.listen((DatabaseEvent event) {
//     final data = event.snapshot.value as Map<dynamic, dynamic>?;

//     if (data != null) {
//       setState(() {
//         cartItems = data.entries.map((e) {
//           return Cart.fromJson(Map<String, dynamic>.from(e.value));
//         }).toList();

//         totalOrderPrice = cartItems.fold(
//             0.0, (sum, item) => sum + (item.price * item.quantity));
//         print("Loaded cart items: $cartItems");
//         print("Total order price: $totalOrderPrice");
//       });
//     } else {
//       print("No items in the cart");
//     }
//   }, onError: (error) {
//     print("Error loading cart items: $error");
//   });
// }





//   void removeCartItem(String cartKey, Cart cart) {
//     cartDao.deleteCart(cartKey, uuid).then((_) {
//       Navigator.pushReplacement(context,
//           MaterialPageRoute(builder: (BuildContext context) => super.widget));
//       ;
//     }).catchError((error) {
//       print("Error removing item: $error");
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     // TODO: implement initState
//     final user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       displayName = user.displayName ?? "Unknown User";
//       uuid = user.uid;
//     } else {
//       displayName = "Unknown User";
//       uuid = "";
//     }

//     final connectedCartRef = cartDao.getMessageQuery(uuid);
//     connectedCartRef.keepSynced(true);
//     final connectedUserProfRef = userProfileDao.getMessageQuery(uuid);
//     connectedUserProfRef.keepSynced(true);
//   // Load cart items
//   loadCartItems();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: CustNavigationDrawer(
//         displayName: displayName,
//       ),
//       appBar: AppBar(
//         title: Text(
//           'Cart - $displayName',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height * 0.3,
//             padding: const EdgeInsets.all(5.0),
//             child: FutureBuilder(
//               future: _future,
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Text(snapshot.error.toString());
//                 } else {
//                   return FirebaseAnimatedList(
//                     query: userProfileDao.getMessageQuery(uuid),
//                     itemBuilder: (context, snapshot, animation, index) {
//                       final json = snapshot.value as Map<dynamic, dynamic>;
//                       userProfile = UsersProfile.fromJson(json);
//                       return Card(
//                         color: Colors.white,
//                         elevation: 1,
//                         child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: userProfile == null
//                               ? const Center(child: CircularProgressIndicator())
//                               : Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     const Center(
//                                       child: Text(
//                                         'User Details',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10.0),
//                                     buildSummaryRow(
//                                         'Name:', userProfile!.displayName),
//                                     buildSummaryRow(
//                                         'Mobile No:', userProfile!.mobile),
//                                     buildSummaryRow(
//                                         'Email Address:', userProfile!.email),
//                                     buildSummaryRow(
//                                         'Address:', userProfile!.address),
//                                     buildSummaryRow('City:', userProfile!.city),
//                                     const SizedBox(height: 10.0),
//                                   ],
//                                 ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//           Flexible(
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: FutureBuilder(
//                 future: _future,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Text(snapshot.error.toString());
//                   } else {
//                     return FirebaseAnimatedList(
//                         query: cartDao.getMessageQuery(uuid),
//                         itemBuilder: (context, snapshot, animated, index) {
//                           var json = snapshot.value as Map<dynamic, dynamic>;
//                           String cartKey = snapshot.key.toString();
//                           Cart cart = Cart.fromJson(json);

//                           //var f = NumberFormat("###.0#", "en_US");
//                           return Card(
//                             elevation: 10.0,
//                             color: Colors.white,
//                             margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       const Text(
//                                         "Product Code",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(cart.code)
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       const Text(
//                                         "Product Name",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(cart.name)
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       const Text(
//                                         "Product Price",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text("NFT ${cart.price}")
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       const Text(
//                                         "Product Quantity",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         "${cart.quantity}",
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       const Text(
//                                         "Total",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                       Text(
//                                         "NFT ${cart.price * cart.quantity}",
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10.0),
//                                   SizedBox(
//                                     width: MediaQuery.of(context).size.width,
//                                     child: beveledButton(
//                                         title: 'Delete',
//                                         onTap: () {
//                                           removeCartItem(cartKey, cart);
//                                         }),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         });
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: Colors.red.withOpacity(0.6),
//         onPressed: () {
//           placeOrder();
//         },
//         label: Text(
//           'Check Out',
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//       ),
//     );
//   }

//   Widget buildSummaryRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Flexible(
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Flexible(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2208e/models/cart.dart';
import 'package:flutter_project_2208e/models/order.dart';
import 'package:flutter_project_2208e/models/user_profile.dart';
import 'package:flutter_project_2208e/pages/checkout_page.dart';
import 'package:flutter_project_2208e/services/cart_dao.dart';
import 'package:flutter_project_2208e/services/user_profile_dao.dart';
import 'package:flutter_project_2208e/widgets/beveled_button.dart';
import '../widgets/custom_drawer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static const String routeName = '/CartPage';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late String displayName;
  late String uuid;
  UsersProfile? userProfile;
  double totalOrderPrice = 0.0;
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final CartDao cartDao = CartDao();
  final UserProfileDao userProfileDao = UserProfileDao();
  List<Cart> cartItems = [];

  void placeOrder() {
     loadCartItems();
    if (cartItems.isEmpty) {
      _showAlertDialog("Cart is empty", "Please add items to your cart before placing an order.");
      return;
    }

    final order = Order(
      uuid: uuid,
      contacName: userProfile!.displayName,
      address: userProfile!.address,
      mobile: userProfile!.mobile,
      city: userProfile!.city,
      email: userProfile!.email,
      orderDate: DateTime.now().toLocal().toString(),
      orderDetail: cartItems,
      amount: totalOrderPrice,
      status: "pending",
      comments: "Order is pending, needs approval",
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CheckoutPage(order: order)),
    );
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void loadCartItems() {
    final cartRef = cartDao.getMessageQuery(uuid);
    cartRef.onValue.listen(
      (event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          setState(() {
            cartItems = data.entries.map((e) => Cart.fromJson(Map<String, dynamic>.from(e.value))).toList();
            totalOrderPrice = cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
          });
        } else {
          print("No items in the cart");
        }
      },
      onError: (error) => print("Error loading cart items: $error"),
    );
  }

  void removeCartItem(String cartKey) {
    cartDao.deleteCart(cartKey, uuid).then(
      (_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => super.widget));
      },
    ).catchError((error) => print("Error removing item: $error"));
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      displayName = user.displayName ?? "Unknown User";
      uuid = user.uid;
    } else {
      displayName = "Unknown User";
      uuid = "";
    }

    cartDao.getMessageQuery(uuid).keepSynced(true);
    userProfileDao.getMessageQuery(uuid).keepSynced(true);

   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustNavigationDrawer(displayName: displayName),
      appBar: AppBar(
        title: Text('Cart - $displayName', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildUserProfile(),
          _buildCartList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red.withOpacity(0.6),
        onPressed: placeOrder,
        label: Text('Check Out', style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(5.0),
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return FirebaseAnimatedList(
              query: userProfileDao.getMessageQuery(uuid),
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value as Map<dynamic, dynamic>;
                userProfile = UsersProfile.fromJson(json);
                return _buildUserProfileCard();
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildUserProfileCard() {
    return Card(
      color: Colors.white,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: userProfile == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'User Details',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSummaryRow('Name:', userProfile!.displayName),
                  _buildSummaryRow('Mobile No:', userProfile!.mobile),
                  _buildSummaryRow('Email Address:', userProfile!.email),
                  _buildSummaryRow('Address:', userProfile!.address),
                  _buildSummaryRow('City:', userProfile!.city),
                  const SizedBox(height: 10),
                ],
              ),
      ),
    );
  }
Widget _buildSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        Flexible(
          child: Text(value, style: const TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis),
        ),
      ],
    ),
  );
}

  Widget _buildCartList() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return FirebaseAnimatedList(
                query: cartDao.getMessageQuery(uuid),
                itemBuilder: (context, snapshot, animated, index) {
                  final json = snapshot.value as Map<dynamic, dynamic>;
                  final cartKey = snapshot.key!;
                  final cart = Cart.fromJson(json);
                  return _buildCartItemCard(cart, cartKey);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildCartItemCard(Cart cart, String cartKey) {
    return Card(
      elevation: 10.0,
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCartRow("Product Code", cart.code),
            _buildCartRow("Product Name", cart.name),
            _buildCartRow("Product Price", "NFT ${cart.price}"),
            _buildCartRow("Product Quantity", "${cart.quantity}"),
            _buildCartTotalRow(cart),
            _buildDeleteButton(cartKey),
          ],
        ),
      ),
    );
  }

  Widget _buildCartRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 5),
        Text(value),
      ],
    );
  }

  Widget _buildCartTotalRow(Cart cart) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text("NFT ${cart.price * cart.quantity}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildDeleteButton(String cartKey) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: beveledButton(
        title: 'Delete',
        onTap: () => removeCartItem(cartKey),
      ),
    );
  }

  Widget buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Flexible(
            child: Text(value, style: const TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

