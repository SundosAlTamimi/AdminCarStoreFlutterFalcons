import 'package:flutter/material.dart';
import 'package:flutter_app_test/View/MyOrdersStoreDetails.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'View/Home.dart';
import 'View/MyOrdersStore.dart';
import 'View/MyOrders.dart';
import 'View/UserDefine.dart';
import 'app_localizations.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    final Locale locale = Locale('ar');
    runApp( MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.lightGreen,
            accentColor: Colors.lightBlue[900],
            fontFamily: locale.languageCode == 'ar' ? 'Dubai' : 'Lato'),
        supportedLocales: [
            Locale('en', 'GB'),
            Locale('ar', 'JO'),
        ],
        //&&
        //                     supportedLocale.countryCode == locale.countryCode
        // These delegates make sure that the localization data for the proper language is loaded
        localizationsDelegates: [
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
        ],
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
                print("supportedLocale = $supportedLocale");
                if (supportedLocale.languageCode == locale.languageCode ) {
                    print("supportedLocale = $supportedLocale");
                    print("supportedLocale = ${supportedLocale.languageCode}");
                    return supportedLocale;
                }
            }
            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
        },
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => Home(),
            '/userDefine': (BuildContext context) => UserDefine(),
            '/myOrder': (BuildContext context) => MyOrders(),
            '/myOrderStore': (BuildContext context) => MyOrdersStore.c(),
            '/myOrderStoreDetails': (BuildContext context) => MyOrdersStoreDetails.c(),
        },
      ),
    );
}
