import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindowMarker extends StatefulWidget {

  @override
  State<CustomInfoWindowMarker> createState() => _CustomInfoWindowMarkerState();
}

class _CustomInfoWindowMarkerState extends State<CustomInfoWindowMarker> {

  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  final List<Marker> myMarker = [];

  final List<LatLng> latLngForMarkers = <LatLng>
  [
    const LatLng(24.734265, 46.738586),
    const LatLng(24.774265, 46.778586),
    const LatLng(24.7794265, 46.7978586),
  ];

  onLoadData() {
    for (int a = 0; a < latLngForMarkers.length; a++) {
      myMarker.add(
        Marker(
          markerId: MarkerId(a.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: latLngForMarkers[a],
          onTap: ()
          {
            _customInfoWindowController.addInfoWindow!(
                Container(
                  height:300 ,
                  width: 200,
                  decoration: BoxDecoration(
                      color:  Colors.yellow,
                      border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 90,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://yt3.ggpht.com/a/AATXAJyjtsc6RE6S0i7N8jRro0xpfb5AlCKl9WfRTw=s900-c-k-c0xffffffff-no-rj-mo'),
                              fit: BoxFit.fitWidth,
                              filterQuality: FilterQuality.high,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    'starbuks',
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                ),
                                Spacer(),
                                Text('3min...'),
                              ],
                            ),
                        ),
                        const Padding(
                            padding:EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Text(
                              'كملنا في ستارباكس يوم الخميس من الساعة 8 ليلا حتى الساعة 10 ',
                              maxLines: 2,
                            ),
                        ),
                        const Padding(
                          padding:EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Row(
                            children: [
                              Icon(Icons.share),
                              Spacer(),
                              Text('اتجاهات'),
                              Spacer(),
                          Text(
                                'إرسال طلب',
                          ),

                              // const Padding(
                              //   padding:EdgeInsets.only(top: 10, left: 10, right: 10),
                              //   child: Icon(Icons.share),
                              // ),
                              //
                              // const Padding(
                              //   padding:EdgeInsets.only(top: 10, left: 10, right: 10),
                              //   child: Text('اتجاهات'),
                              // ),
                              // const Padding(
                              //   padding:EdgeInsets.only(top: 10, left: 10, right: 10),
                              //   child: Text(
                              //     'إرسال طلب',
                              //     maxLines: 2,
                              //   ),
                              // ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                  latLngForMarkers[a]
            );
          }
        ),
      );
      setState(() {

      });
    }
}

@override
void initState() {
  // TODO: implement initState
  super.initState();
  onLoadData();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(24.734265, 46.738586),
            zoom: 14,
          ),
          markers: Set<Marker>.of(myMarker),
          onTap: (position)
          {
            _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (poistion)
          {
            _customInfoWindowController.onCameraMove!();
          },
          onMapCreated: (GoogleMapController controller)
          {
            _customInfoWindowController.googleMapController = controller;
          },
        ),
        CustomInfoWindow(
            controller: _customInfoWindowController,
          height: 150,
          width: 200,
          offset: 40,
         ),
      ],
    ),
  );
}}
