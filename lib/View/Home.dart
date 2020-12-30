import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Controller/FetchData.dart';
import 'package:flutter_app_test/Module/UserStores.dart';
import 'package:flutter_app_test/View/loader/Loader.dart';
import 'package:mdi/mdi.dart';
import '../app_localizations.dart';
import 'UserDefine.dart';
import 'drawer.dart';
import 'loader/dot_type.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<UserStores> userStoreList = new List<UserStores>() ;
  Color colorBorder;
  Icon iconrow;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:ClipPath(
        // clipper: OvalRightBorderClipper(),
        child: Container(
          width: 250.0,
          child: Drawer(
            child: AppDrawer(),
          ),
        ),
      ),
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('costomer'),),
        ),
        body: DefaultTabController(
          length: 500,
          child: Scaffold(
            key: scaffoldKey,
            body: Center(
              child: FutureBuilder<List<UserStores>>(
                future: API.getUsersStores(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserStores>> snapshot) {
                  if (snapshot.hasData) {
                    print("have data");
                    List<UserStores> userStore = snapshot.data;
                    return getSnapshot(userStore);
                  } else if (snapshot.hasError) {
                    print(" error = ${snapshot.error} ");
                    return Text("No Data");
                  }
                  return Container(
                    height: 50.0,
                    width: double.infinity,
                    child: Center(
                      child: ColorLoader(
                        dotOneColor: Colors.lightGreen,
                        dotTwoColor: Colors.lightGreen,
                        dotThreeColor: Colors.lightGreen,
                        dotIcon: Icon(Icons.adjust),
                        dotType: DotType.circle,
                        duration: Duration(seconds: 2),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_createRoute()).then((value) {
            setState(() {
              i = 1;
            });
          });
        },
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.add),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => UserDefine(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget getSnapshot(List<UserStores> userStore) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 28.0 , vertical: 5.0 ),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: userStore?.length ?? 0,
        itemExtent: 100.0,
        itemBuilder: (context, index) {
          print("hi hi");
          return makeListTile(userStore[index],context , index);
        },
      ),
    );
  }

  Widget createViewItem(UserStores userStore, BuildContext context , int index) {
    print("userStores = $userStore");
    return Builder(
        builder: (BuildContext context) {
          return Container(
            width: 300.0,
            height: 100.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              child: MaterialButton(
                padding: const EdgeInsets.all(0),
                elevation: 0.5,
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  print("userStores 2 = $userStore");
                  Navigator.push(context,MaterialPageRoute(builder: (context) => UserDefine(userStores: userStore,)),).then((value) {
                    setState(() {
                      i = 1;
                    });
                  });
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(userStore.uSERNAME,
                                        style: TextStyle(fontSize: 20.0 , color: Colors.lightGreen),),
                                      Text(
                                   "User Num: ${userStore.uSERNO}",
                                        style: TextStyle(fontSize: 12.0 , color: Colors.red),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Num of Activity: ${userStore.nOOFACTIVE}",
                                      style:  TextStyle(fontSize: 15.0),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );

  }
  Widget makeListTile(UserStores userStore, BuildContext context , int index) {
    if(index %2 == 0)
      colorBorder =  Colors.lightGreen;
    else
      colorBorder =  Colors.deepPurple[200];
    return Container(
      width:MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 4.0),
        child: MaterialButton(
          padding: const EdgeInsets.all(0),
          elevation: 0.5,
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () {
            print("userStores 2 = $userStore");
            Navigator.push(context,MaterialPageRoute(builder: (context) => UserDefine(userStores: userStore,)),).then((value) {
              setState(() {
                i = 1;
              });
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: <Widget>[
                Row(
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                        characterStyle(context, userStore),
                        ]
                    ),
                    Column(
                        mainAxisAlignment:MainAxisAlignment.spaceAround,
                        crossAxisAlignment:CrossAxisAlignment.start ,
                        children: <Widget>[
                          Text(
                                userStore.uSERNAME,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold ,fontSize: 20.0 ,fontFamily: 'JetBrains' ),
                              ),
                              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                          Row(
                            children: <Widget>[
                              Icon(Icons.linear_scale, color: Colors.deepPurple[300]),
                              Text("${AppLocalizations.of(context).translate('noActivity')}: ${userStore.nOOFACTIVE}", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.linear_scale, color: Colors.deepPurple[300]),
                              Text("${AppLocalizations.of(context).translate('userNo')}: ${userStore.uSERNO}", style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        ]
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment:MainAxisAlignment.center ,
                    children: <Widget>[
                      IconButton(
                        icon: iconrow,
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => UserDefine(userStores: userStore,)),).then((value) {
                            setState(() {
                              i = 1;
                            });
                          });
                        },
                      ),
                    ]
                ),
              ]
          ),
        ),
      ),
    );
  }

  Container characterStyle(BuildContext context, UserStores userStore) {
    if(AppLocalizations.of(context).translate('costomer') == "Costomers"){
      iconrow =  Icon(Icons.keyboard_arrow_right ,color: Colors.black, size: 30.0);
      return Container(
        width: MediaQuery.of(context).size.width / 6,
        height: 92,
        padding: EdgeInsets.all( 10.0),
        // margin: EdgeInsets.all( -10.0) ,
        decoration: BoxDecoration(
            border: Border.all(width:3 , color:colorBorder),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(200),
              bottomRight: Radius.circular(200),
            ),
            color: colorBorder),
        child:Align(
          alignment: Alignment.center,
          child: Text(userStore.uSERNAME[0].toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ,fontSize: 25.0  ),),
        ),
      );
    }
    else{
      iconrow =  Icon(Icons.keyboard_arrow_left ,color: Colors.black, size: 30.0);
      return Container(
        width: MediaQuery.of(context).size.width / 6,
        height: 92,
        padding: EdgeInsets.all( 10.0),
        // margin: EdgeInsets.all( -10.0) ,
        decoration: BoxDecoration(
            border: Border.all(width:3 , color:colorBorder),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(200),
              bottomLeft: Radius.circular(200),
            ),
            color: colorBorder),
        child:Align(
          alignment: Alignment.center,
          child: Text(userStore.uSERNAME[0].toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ,fontSize: 25.0  ),),
        ),
      );
    }

  }
}