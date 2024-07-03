import 'dart:convert';
import '../screens/details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/user_service.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> userList;

  Future<void> getUsers() async {
    userList = UserService().getUserList();
    // Future.delayed(const Duration(seconds: 30)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 2,
        centerTitle: false,
        title: Container(
          child: Text(
            "USERS LIST",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<List<User>>(
          future: userList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(
                color: Colors.grey,

              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching people'));
            } else {
              final _userlist = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: _userlist.length,
                itemBuilder: (context, index) {
                  final _user = _userlist[index];

                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 15),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // People List View
                              Expanded(
                                child: Row(children: [
                                  Container(
                                      width: 60,
                                      height: 60,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.red,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            margin: const EdgeInsets.all(2.0),
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: _user.picture,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                                progressIndicatorBuilder: (
                                                    context,
                                                    url, downloadProgress) =>
                                                    Center(
                                                      child: CircularProgressIndicator(
                                                          color: Colors.grey,
                                                          value:
                                                          downloadProgress
                                                              .progress),
                                                    ),
                                                errorWidget: (context, url,
                                                    error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(_user.firstName + "\t" +
                                              _user.lastName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(_user.lastName,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.grey[700])),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(_user.email,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 10,
                                                  color: Colors.grey[400])),
                                        ]),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailsPage(user: _user),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
