import 'package:DemoApp/screens/banner.dart';
import 'package:DemoApp/screens/image_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/user.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  //Hong Kong lat n long
  var lat = 22.3193, lng = 114.1694, name;
  bool showMap = true;

  UserDetailsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Stack(
      children: [
        GoogleMap(
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: false,
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          markers: showMap
              ? {
                  Marker(
                    markerId: MarkerId('marker_1'),
                    position: LatLng(lat, lng),
                    infoWindow: InfoWindow(
                      title: name,
                      snippet: 'Your location',
                    ),
                  )
                }
              : {},
          minMaxZoomPreference: const MinMaxZoomPreference(10, 22),
          initialCameraPosition: CameraPosition(
            target: showMap ? LatLng(lat, lng) : LatLng(22.3193, 114.1694),
            zoom: 15,
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(40.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Container(
            height: 100,
            child: Column(
              children: [
                AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white, // Set the color of the back button
                    onPressed: () {
                      // Handle back button press
                      Navigator.of(context).pop();
                    },
                  ),
                  backgroundColor: Colors.red,
                  elevation: 0,
                ),
                ImageTile(
                  imageUrl: user.picture,
                  title: user.firstName + " " + user.lastName,
                ),
              ],
            ),
          ),
        ),
        if (!showMap)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              height: 40,
              margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 50),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    SizedBox(width: 8.0),
                    Text('Apologies. Unable to show location of ${name}.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',

                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  void getUserData() {
    name = user.firstName + " " + user.lastName;
    lat = user.latitude!;
    lng = user.longitude!;
    showMap = lat != null && lat != 0.0 && lng != null && lng != 0.0;

    print('Error: Invalid location' + lat.toString() + " " + lng.toString());
  }
}
