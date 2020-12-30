import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  String logText = '';
  IconData logIcon ;
  bool _visableLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildColumn(context);
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/drawer-header.jpg'),
                )),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png'),
            ),
            // accountEmail: Text(""),
            accountName: Text("Omar Amarnah"), accountEmail: null,
          ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.home, color: Theme
                    .of(context)
                    .accentColor),
                title: Text('Home'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_basket,
                    color: Theme
                        .of(context)
                        .accentColor),
                title: Text('My Orders'),
                onTap: () {
                  Navigator.pushNamed(context , '/myOrder');
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.g_translate,
                    color: Theme
                        .of(context)
                        .accentColor),
                title: Text('Languages'),
                onTap: () {
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
