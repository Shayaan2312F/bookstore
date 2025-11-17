import 'package:flutter/material.dart';


Widget beveledButton({
  required String title,
  required GestureTapCallback onTap
}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red.withOpacity(0.4),
      foregroundColor: Colors.white,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      )
    ),
    onPressed: onTap, 
    child: Text(title)
    );
}