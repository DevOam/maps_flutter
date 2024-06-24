import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
class PlacesApiGoogleMapSearch extends StatefulWidget {

  @override
  State<PlacesApiGoogleMapSearch> createState() => _PlacesApiGoogleMapSearchState();
}

class _PlacesApiGoogleMapSearchState extends State<PlacesApiGoogleMapSearch> {

  String tokenForSession = '37465';

  var uuid = Uuid();

  List<dynamic> listeForPalces = [];

  final TextEditingController _controller = TextEditingController();

  void makeSuggestion(String input)async
  {
    String googlePlaceApiKey = 'AIzaSyCegnfkL_QhFKW1KWm_i5VEuIe_HuMvb1s';
    String groundURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$groundURL?input=$input&key=$googlePlaceApiKey&sessiontoken=$tokenForSession';

    var responseResult = await http.get(Uri.parse(request));
    
    var resultData = responseResult.body.toString();
    
    print('Result Data');
    print(resultData);

    if (responseResult.statusCode == 200)
    {
      setState(() {
        listeForPalces =  jsonDecode(responseResult.body.toString()) ['predictions'];
      });
    }
    else{
      throw Exception('showing data failed, Try Again');
    }
  }

  void onModify()
  {
    if (tokenForSession ==  null )
    {
      setState(() {
          tokenForSession = uuid.v4();
      });
    }

    makeSuggestion(_controller.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onModify();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.yellow,],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Places Api Google Search'),
        flexibleSpace: Container(
          decoration:const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow, Colors.orange,],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Search here'
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: listeForPalces.length,
                      itemBuilder: (context, index)
                      {
                        return ListTile(
                          onTap: ()
                          async
                          {
                            List<Location> locations = await locationFromAddress(listeForPalces[index] ['description']);
                            print(locations.last.latitude);
                            print(locations.last.longitude);
                          },
                          title: Text(listeForPalces[index]['description']),
                        );
                      },
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
