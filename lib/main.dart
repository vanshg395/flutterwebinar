import 'package:flutter/material.dart';
import 'package:flutterwebinar/screens/home_screen.dart';
import 'package:flutterwebinar/screens/register_screen.dart';
import 'package:provider/provider.dart';

import './screens/login_screen.dart';
import './providers/auth.dart';
import './providers/items.dart';
import './loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Items(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, res) {
                    if (res.connectionState == ConnectionState.waiting) {
                      return LoadingScreen();
                    } else {
                      if (res.data) {
                        return HomeScreen();
                      } else {
                        return LoginScreen();
                      }
                    }
                  },
                ),
        ),
      ),
    );
  }
}
