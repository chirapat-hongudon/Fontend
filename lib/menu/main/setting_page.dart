import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_mobile_app/menu/components/background.dart';
import 'package:project_mobile_app/menu/main/NavBar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String userEmail = '';
  String userName = '';

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedName = prefs.getString('name');

    if (storedEmail != null) {
      setState(() {
        userEmail = storedEmail;
        userName = storedName ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      endDrawer: NavBar(userName: userName, userEmail: userEmail),
      body: Background(
        child: Center(
          child: Container(
            width: 300,
            height: 500,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
                    ),
                  ),
                  SizedBox(height: 100),
                  Row(
                    children: <Widget>[
                      Icon(Icons.email),
                      SizedBox(width: 8),
                      Text(
                        'Email: $userEmail',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Icon(Icons.person),
                      SizedBox(width: 8),
                      Text(
                        'Name: $userName',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 140),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
