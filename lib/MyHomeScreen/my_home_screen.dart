import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomeScreen extends StatefulWidget {

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.774265, 46.738586),
    zoom: 14,
  );

  final List<Marker> myMarker = [];
  final List<Marker> markerList =const[
     Marker(markerId: MarkerId('First'),
      position: LatLng(24.765265, 46.763586),
      infoWindow: InfoWindow(
        title: 'My Position',
      )
    ),
     Marker(markerId: MarkerId('Seconde'),
        position: LatLng(24.754290, 46.758345),
        infoWindow: InfoWindow(
          title: 'G-9 Area',
        )
    ),
    Marker(markerId: MarkerId('Third'),
        position: LatLng(24.739190, 46.739245),
        infoWindow: InfoWindow(
          title: 'F11-9 Area',
        )
    ),
    Marker(markerId: MarkerId('Fourth'),
        position: LatLng(24.744190, 46.748245),
        infoWindow: InfoWindow(
          title: 'Blue Area',
        )
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMarker.addAll(markerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          markers: Set<Marker>.of(myMarker),
          onMapCreated:(GoogleMapController controler)
          {
            _controller.complete(controler);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_searching),
        onPressed: ()
        async
        {
          GoogleMapController controller =  await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            const CameraPosition(
                target: LatLng(24.774265, 46.738586),
              zoom: 14,
            )
          ));
          setState(() {

          });
        },
      ),
    );
  }
}
