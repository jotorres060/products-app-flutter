import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:validation_app/pages/pages.dart';
import 'package:validation_app/services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {

  const AppState({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsService())
      ],
      child: const MyApp(),
    );
  }

}

class MyApp extends StatelessWidget {

  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'login': (_) => const LoginPage(),
        'home': (_) => const HomePage(),
        'product': (_) => const ProductPage()
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
    );
  }

}
