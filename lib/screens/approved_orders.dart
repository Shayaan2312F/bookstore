import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2208e/widgets/order_page_drawer.dart';
import 'package:flutter_project_2208e/models/order.dart';
import 'package:flutter_project_2208e/widgets/custom_drawer.dart';
import 'package:flutter_project_2208e/routes/route_pages.dart';

  class ApprovedOrderPage extends StatelessWidget {
    final Order order;
  static const String routeName = '/ApprovedOrderPage';  // Add this line

  const ApprovedOrderPage({super.key, required this.order});
  
  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approved Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Order Date: ${order.orderDate}'),
            Text('Amount: NFT ${order.amount}'),
            Text('Status: ${order.status}'),
            // Display more details as needed
          ],
        ),
      ),
    );
  }
}



