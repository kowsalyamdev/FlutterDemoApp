import 'dart:async';

import '../config/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/user.dart';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<User>? _users;
  final Completer<GoogleMapController> _mapController =
  Completer<GoogleMapController>();


  final Set<Polyline> _polylines = {};
  final List<LatLng> _polylinePoints = [
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 2,
        centerTitle: false,
        title: Text('USER LOCATION',  style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:16,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),),

      ),
      body: FutureBuilder<List<User>>(
        future: UserService().getUserList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.grey,),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          _users = snapshot.data;
          for (var user in _users!){
            _polylinePoints.add(LatLng(user.latitude!, user.longitude!));
          }

          return GoogleMap(

            zoomGesturesEnabled: true,
            tiltGesturesEnabled: false,
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            minMaxZoomPreference: const MinMaxZoomPreference(10, 22),
            onMapCreated: (controller) {
                _mapController.complete(controller);
                //_addPolyline();
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(22.39, 113.99),
              zoom: 5,
            ),
            markers: _users?.map((user) => Marker(
              markerId: MarkerId('user_${user.id}'),
              position: LatLng(user.latitude!, user.longitude!),
              infoWindow: InfoWindow(
                title: user.firstName + " " + user.lastName,
                  snippet: 'lat:'+ user.latitude!.toString() +"\t" +"lng:" +user.longitude!.toString()

              ),
            )).toSet() ?? {},
          );
        },
      ),
    );

  }
  void _addPolyline() {
    final Polyline polyline = Polyline(
      polylineId: PolylineId('polyline_1'),
      color: Colors.blue,
      width: 5,
      points: _polylinePoints,
    );

    setState(() {
      _polylines.add(polyline);
    });
  }

}