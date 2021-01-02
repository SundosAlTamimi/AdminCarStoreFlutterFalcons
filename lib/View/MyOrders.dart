import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Controller/FetchData.dart';
import 'package:flutter_app_test/Module/MyOrdersModule.dart';
import '../app_localizations.dart';
import 'MyOrdersStore.dart';
import 'loader/Loader.dart';
import 'loader/dot_type.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}
var run = true;

class _MyOrdersState extends State<MyOrders> {
  var orders = new List<MyOrdersModule>();
  int quantity = 0;
  IconData faverats ;
  var runbefore = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('MyOrder'),),
      ),
      body: DefaultTabController(
        length: 500,
        child: Scaffold(
          key: scaffoldKey,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.lightGreen[200]]
              ),
            ),
            child: Center(
              child: FutureBuilder<List<MyOrdersModule>>(
                future: API.getMyOrders(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<MyOrdersModule>> snapshot) {
                  if (snapshot.hasData) {
                    print("have data");
                    List<MyOrdersModule> userStore = snapshot.data;
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
      ),
    );
  }

  Widget getSnapshot(List<MyOrdersModule> myOrders) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 28.0 , vertical: 5.0 ),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: myOrders?.length ?? 0,
        itemExtent: 120.0,
        itemBuilder: (context, index) {
          return buildOrders(myOrders[index],context);
        },
      ),
    );
  }

  Widget buildOrders(MyOrdersModule order, BuildContext context) {
    TextStyle priceTextStyle = TextStyle(
        color: Colors.lightGreen, fontSize: 15, fontWeight: FontWeight.bold);
    runbefore = true;
    return Builder(
        builder: (BuildContext context) {
          return Container(
            width: 400.0,
            height: 140.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              child: Container(
                decoration:BoxDecoration(
                  //border: Border.all(color: Color(0xff940D5A)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 15.0),
                      blurRadius: 20.0,
                    ),
                  ],
                ),
                child: MaterialButton(
                  padding: const EdgeInsets.all(0),
                  elevation: 0.5,
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                  Navigator.push(
                      context,MaterialPageRoute(builder: (context) => MyOrdersStore(serialNo: order.uSERNOSERIAL)));
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left:5.0),
                                  child: Text(order.uSERNAME,
                                    style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(AppLocalizations.of(context).translate('NumOfOrders')+" : " + order.oRDERS,
                                        style: priceTextStyle),
                                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 12.0,)
                                  ],),
                                Text(AppLocalizations.of(context).translate('UserNo')+" : ${order.uSERNO}",
                                  style: TextStyle(fontSize: 12.0),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

}
