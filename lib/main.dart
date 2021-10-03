import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhino_pizzeria_challenge/routes/home/home.dart';
import 'package:rhino_pizzeria_challenge/routes/map/google_map.dart';
import 'package:rhino_pizzeria_challenge/routes/product/add_new_product.dart';
import 'package:rhino_pizzeria_challenge/routes/setup.dart';
import 'package:rhino_pizzeria_challenge/services/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignInProvider(),
        ),      
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'GoogleMap': (context) => const GoogleMap(),
        'AddNew': (context) => const NewProduct(),
        'Home': (context) => const HomePage(),
      },
      home: const Setting(),
    );
  }
}
