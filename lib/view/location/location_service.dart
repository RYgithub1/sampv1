import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sampv1/data/user_location.dart';




class LocationService {
  // Keep track ogf current Location
  UserLocation _currentLocation;

  var location = Location();

  // Continuously emit location updates
  StreamController<UserLocation> _locationController = StreamController<UserLocation>.broadcast();
  // StreamController<UserLocation> get locationStream => _locationController.stream;
  StreamController<UserLocation> get locationController => _locationController;


  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } catch (exer) {
      print(exer);
    } finally {
      print('finally');
    }
    return _currentLocation;
  }


}