import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkers extends StatefulWidget {

  @override
  State<CustomMarkers> createState() => _CustomMarkersState();
}

class _CustomMarkersState extends State<CustomMarkers> {

  List<String> images =
  [
    'images/s.png',
    'images/car.png',
    'images/mark1.png',
    'images/s.png',
  ];

  final List<LatLng> latLngForImages = <LatLng>
  [
    const LatLng(24.734265, 46.757586),
    const LatLng(24.754265, 46.767586),
    const LatLng(24.7444265,46.7787586),
    const LatLng(24.7244265,46.7487586),
  ];

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.7244265,46.7487586),
    zoom: 12,
  );

  final List<Marker> myMarker = [];

  Future<Uint8List> getImagesFromMArkers(String path, int width) async
  {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  packData()async
  {
    for(int a = 0; a<images.length; a++)
    {
      final Uint8List iconMarker = await getImagesFromMArkers(images[a], 90);
      myMarker.add(
        Marker(
            markerId: MarkerId(a.toString()),
            position: latLngForImages[a],
          icon: BitmapDescriptor.fromBytes(iconMarker),
          infoWindow: InfoWindow(
            title: 'Title Marker: $a',
          )
        )
      );
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    packData();
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
    );
  }
}
