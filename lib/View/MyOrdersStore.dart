import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Controller/FetchData.dart';
import 'package:flutter_app_test/Module/MyOrdersModule.dart';
import 'package:flutter_app_test/Module/MyOrdersStoreModule.dart';
import 'package:flutter_app_test/View/MyOrdersStoreDetails.dart';
import '../app_localizations.dart';
import 'loader/Loader.dart';
import 'loader/dot_type.dart';

// ignore: must_be_immutable
class MyOrdersStore extends StatefulWidget {
  String serialNo;
  MyOrdersStore({this.serialNo});
  MyOrdersStore.c();
  @override
  _MyOrdersStoreState createState() => _MyOrdersStoreState(serialNo);
}
var run = true;

class _MyOrdersStoreState extends State<MyOrdersStore> {
  String serialNo;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var listOrdersStoreItems = new Map<String, MyOrdersStoreModule>();

  _MyOrdersStoreState(this.serialNo);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('StoreOrder'),),
      ),
      body: DefaultTabController(
        length: 500,
        child: Scaffold(
          key: scaffoldKey,
          body: Center(
            child: FutureBuilder<List<MyOrdersStoreModule>>(
              future: API.getMyOrderStore(serialNo),
              builder: (BuildContext context,
                  AsyncSnapshot<List<MyOrdersStoreModule>> snapshot) {
                if (snapshot.hasData) {
                  List<MyOrdersStoreModule> userStore = snapshot.data;
                  print("have data");
                  userStore.forEach((customer) => listOrdersStoreItems[customer.vOHNO] = customer);
                  print(listOrdersStoreItems);
                  userStore.clear();
                  listOrdersStoreItems.forEach((k, v) => userStore.add(v));
                  print(userStore);
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
    );
  }

  Widget getSnapshot(List<MyOrdersStoreModule> myOrders) {
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

  Widget buildOrders(MyOrdersStoreModule order, BuildContext context) {
    TextStyle priceTextStyle = TextStyle(
        color: Colors.lightGreen, fontSize: 15, fontWeight: FontWeight.bold);
    return Builder(
        builder: (BuildContext context) {
          return Container(
            width: 400.0,
            height: 150.0,
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
                        context,MaterialPageRoute(builder: (context) => MyOrdersStoreDetails(serialNo: order.uSERNOSERIAL , vouchNo: order.vOHNO,)));
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
                                Row(
                                  children: <Widget>[
                                    // Dot(color: Color(order.color) ,icon:Icon(Icons.adjust),radius: 14,type: DotType.circle,),

                                    Text(AppLocalizations.of(context).translate('Orderby')+" : ",
                                      style: TextStyle(fontSize: 17.0 , fontWeight: FontWeight.bold),),
                                    Text(order.vOHDATE,
                                      style: TextStyle(fontSize: 12.0),),
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(AppLocalizations.of(context).translate('TOTAL')+" : " + order.vOHTOTAL,
                                        style: priceTextStyle),
                                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 12.0,)
                                  ],),
                                Text(AppLocalizations.of(context).translate('OrderState')+" : ${order.oRDERSTATE}",
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
class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key key,
    @required this.child,
    this.height,
    this.width,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.borderRadius,
    this.alignment,
    this.elevation,
  }) : super(key: key);
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final AlignmentGeometry alignment;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(0),
      color: color,
      elevation: elevation ?? 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(20.0),
      ),
      child: Container(
        alignment: alignment,
        height: height,
        width: width,
        padding: padding,
        child: child,
      ),
    );
  }
}
