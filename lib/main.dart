import 'package:flutter/material.dart';
import 'package:test_maps/CustomMarkers/custom_markers.dart';
import 'package:test_maps/GetUserLocation/get_user_location.dart';
import 'package:test_maps/MyHomeScreen/my_home_screen.dart';
import 'package:test_maps/PlacesApiGoogle/places_api_google.dart';

import 'CustomInfoWindow/custom_info_window.dart';
import 'TransformLatLngToAddress/transform_latlng.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomeScreen(),
    );
  }
}

