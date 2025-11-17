import 'package:flutter/material.dart';
import 'package:flutter_project_2208e/models/product.dart';
import 'package:flutter_project_2208e/widgets/beveled_button.dart';

Widget getItemCard({
  required Product product,
  required int quantity,
  required GestureTapCallback onFavoriteTap,
  required GestureTapCallback onCartTap,
  required GestureTapCallback onIncreasseTap,
  required GestureTapCallback onDecreaseTap,
}) {
  return Card(
    elevation: 1.0,
    color: Colors.white,
    margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Product code: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(product.code)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Product Name: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(product.name)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Image(
            image: AssetImage("assets/dump/${product.image}"),
            width: 300,
            height: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Product Description: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                product.desc,
                textAlign: TextAlign.center,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Product Price: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              Text("NFT ${product.price}")
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onDecreaseTap,
                icon: const Icon(Icons.remove),
              ),
              Text(
                "$quantity",
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: onIncreasseTap,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              beveledButton(title: "Add to favorite", onTap: onFavoriteTap),
              const SizedBox(
                width: 5,
              ),
              beveledButton(title: "Add to cart", onTap: onCartTap),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget getItemCardCar({required Product product}) {
  return Card(
    elevation: 1.0,
    color: Colors.white,
    margin: const EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/dump/${product.image}",
            width: 150,
            height: 90,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Widget getItemCardSimple({required Product product}) {
  return Card(
    elevation: 1.0,
    color: Colors.white,
    margin: const EdgeInsets.all(8.0),
    child: ListTile(
      leading: Image.asset("assets/dump/${product.image}",
          width: 50, height: 50, fit: BoxFit.fitHeight),
      title: Text(product.name),
      subtitle: Text(product.desc),
    ),
  );
}
