import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_test/Module/MyOrdersModule.dart';
import 'package:flutter_app_test/Module/MyOrdersStoreDetailsModule.dart';
import 'package:flutter_app_test/Module/MyOrdersStoreModule.dart';
import 'package:flutter_app_test/Module/UserStores.dart';
import 'package:http/http.dart' as http;
import 'Constants.dart';

class API {

   static Future<List<UserStores>> getUsersStores() async {
    final res = await http.get(HomeConstant.getStores);
    print(HomeConstant.getStores);
    if (res.statusCode == 200) {
      Iterable list  = json.decode(res.body);
      return list.map((users) => new UserStores.fromJson(users)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

   static Future addUserStores(String barCode) async {
     var body = {"ADD_USER_STORES": barCode};
     final res = await http.post(UserUrl.addUserStores , body: body);
     print(UserUrl.addUserStores);
     print(res.statusCode);
     return res;
   }

   static Future generateUserKey(String val) async {
     print("generateUserKey");
     var body = {"GENERATING_KEY": val};
     final res = await http.post(UserUrl.generateKey , body: body);
     print(UserUrl.generateKey);
     print(res.statusCode);
     return res;
   }

   static Future updateUserStores(String barCode) async {
     var body = {"UPDATE_USER_STORES": barCode};
     final res = await http.post(UserUrl.updateUserStores , body: body);
     print(UserUrl.updateUserStores);
     print(res.statusCode);
     return res;
   }

   static Future<List<MyOrdersModule>> getMyOrders() async {
     final res = await http.get(Order.getOrdersUrl);
     print(Order.getOrdersUrl);
     if (res.statusCode == 200) {
       Iterable list  = json.decode(res.body);
       return list.map((users) => new MyOrdersModule.fromJson(users)).toList();
     } else {
       throw Exception('Failed to fetch data');
     }
   }

   static Future<List<MyOrdersStoreModule>> getMyOrderStore(String serialNo) async {
     final res = await http.get(Order.getMyOrderStore+serialNo);
     print(Order.getMyOrderStore+serialNo);
     if (res.statusCode == 200) {
       Iterable list  = json.decode(res.body);
       return list.map((users) => new MyOrdersStoreModule.fromJson(users)).toList();
     } else {
       throw Exception('Failed to fetch data');
     }
   }

   static Future<List<MyOrdersStoreDetailsModule>> getMyOrderStoreDetails(String serialNo , String vouchNo) async {
     final res = await http.get(Order.getMyOrderStoreDetails+serialNo + "&VOUCHER_NO="+ vouchNo);
     print(Order.getMyOrderStoreDetails+serialNo + "&VOUCHER_NO="+ vouchNo);
     if (res.statusCode == 200) {
       Iterable list  = json.decode(res.body);
       return list.map((users) => new MyOrdersStoreDetailsModule.fromJson(users)).toList();
     } else {
       throw Exception('Failed to fetch data');
     }
   }

  static Future updateOrderStatus(String barCode) async {
    var body = {"UPDATE_ORDER_STATE": barCode};
    final res = await http.post(Order.updateOrderStatus , body: body);
    print(Order.updateOrderStatus);
    print(res.statusCode);
    return res;
  }

}