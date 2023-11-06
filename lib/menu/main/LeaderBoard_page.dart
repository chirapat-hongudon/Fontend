import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_mobile_app/menu/login/update.dart';
import 'package:project_mobile_app/menu/main/NavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({Key? key}) : super(key: key);

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  String userEmail = '';
  String userName = '';


  Future<void> delrecord(String id) async {
    try {
      String url = "http://172.25.112.1/database/delete.php";

      var res = await http.post(Uri.parse(url), body: {"id": id});
      var response = json.decode(res.body);

      if (response != null && response["success"] == "true") {
        print("Record deleted");
        getRecord();
      } else {
        print("Some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List> getRecord() async {
    String url = "http://172.25.112.1/database/ranks.php";
    try {
      var response = await http.post(Uri.parse(url));
      return json.decode(response.body);
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Ranks",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      endDrawer: NavBar(userName: userName, userEmail: userEmail),
      body: FutureBuilder<List>(
        future: getRecord(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data;
            if (data != null && data.isNotEmpty) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        // Pass user data to the UpdatePage
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdatePage(
                              userData: UserData(
                                name: data[index]["user_name"],
                                email: data[index]["email"],
                                password: data[index]["password"],
                              ),
                            ),
                          ),
                        );
                      },
                      leading: Icon(Icons.emoji_events),
                      title: Text(data[index]["user_name"]),
                      subtitle: Text(data[index]["score"]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          delrecord(data[index]["user_id"]);
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No data available.'));
            }
          }
        },
      ),
    );
  }
}
