import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
class MyGoogleMap extends StatefulWidget {
  

  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
  
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  static CameraPosition cameraPosition= CameraPosition( 
    target: LatLng(23.70531033192049, 90.48108336081226),
    zoom: 13,
    );
    final Completer<GoogleMapController> _controller=Completer();
  final List<Marker> myMarker=[];
  final List<Marker> markerList=[
        Marker(
          markerId: MarkerId('First'),
          position: LatLng(23.710220216130576, 90.48937879814673),
          infoWindow: InfoWindow( 
            title: 'Garden Road',
          ),
         ),
          Marker(
          markerId: MarkerId('Second'),
          position: LatLng(23.706892830229908, 90.48511208678394),
          infoWindow: InfoWindow( 
            title: 'Dogai',
          ),
         ),
          Marker(
          markerId: MarkerId('Pabna'),
          position: LatLng(24.00973563496197, 89.27673932760945),
          infoWindow: InfoWindow( 
            title: 'Sumi Akter',
          ),
         ),
  ];
  @override
  void initState() {
    myMarker.addAll(markerList);
    packdata();
    // TODO: implement initState
    super.initState();
  }
 Future<Position> getLocation()async
 {
     await Geolocator.requestPermission().then((value) {


     }
     ).onError((error, stackTrace) {
      print('error $error');
     });
     return await Geolocator.getCurrentPosition();
 }

packdata()
{
  getLocation().then((value) async{ 
 myMarker.add( 
   Marker(markerId: MarkerId('five'),
     position: LatLng(value.latitude, value.longitude),
     infoWindow: InfoWindow( 
      title: 'My Location',

     )
   )
   
 );
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(value.latitude, value.longitude),
    zoom: 13,
    );
    GoogleMapController controller =await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {
      
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: SafeArea(
        child: GoogleMap(
          zoomControlsEnabled: false,
          
          mapType: MapType.normal,
          markers: Set<Marker>.of(myMarker),
          initialCameraPosition: cameraPosition,
          onMapCreated: (GoogleMapController controller  ){
           _controller.complete(controller);

          },
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: ()async{
          getLocation().then((value)async{
           GoogleMapController controller =await _controller.future;
         controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 13,
          )));
          setState(() {
            
          });

          });
         
        }),
    );
  }
}