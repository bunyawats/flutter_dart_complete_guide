import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_list_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/order_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/product_overview_screen.dart';
import 'screens/user_product_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(ShopApp());

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, ProductList>(
            update: (
              ctx,
              auth,
              previousProductList,
            ) =>
                ProductList(
              auth.token,
              auth.userId,
              previousProductList == null ? [] : previousProductList.items,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, OrderList>(
              update: (
            ctx,
            auth,
            previousOrderList,
          ) =>
                  OrderList(
                    auth.token,
                    auth.userId,
                    previousOrderList == null ? [] : previousOrderList.orders,
                  )),
          ChangeNotifierProvider(create: (ctx) => Cart()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Shop App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            // initialRoute: ProductOverviewScreen.routeName,
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, authResultSnapShot) {
                      return authResultSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen();
                    }),
            routes: {
              ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
              AuthScreen.routeName: (ctx) => AuthScreen(),
            },
          ),
        ));
  }
}
