import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Controller/FetchData.dart';
import 'package:flutter_app_test/Module/MyOrdersModule.dart';
import 'package:flutter_app_test/Module/MyOrdersStoreDetailsModule.dart';
import 'package:flutter_app_test/Module/MyOrdersStoreModule.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../app_localizations.dart';
import 'loader/Loader.dart';
import 'loader/dot_type.dart';

// ignore: must_be_immutable
class MyOrdersStoreDetails extends StatefulWidget {
  String serialNo;
  String vouchNo;
  MyOrdersStoreDetails({this.serialNo , this.vouchNo});
  MyOrdersStoreDetails.c();
  @override
  _MyOrdersStoreDetailsState createState() => _MyOrdersStoreDetailsState(serialNo , vouchNo);
}
var run = true;

class _MyOrdersStoreDetailsState extends State<MyOrdersStoreDetails> {
  var orders = new List<MyOrdersModule>();
  int quantity = 0;
  IconData faverats ;
  var runbefore = true;
  String serialNo;
  String vouchNo;
  List<Color> colorStates = new List<Color>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<MyOrdersStoreDetailsModule> userStore = new List<MyOrdersStoreDetailsModule>() ;
//UPDATE_ORDER_STATE = {"ORDER_STATE" :1 ,"USER_NO_SERIAL": 49,"VOH_NO" : 19 , "VOH_SERIAL": 103 }

  _MyOrdersStoreDetailsState(this.serialNo , this.vouchNo);

  static void notificationSuccessfully(context ,String message ,String messageDetails){
    Alert(
      context: context,
      image: Image.asset("assets/images/success.png" , width: 50 , height: 50,),
      title: "${AppLocalizations.of(context).translate(message)}",
      desc: "${AppLocalizations.of(context).translate(messageDetails)}",
      buttons: [ DialogButton(
        color: Colors.lightGreen,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
      ),
      ],
    ).show();
  }

  void updateOrderStatus(String jsonUserStore){
    print("jsonUserStore $jsonUserStore");
    API.updateOrderStatus(jsonUserStore).then((response) {
      if(response.statusCode == 200) {
        notificationSuccessfully(context ,  'SuccessfullyUpdate' , 'SuccessfullyUpdateDetails');
        print(response.body.toString());
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('ItemOfOrder'),),
      ),
      body: DefaultTabController(
        length: 500,
        child: Scaffold(
          key: scaffoldKey,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: FutureBuilder<List<MyOrdersStoreDetailsModule>>(
                  future: API.getMyOrderStoreDetails(serialNo , vouchNo),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MyOrdersStoreDetailsModule>> snapshot) {
                    if (snapshot.hasData) {
                      print("have data");
                      userStore = snapshot.data;
                      for(int i=0 ; i< userStore.length ; i++)
                        colorStates.add(Colors.white);
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
              _checkoutSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget getSnapshot(List<MyOrdersStoreDetailsModule> myOrders) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 28.0 , vertical: 5.0 ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: myOrders?.length ?? 0,
            itemExtent: 170.0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildItemOrder(myOrders[index],context,index);
            },
          ),
        ],
      ),
    );
  }

  Widget buildItemOrder(MyOrdersStoreDetailsModule product , context , int index) {
    print(userStore[index].oRDERSTATE);
    if(product.oRDERSTATE == "1")
      colorStates[index] = Colors.lightGreen;
    else if(product.oRDERSTATE == "2")
      colorStates[index] = Colors.red;

    return Container(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      // borderRadius: BorderRadius(c),
      decoration:BoxDecoration(
        // border: Border.all(color: Colors.lightGreen),
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorStates[index],
            offset: Offset(1.0, 15.0),
            blurRadius: 20.0,
          ),
        ],
      ),
      height: 180,
      child: Row(
        children: <Widget>[
          Container(
            // decoration:BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(7.0),
            // ),
            width: 120,
            height: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(7.0), topLeft:Radius.circular(7.0) ),
              child: Ink(
                child:  new Image.asset('assets/images/car.jpg',  fit: BoxFit.cover , ),
                // child: new Image.memory(bytes[index], fit: BoxFit.cover),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:12.0 , bottom: 8.0),
                    child: Text(
                      product.iTEMNAMEE,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text("${AppLocalizations.of(context).translate('Price')}: "),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '\$ ${product.sALESPRICE}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("${AppLocalizations.of(context).translate('SubTotal')}: "),
                      SizedBox(
                        width: 5,
                      ),
                      Text('\$ ${product.iTEMTOTAL}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.orange,
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.check , color: Colors.lightGreen,),
                        tooltip: 'checked',
                        onPressed: () {
                          setState(() {
                            userStore[index].oRDERSTATE = "1";
                            product.oRDERSTATE = "1";
                            print(userStore[index].oRDERSTATE);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.clear , color: Colors.red,),
                        tooltip: 'rejected',
                        onPressed: () {
                          setState(() {
                            userStore[index].oRDERSTATE = "2";
                            product.oRDERSTATE = "2";
                            print(userStore[index].oRDERSTATE);
                            // colorStates = Colors.red;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _checkoutSection() {
    return Container(
      height: 150.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.only(topRight:  Radius.circular(40),topLeft:  Radius.circular(40)),
        color:  Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "${AppLocalizations.of(context).translate('TOTAL')}",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                      Text("\$ 200",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Material(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    elevation: 3.0,
                    child: InkWell(
                      splashColor: Theme
                          .of(context)
                          .primaryColor,
                      onTap: () {
                        String jsonUserStore = jsonEncode(userStore);
                        print(jsonUserStore);
                        updateOrderStatus(jsonUserStore);
                      },
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "${AppLocalizations.of(context).translate('Checkout')}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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