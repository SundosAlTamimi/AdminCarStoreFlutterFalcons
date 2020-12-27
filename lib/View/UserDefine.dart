import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/Controller/FetchData.dart';
import 'package:flutter_app_test/Module/GeneratingKey.dart';
import 'package:flutter_app_test/Module/UserStores.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../app_localizations.dart';

// ignore: must_be_immutable
class UserDefine extends StatefulWidget {
  UserDefine({this.userStores});
  UserStores userStores = new UserStores() ;
  @override
  _UserDefineState createState() => _UserDefineState(userStores);
}
enum activeNewOrder { once , more , unlimted }

class _UserDefineState extends State<UserDefine> {
  // UserStores userStoresFrom;
  final _formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController userNumber = TextEditingController();
  TextEditingController userKey = TextEditingController();
  TextEditingController activeMore = TextEditingController();
  String numActive;
  activeNewOrder active = activeNewOrder.once;
  bool visiableCount = false;
  bool activeOrder = false;
  bool deactiveOrder = false;
  bool run = true;
  bool enabledKey = true;
  Color colorKey =  Colors.lightGreen;
  UserStores userStores = new UserStores();
  List<GeneratingKey> generatingKey = new List<GeneratingKey>();

  _UserDefineState(this.userStores){
    print("userStores = $userStores");
    if(userStores == null)
      userStores = new UserStores();
    colorKey =  Colors.lightGreen;
  }

  static void notificationSuccessfully(context){
    Alert(
      context: context,
      image: Image.asset("assets/images/success.png" , width: 50 , height: 50,),
      title: "${AppLocalizations.of(context).translate('SuccessfullyAdded')}",
      desc: "${AppLocalizations.of(context).translate('SuccessfullyAddedDetails')}",
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

  void addUserStores (String jsonUserStore){
    API.addUserStores(jsonUserStore).then((response) {
      if(response.statusCode == 200) {
        notificationSuccessfully(context);
      }
    });
  }

  void generateUserKey (){
    API.generateUserKey("1").then((response) {
      if(response.statusCode == 200) {
       setState(() {
         Iterable list  = json.decode(response.body);
         generatingKey = list.map((users) => new GeneratingKey.fromJson(users)).toList();
         userKey.text = generatingKey[0].kEY;
       });
      }
    });
  }

  void saveUserStores(){
    print(userName.text);
    userStores.uSERNAME = userName.text;
    userStores.uSERNO = userNumber.text;
    userStores.kEY = userKey.text;
    if(activeOrder) {
      if (active == activeNewOrder.once)
        numActive = "1";
      else if (active == activeNewOrder.more)
        numActive = activeMore.text;
      else
        numActive = "*";
      userStores.nOOFACTIVE = numActive;
      userStores.dEACTIVE = "0";
    } else{
      userStores.nOOFACTIVE = "0";
      userStores.dEACTIVE = "1";
    }
    String jsonUserStore = jsonEncode(userStores);
    print(jsonUserStore);
    addUserStores(jsonUserStore);
  }

  void checkObject(){
    setState(() {
      if(userStores.uSERNAME != null){
        print(userStores.uSERNAME);
        colorKey = Colors.blueGrey;
        enabledKey = false;
        userName.text = userStores.uSERNAME ;
        userNumber.text = userStores.uSERNO;
        userKey.text = userStores.kEY;
        if(userStores.nOOFACTIVE != "0") {
          activeOrder = true;
          deactiveOrder = false;
          if (userStores.nOOFACTIVE == "1")
            active = activeNewOrder.once;
          else if (userStores.nOOFACTIVE == "*")
            active = activeNewOrder.unlimted;
          else{
            active = activeNewOrder.more;
            visiableCount = true;
            activeMore.text = userStores.nOOFACTIVE;
          }
        } else{
          activeOrder = false;
          deactiveOrder = true;
        }
      }
    });

  }

  void generateKey(){
    print("userStores.uSERNAME");
    setState(() {
      enabledKey = false;
      colorKey = Colors.blueGrey;
      generateUserKey();
    });

  }

  @override
  Widget build(BuildContext context) {
    if(run) {
      enabledKey = true;
      colorKey =  Colors.lightGreen;
      checkObject();
      run = false;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("${AppLocalizations.of(context).translate('costomerinfo')}"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TextFormField(
                      controller: userName,
                      decoration: InputDecoration(
                        hintText: "${AppLocalizations.of(context).translate('enterUsername')}",
                        labelText: "${AppLocalizations.of(context).translate('Username')}",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      controller: userNumber,
                      decoration: InputDecoration(
                        hintText: "${AppLocalizations.of(context).translate('EnterUserNo')}",
                        labelText: "${AppLocalizations.of(context).translate('UserNo')}",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      children:<Widget> [
                        SizedBox(
                          width: MediaQuery.of(context).size.width /2,
                          child: TextField(
                            controller: userKey,
                            enabled: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: colorKey)
                            ),
                            child: Text("${AppLocalizations.of(context).translate('GenerateKey')}", style: TextStyle(fontSize: 14.0),),
                            color: colorKey,
                            textColor: Colors.white,
                            height: 55,
                            onPressed: () {
                              print("onPressed key");
                              print(enabledKey);
                              // ignore: unnecessary_statements
                              enabledKey ? generateKey() : null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: CheckboxListTile(
                      activeColor:Colors.lightGreen ,
                      title: Text("${AppLocalizations.of(context).translate('ActiveNewOrder')}"),
                      value: activeOrder,
                      onChanged: (newValue) {
                        setState(() {
                          activeOrder = newValue;
                          deactiveOrder = !newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    )
                  ),
                  Visibility(
                    visible: activeOrder,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("${AppLocalizations.of(context).translate('Once')}"),
                            leading: Radio(
                              activeColor:Colors.lightGreen ,
                              value: activeNewOrder.once,
                              groupValue: active,
                              onChanged: (activeNewOrder value) {
                                setState(() {
                                  active = value;
                                  visiableCount = false;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("${AppLocalizations.of(context).translate('More')}"),
                            leading: Radio(
                              activeColor:Colors.lightGreen ,
                              value: activeNewOrder.more,
                              groupValue: active,
                              onChanged: (activeNewOrder value) {
                                setState(() {
                                  active = value;
                                  visiableCount = true;
                                });
                              },
                            ),
                            trailing:Visibility(
                              visible: visiableCount ,
                              child: SizedBox(
                                width: 100,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextFormField(
                                    controller: activeMore,
                                    decoration: InputDecoration(
                                      hintText: "${AppLocalizations.of(context).translate('EnterCount')}",
                                      // labelText: "${AppLocalizations.of(context).translate('Count')}",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text("${AppLocalizations.of(context).translate('UnLimited')}"),
                            leading: Radio(
                              activeColor:Colors.lightGreen ,
                              value: activeNewOrder.unlimted,
                              groupValue: active,
                              onChanged: (activeNewOrder value) {
                                setState(() {
                                  active = value;
                                  visiableCount = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: CheckboxListTile(
                        activeColor:Colors.lightGreen ,
                        title: Text("${AppLocalizations.of(context).translate('DeactivateUser')}"),
                        value: deactiveOrder,
                        onChanged: (newValue) {
                          setState(() {
                            deactiveOrder = newValue;
                            activeOrder = !newValue;

                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width:MediaQuery.of(context).size.width /2,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.lightGreen)
                        ),
                          color: Colors.lightGreen,
                          textColor: Colors.white,
                          child: Text("${AppLocalizations.of(context).translate('Save')}"),
                          onPressed: () {
                            saveUserStores();
                          },
                        )
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
    );
  }

}
