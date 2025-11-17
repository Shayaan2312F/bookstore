class UsersProfile {
  late String displayName;
  late String address;
  late String mobile;
  late String city;
  late String email;

  UsersProfile({
    required this.displayName,
    required this.address,
    required this.mobile,
    required this.city,
    required this.email
  });

  UsersProfile.fromJson(Map<dynamic,dynamic> json)
   : displayName=json['displayName'] as String,
   address=json['address'] as String,
   mobile=json['mobile'] as String,
   city=json['city'] as String,
   email=json['email'] as String;

   Map<dynamic,dynamic> toJson()=><dynamic,dynamic>{
    'displayName':displayName,
    'address':address,
    'mobile':mobile,
    'city':city,
    'email':email
   };


   Map<String,dynamic> toMap ()=><String,dynamic>{
    'displayName':displayName,
    'address':address,
    'mobile':mobile,
    'city':city,
    'email':email
   };
}