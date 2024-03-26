import 'package:flutter/material.dart';
import 'package:flutter_application_1/google_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyGoogleMap(),
      theme: ThemeData( 
        textTheme: GoogleFonts.openSansTextTheme( 
          Theme.of(context).textTheme.apply(),
        ),
        appBarTheme: AppBarTheme( 
          backgroundColor: Colors.blue,
           titleTextStyle: TextStyle(color: Colors.white,fontSize: 22)
        )
      ),
    );
  }
}
