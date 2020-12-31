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

  getMyOrderStoreDetails() async{
    await API.getMyOrderStoreDetails(serialNo , vouchNo).then((response) {
      setState(() {
        userStore = response;
        for(int i=0 ; i< userStore.length ; i++)
          colorStates.add(Colors.white);
        print(" userStore = $userStore");
      });
    });
  }

  @override
  void initState() {
    getMyOrderStoreDetails();
    super.initState();
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
              if(userStore.isNotEmpty)
              Center(
                child: getSnapshot(userStore)
              ),
              // _checkoutSection()
            ],
          ),
        ),
      ),
      bottomNavigationBar:_checkoutSection(),
    );
  }

  Widget getSnapshot(List<MyOrdersStoreDetailsModule> myOrders) {
    return ListView.builder(
      // controller: _controller,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: myOrders?.length ?? 0,
      // itemExtent: 170.0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return buildItemOrder(myOrders[index],context,index);
      },
    );
  }

  Widget buildItemOrder(MyOrdersStoreDetailsModule product , context , int index) {
    print(product.oRDERSTATE);
    if(product.oRDERSTATE == "1") {
      product.oRDERSTATE = "1";
      colorStates[index] = Colors.lightGreen;
    }
    else if(product.oRDERSTATE == "2") {
      product.oRDERSTATE = "2";
      colorStates[index] = Colors.red;
    }

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
      height: 150,
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
                            product.oRDERSTATE = "1";
                            product.oRDERSTATE = "1";
                            print(product.oRDERSTATE);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.clear , color: Colors.red,),
                        tooltip: 'rejected',
                        onPressed: () {
                          setState(() {
                            product.oRDERSTATE = "2";
                            product.oRDERSTATE = "2";
                            print(product.oRDERSTATE);
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
      height: 90.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.only(topRight:  Radius.circular(40),topLeft:  Radius.circular(40)),
        color:  Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
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
