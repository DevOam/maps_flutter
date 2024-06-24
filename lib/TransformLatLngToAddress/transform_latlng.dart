import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class TransformLatLngToAdress extends StatefulWidget {
  const TransformLatLngToAdress({Key? key}) : super(key: key);

  @override
  State<TransformLatLngToAdress> createState() => _TransformLatLngToAdressState();
}

class _TransformLatLngToAdressState extends State<TransformLatLngToAdress> {

  String placeM = '';
  String addressOnScreen ='';

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.teal,],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0,1.0],
          tileMode: TileMode.clamp,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(addressOnScreen),
            Text(placeM),
            GestureDetector(
              onTap: ()
                async
                {
                  List<Location> location = await locationFromAddress('Alvaro, Khouribga, Morocco');
                  

                  List<Placemark> placemark = await placemarkFromCoordinates(32.886023, -6.9208655);
                  setState(() {
                      addressOnScreen = '${location.last.latitude}' '${location.last.longitude}';
                      placeM = '${placemark.reversed.last.country} ${placemark.reversed.last.locality} & ${placemark.reversed.last.postalCode}';

                  });
                  },
              child: Padding(
                padding: const EdgeInsets.all((8.0)),
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  child: const Center(
                    child: Text('Hit to Convert'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
