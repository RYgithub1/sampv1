import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';



class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}


class _LocationScreenState extends State<LocationScreen> {
  /// WIDGET [checkLocation]: 位置情報がオンか、アプリが位置情報へアクセス可能か
  // Future<bool> checkLocation() async {
  //   Location location = Location();
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return false;
  //     }
  //   }
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return false;
  //     }
  //   }
  //   return true;
  // }
  Map<String, double> currentLocation = Map();
  StreamSubscription<Map<String, double>> locationSubscription;
  Location location = Location();
  String error;
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOCATION'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => null,
            )),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Text('Location Setting'),
          ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return _areaItem(
                  context,
                  AreaEntity(
                    area: CurrentLocation.area,
                    lon: null,
                    lat: null,
                  ),
                );
              } else {
                return _areaItem(
                  context,
                  areas[index - 1],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}