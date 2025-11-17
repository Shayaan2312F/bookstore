import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_2208e/pages/sign_out.dart';
import 'package:flutter_project_2208e/services/auth_service.dart';
import 'package:flutter_project_2208e/services/user_profile_dao.dart';
import '../models/user_profile.dart';
import '../services/validation.dart';
import 'package:flutter/material.dart';
import '../widgets/beveled_button.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.email});
  final String email;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  UserProfileDao userProfileDao = UserProfileDao();

  final _focusName = FocusNode();
  final _focusMobile = FocusNode();
  final _focusAddress = FocusNode();

  List<DropdownMenuItem<int>> cityList = [];

  void loadCityList() {
    cityList = [];
    cityList.add(const DropdownMenuItem(
      value: 0,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 8,
          ),
          Icon(Icons.location_city),
          SizedBox(
            width: 8,
          ),
          Text('Karachi')
        ],
      ),
    ));
    cityList.add(const DropdownMenuItem(
      value: 1,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 8,
          ),
          Icon(Icons.location_city),
          SizedBox(
            width: 8,
          ),
          Text('Lahore')
        ],
      ),
    ));
    cityList.add(const DropdownMenuItem(
      value: 2,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 8,
          ),
          Icon(Icons.location_city),
          SizedBox(
            width: 8,
          ),
          Text('Islamabad')
        ],
      ),
    ));
  }

  String? displayName;
  String? userAddress;
  String? userMobile;
  int selectedCity = 0;
  String? uuid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create User Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 4,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLength: 20,
                                focusNode: _focusName,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    labelText: "Display Name",
                                    hintText: "Enter User Name"),
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    validateName(value, _focusName),
                                onSaved: (value) {
                                  setState(() {
                                    displayName = value;
                                  });
                                },
                              ),
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLength: 11,
                                focusNode: _focusMobile,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.mobile_screen_share),
                                    labelText: "Mobile No",
                                    hintText: "Enter User Mobile No"),
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    validateMobile(value, _focusMobile),
                                onSaved: (value) {
                                  setState(() {
                                    userMobile = value;
                                  });
                                },
                              ),
                              DropdownButton(
                                style: Theme.of(context).textTheme.bodyMedium,
                                hint: const Text('Select Gender'),
                                items: cityList,
                                value: selectedCity,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCity = int.parse(value.toString());
                                  });
                                },
                                isExpanded: true,
                              ),
                              TextFormField(
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLength: 200,
                                maxLines: 4,
                                focusNode: _focusAddress,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.location_city),
                                    labelText: "Address",
                                    hintText: "Enter User Dilevery Address"),
                                keyboardType: TextInputType.multiline,
                                validator: (value) =>
                                    validateText(value, _focusAddress),
                                onSaved: (value) {
                                  setState(() {
                                    userAddress = value;
                                  });
                                },
                              ),
                              beveledButton(
                                  title: "Create User",
                                  onTap: () {
                                    onPressSubmit();
                                  }),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ))),
      ),
    );
  }

  void onPressSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String city = "";
      switch (selectedCity) {
        case 0:
          city = "Karachi";
          break;
        case 1:
          city = "Lahore";
          break;
        case 2:
          city = "Islamabad";
          break;
        default:
      }

      await Future.delayed(const Duration(seconds: 1), () {});

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        user.updateDisplayName(displayName);
      }

      String uuid = user!.uid.toString();

      UsersProfile userProfile = UsersProfile(
          displayName: displayName.toString(),
          email: widget.email,
          mobile: userMobile.toString(),
          city: city,
          address: userAddress.toString());

      await userProfileDao.saveUser(userProfile, uuid);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User Created")));

      await Future.delayed(const Duration(seconds: 1), () {});

      await AuthenticateHelper().signOut();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignOutPage()));
    }
  }
}
