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

  //  static Future setUserAuth(String userNo , String key) async {
  //    String product = "={\"USER_NO\":\"$userNo\",\"KEY\":\"$key\"}";
  //    print(UserUrl.userAuthUrl+product);
  //    String url = UserUrl.userAuthUrl+product;
  //    print(url);
  //    return await http.get(UserUrl.userAuthUrl+"AUTHENTECATION$product");
  //  }


   //
   // static Future addVoucher(String vouchers) async {
   //   final res = await http.post(ProductsNewOrder.addVoucher , body: vouchers);
   //   print(ProductsNewOrder.addVoucher);
   //   print(res.statusCode);
   //   return res;
   // }


   // static Future getSliderImg() async{
   //     try {
   //       String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID";
   //       var prod = Constants.appUserID+"P_GetAds${product}"+Constants.appSecurityCode;
   //       List<int> bytes = utf8.encode(prod); // data being hashed
   //       String digest = sha1.convert(bytes).toString();
   //       return http.get(HomeConstant.getSliderUrl + "?$product&checksum=$digest");
   //     }
   //     catch(E){
   //       print("cant loading data from get product $E");
   //       return http.get(HomeConstant.getSliderUrl+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
   //     }
   //   }
   //
  // static Future getUsersStores () {
  //   try {
  //     print(ProductsNewOrder.getItem);
  //     return http.get(ProductsNewOrder.getItem);
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(ProductsNewOrder.getItem);
  //   }
  // }
  // Future<UsersStores> getUsersStores() async {
  //   final response = await http.get(ProductsNewOrder.getItem);
  //   if (response.statusCode == 200) {
  //     return UsersStores.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }
// static getStringValuesSF() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   orderID = prefs.getString('orderID') ;
//   if(orderID == null)
//     orderID = "";
//   print("Shared Preferences in orderID getString= $orderID");
//   // return orderID;
// }
  //
  // static Future getSliderImg() async{
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetAds${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     return http.get(HomeConstant.getSliderUrl + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(HomeConstant.getSliderUrl+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future getProducts(int categoryID) {
  //  try {
  //    String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&CategoryID=$categoryID";
  //    var prod = Constants.appUserID+"P_GetProducts${product}"+Constants.appSecurityCode;
  //    List<int> bytes = utf8.encode(prod); // data being hashed
  //    String digest = sha1.convert(bytes).toString();
  //    print(categoryID);
  //    print(prod);
  //    print(Products.getproductsUrl + "?$product&checksum=$digest");
  //    return http.get(Products.getproductsUrl + "?$product&checksum=$digest");
  //  }
  //  catch(E){
  //    print("cant loading data from get product $E");
  //    return http.get(Products.getproductsUrl+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //  }
  // }
  //
  // static Future getoffersProduct() {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&ComanyID=1";
  //     var prod = Constants.appUserID + "P_GetProductsOffers${product}" +
  //         Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Products.getoffersproductsUrl + "?$product&checksum=$digest");
  //     return http.get(
  //         Products.getoffersproductsUrl + "?$product&checksum=$digest");
  //   }
  //   catch (E) {
  //     print("cant loading data from get product $E");
  //     return http.get(Products.getoffersproductsUrl +
  //         "?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future addToFavorite(int productID) {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&ProductID=$productID";
  //     var prod = Constants.appUserID+"P_AddToFavorite${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     return http.get(Products.addToFavorite + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from addToFavorite $E");
  //     return http.get(Products.addToFavorite +"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future removeFromFavorite(int productID) {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&ProductID=$productID";
  //     var prod = Constants.appUserID+"P_RemoveFromFavorite${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     return http.get(Products.removefromFavorite + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from removeFromFavorite $E");
  //     return http.get(Products.removefromFavorite +"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future getFavoritsProducts() {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetFavoriteProducts${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     return http.get(HomeConstant.getFavoriteProductsUrl + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(HomeConstant.getFavoriteProductsUrl + "?CompanyID=1&LanguageID=1&UserID=1&checksum=5f642981cffc5fa96a9a3351970bcf732c6a5b9f");
  //   }
  // }
  //
  // static Future addToCart(int productID , int qty) async {
  //   await getStringValuesSF();
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&OrderID=$orderID&ProductID=$productID&Qty=$qty";
  //     var prod = Constants.appUserID+"P_AddToCart${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Cart.addToCart + "?$product&checksum=$digest");
  //     return http.get(Cart.addToCart + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(Cart.addToCart +"?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=e2f42a40f9e38bd7b0af9b9616695c9d0b624b39");
  //   }
  // }
  //
  // static Future removeFromCart(int productID , int qty) async {
  //   await getStringValuesSF();
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&OrderID=$orderID&ProductID=$productID&Qty=$qty";
  //     var prod = Constants.appUserID+"P_RemoveFromCart${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     return http.get(Cart.removeFromCart + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(Cart.removeFromCart + "?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=35cffd632132ddc229f74e0f6c9d9a52bd497da5");
  //   }
  // }
  //
  // static Future getMyCart() async{
  //   await getStringValuesSF();
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&OrderID=$orderID";
  //     var prod = Constants.appUserID+"P_GetMyCart${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Cart.getMyCart + "?$product&checksum=$digest");
  //     return http.get(Cart.getMyCart + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get my cart $E");
  //     return http.get(Cart.getMyCart + "?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=35cffd632132ddc229f74e0f6c9d9a52bd497da5");
  //   }
  // }
  //
  // static userSignUp(String userCode ,String userName ,String password ,String mobile ,String email ) {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserCode=$userCode&UserName=$userName&Password=$password&Mobile=$mobile&Email=$email";
  //     var prod = Constants.appUserID+"P_UserSignUp${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(product);
  //     print(prod);
  //     print(log.userSignUp + "?$product&checksum=$digest");
  //     return http.get(log.userSignUp + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get my cart $E");
  //     return http.get(log.userSignUp + "?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=35cffd632132ddc229f74e0f6c9d9a52bd497da5");
  //   }
  // }
  //
  // static userSignIn(String userCode ,String password) {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserCode=$userCode&Password=$password";
  //     var prod = Constants.appUserID+"P_UserSignIn${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     return http.get(log.userSignIn + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get my cart $E");
  //     return http.get(log.userSignIn + "?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=35cffd632132ddc229f74e0f6c9d9a52bd497da5");
  //   }
  // }
  //
  //
  // static Future deleteProduct(int productID) async{
  //   await getStringValuesSF();
  //   try {
  //     String product = "CompanyID=$companyID&UserID=$userID&OrderID=$orderID&ProductID=$productID";
  //     var prod = Constants.appUserID+"P_DeleteProduct$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     return http.get(Cart.deleteProduct + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(Cart.deleteProduct + "?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=35cffd632132ddc229f74e0f6c9d9a52bd497da5");
  //   }
  // }
  //
  // static Future getNotifications() {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetNotifications$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Notification.getNotifications + "?$product&checksum=$digest");
  //     return http.get(Notification.getNotifications + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(Notification.getNotifications+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  //
  // static Future confirmCart() async{
  //   await getStringValuesSF();
  //   try {
  //     String product = "CompanyID=$companyID&UserID=$userID&OrderID=$orderID&LocationID=$locationID";
  //     var prod = Constants.appUserID+"P_ConfirmCart$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Cart.confirmCart + "?$product&checksum=$digest");
  //     return http.get(Cart.confirmCart + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(Cart.confirmCart+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  //
  // static Future getBestForMeProducts() async{
  //   await getStringValuesSF();
  //   try {
  //     String product = "CompanyID=$companyID&UserID=$userID&OrderID=$orderID&LocationID=$locationID";
  //     var prod = Constants.appUserID+"P_GetBestForMeProducts$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(HomeConstant.getBestForMeProducts + "?$product&checksum=$digest");
  //     return http.get(HomeConstant.getBestForMeProducts + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(HomeConstant.getBestForMeProducts+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  //
  // static Future emptyTheCart() async{
  //   await getStringValuesSF();
  //   try {
  //     String product = "CompanyID=$companyID&UserID=$userID&OrderID=$orderID";
  //     var prod = Constants.appUserID+"P_EmptyTheCart$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Cart.emptyTheCart + "?$product&checksum=$digest");
  //     return http.get(Cart.emptyTheCart + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(Cart.emptyTheCart+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  //
  // static Future getCompanies() {
  //   try {
  //     String product = "LanguageID=$languageID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetCompanies$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Constants.getCompanies + "?$product&checksum=$digest");
  //     return http.get(Constants.getCompanies + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(Constants.getCompanies+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  //
  // static Future getLanguages() {
  //   try {
  //     String product = "CompanyID=$companyID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetLanguages$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Constants.getLanguages + "?$product&checksum=$digest");
  //     return http.get(Constants.getLanguages + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(Constants.getLanguages+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future searchProducts(String searchedValue) {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&SearchedValue=$searchedValue";
  //     var prod = Constants.appUserID+"P_SearchProducts$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(HomeConstant.searchProduct + "?$product&checksum=$digest");
  //     return http.get(HomeConstant.searchProduct + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(HomeConstant.searchProduct+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future getProductInfo(int productID) {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&ProductID=$productID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetProductInfo${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Products.getProductInfoUrl + "?$product&checksum=$digest");
  //     return http.get(Products.getProductInfoUrl + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(Products.getProductInfoUrl+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future getLoyaltyPoints() {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetLoyaltyPoints$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(HomeConstant.loyaltyPoints + "?$product&checksum=$digest");
  //     return http.get(HomeConstant.loyaltyPoints + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(HomeConstant.loyaltyPoints+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future getCoupons() {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetCoupons$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(HomeConstant.getCoupons + "?$product&checksum=$digest");
  //     return http.get(HomeConstant.getCoupons + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(HomeConstant.getCoupons+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future discountCode(String discountCode) async{
  //   await getStringValuesSF();
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&OrderID=$orderID&DiscountCode=$discountCode";
  //     var prod = Constants.appUserID+"P_DiscountCode$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(HomeConstant.discountCode + "?$product&checksum=$digest");
  //     return http.get(HomeConstant.discountCode + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(HomeConstant.discountCode+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  //
  // static Future getMyOrders() {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetMyOrders$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Order.getOrdersUrl + "?$product&checksum=$digest");
  //     return http.get(Order.getOrdersUrl + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(Order.getOrdersUrl+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  //
  // static Future changePassword(String oldPassword , String newPassword) {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&OldPassword=$oldPassword&NewPassword=$newPassword";
  //     var prod = Constants.appUserID+"P_ChangePassword$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(UserUrl.changePassword + "?$product&checksum=$digest");
  //     return http.get(UserUrl.changePassword + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(UserUrl.changePassword+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future getFeaturedProducts() {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetFeaturedProducts$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(HomeConstant.getFeaturedProducts + "?$product&checksum=$digest");
  //     return http.get(HomeConstant.getFeaturedProducts + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(HomeConstant.getFeaturedProducts+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future getMyOrderDetails(int orderIds) async{
  //   await getStringValuesSF();
  //   try {
  //     String product = "LanguageID=$languageID&UserID=$userID&OrderID=$orderIds";
  //     var prod = Constants.appUserID+"P_GetMyOrderDetails$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Order.getMyOrderDetails + "?$product&checksum=$digest");
  //     return http.get(Order.getMyOrderDetails + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(Order.getMyOrderDetails+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future addVisitedProduct(int productID) {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&ProductID=$productID";
  //     var prod = Constants.appUserID+"P_VisitedProduct$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Products.addToVisited + "?$product&checksum=$digest");
  //     return http.get(Products.addToVisited + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(Products.addToVisited+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future getVisitedProducts() {
  //   try {
  //     String product = 'CompanyID=$companyID&LanguageID=$languageID&UserID=$userID';
  //     var prod = Constants.appUserID+"P_GetVisitedProducts$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Products.getVisitedProducts + "?$product&checksum=$digest");
  //     return http.get(Products.getVisitedProducts + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get product $E");
  //     return http.get(Products.getVisitedProducts+"?CompanyID=1&LanguageID=1&UserID=1&CategoryID=113&checksum=6540edecbcf7688ce56ddb4ed9e4107838519c0f");
  //   }
  // }
  //
  // static Future applyLoyaltyPoint() {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_ApplyLoyaltyPoint$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Cart.applyLoyaltyPoint + "?$product&checksum=$digest");
  //     return http.get(Cart.applyLoyaltyPoint + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(Cart.applyLoyaltyPoint +"?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=e2f42a40f9e38bd7b0af9b9616695c9d0b624b39");
  //   }
  // }
  //
  // static Future applyCoupon(int couponID) async{
  //   await getStringValuesSF();
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&OrderID=$orderID&CouponID=$couponID";
  //     var prod = Constants.appUserID+"P_ApplyCoupon$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Cart.applyCoupon + "?$product&checksum=$digest");
  //     return http.get(Cart.applyCoupon + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(Cart.applyCoupon +"?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=e2f42a40f9e38bd7b0af9b9616695c9d0b624b39");
  //   }
  // }
  //
  // static Future saveUserLocation(int locationID, String description , String mapUrlDescription , double longitude, double latitude , double zoom, int defaultLocation) {
  //   try {
  //     String product = "UserID=$userID&LocationID=$locationID&Description=$description&MapUrlDescription=$mapUrlDescription&Longitude=$latitude&Latitude=$longitude&Zoom=$zoom&DefaultLocation=$defaultLocation";
  //     var prod = Constants.appUserID+"P_SaveUserLocation$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Location.saveUserLocation + "?$product&checksum=$digest");
  //     return http.get(Location.saveUserLocation + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(Location.saveUserLocation +"?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=e2f42a40f9e38bd7b0af9b9616695c9d0b624b39");
  //   }
  // }
  //
  // static Future getUserLocations() {
  //   try {
  //     String product = "UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetUserLocations$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Location.getUserLocations + "?$product&checksum=$digest");
  //     return http.get(Location.getUserLocations + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(Location.getUserLocations +"?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=e2f42a40f9e38bd7b0af9b9616695c9d0b624b39");
  //   }
  // }
  //
  // static Future deleteUserLocation(int locationID){
  // try {
  //     String product = "UserID=$userID&LocationID=$locationID";
  //     var prod = Constants.appUserID+"P_DeleteUserLocation$product"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Location.deleteUserLocation + "?$product&checksum=$digest");
  //     return http.get(Location.deleteUserLocation + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(Location.deleteUserLocation +"?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=e2f42a40f9e38bd7b0af9b9616695c9d0b624b39");
  //   }
  // }
  //
  // static userSignOut() {
  //   try {
  //     String product = "CompanyID=$companyID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_UserSignOut${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     return http.get(log.userSignOut + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get my cart $E");
  //     return http.get(log.userSignIn + "?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=35cffd632132ddc229f74e0f6c9d9a52bd497da5");
  //   }
  // }
  //
  // static getUserInfo() {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID";
  //     var prod = Constants.appUserID+"P_GetUserInfo${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(UserUrl.getUserInfo + "?$product&checksum=$digest");
  //     return http.get(UserUrl.getUserInfo + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get my cart $E");
  //     return http.get(UserUrl.getUserInfo  + "?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=35cffd632132ddc229f74e0f6c9d9a52bd497da5");
  //   }
  // }
  //
  // static updateUserInfo(String userName,String mobile, String email ) {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&UserName=$userName&Mobile=$mobile&Email=$email";
  //     var prod = Constants.appUserID+"P_UpdateUserInfo${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(UserUrl.updateUserInfo + "?$product&checksum=$digest");
  //     return http.get(UserUrl.updateUserInfo + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get my cart $E");
  //     return http.get(UserUrl.updateUserInfo  + "?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=35cffd632132ddc229f74e0f6c9d9a52bd497da5");
  //   }
  // }
  //
  //
  // static Future getMyOrderInfo(String thisorderID) async{
  //   await getStringValuesSF();
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&OrderID=$thisorderID";
  //     var prod = Constants.appUserID+"P_GetMyOrderInfo${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Cart.getMyOrderInfo + "?$product&checksum=$digest");
  //     return http.get(Cart.getMyOrderInfo + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(Cart.getMyOrderInfo +"?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=e2f42a40f9e38bd7b0af9b9616695c9d0b624b39");
  //   }
  // }
  //
  //
  // static Future setNotificationsSeen(int notificationID) {
  //   try {
  //     String product = "CompanyID=$companyID&LanguageID=$languageID&UserID=$userID&OrderID=$orderID&NotificationID=$notificationID";
  //     var prod = Constants.appUserID+"P_SetNotificationsSeen${product}"+Constants.appSecurityCode;
  //     List<int> bytes = utf8.encode(prod); // data being hashed
  //     String digest = sha1.convert(bytes).toString();
  //     print(Notification.setNotificationsSeen + "?$product&checksum=$digest");
  //     return http.get(Notification.setNotificationsSeen + "?$product&checksum=$digest");
  //   }
  //   catch(E){
  //     print("cant loading data from get favirots product $E");
  //     return http.get(Notification.setNotificationsSeen +"?CompanyID=1&LanguageID=1&UserID=1&OrderID=1&ProductID=1&Qty=1&checksum=e2f42a40f9e38bd7b0af9b9616695c9d0b624b39");
  //   }
  // }
}