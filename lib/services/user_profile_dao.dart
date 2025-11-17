

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

class UserProfileDao{
  final _databaseRef = FirebaseDatabase.instance.ref('users');

  Future<void> saveUser(UsersProfile users, String?  uuid)async{
    try {
      print("the current uuid is $uuid");
      await _databaseRef.child(uuid.toString()).push().set(users.toJson());
    } catch (error) {
      print ("error in saving user: $error");
    }
  }
Future<DataSnapshot> getUserProfile(String uid) async {
    final DatabaseEvent event = await _databaseRef.child(uid).once();
    return event.snapshot;
  }



// method modified with unique userid in order to display only user record
  Query getMessageQuery(String uid){
     if(!kIsWeb){
        FirebaseDatabase.instance.setPersistenceEnabled(true);
     }
     return _databaseRef.child(uid);
  }

  void updateUser({
    required String key,
    required String uuid,
    required UsersProfile users
  })async{
      try {
        await _databaseRef.child(uuid).child(key).update(users.toMap());
      } catch (error) {
        print("Error unable to update record");
      }
  }

}