import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(InitialMapState()) {
    on<CurrentLocation>(_onCurrentLocation);
  }

  FutureOr<void> _onCurrentLocation(
      CurrentLocation event, Emitter<MapState> emit) async {
    LatLng? userLocation = await getUserLocation(event.mapController);
    if (userLocation != null) {
      event.mapController.moveCamera(
        CameraUpdate.newLatLng(userLocation),
      );
    }
  }

  Future<LatLng?> getUserLocation(MapboxMapController mapController) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle location services not enabled
      return null;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Handle denied location permission permanently
      return null;
    }

    // Request location permission if not granted
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Handle denied location permission
        return null;
      }
    }

    // Get the user's current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Create the SymbolOptions for the user's location marker
    SymbolOptions userLocationOptions = SymbolOptions(
      geometry: LatLng(position.latitude, position.longitude),
      iconImage:
          "assets/images/marker.png", // Replace with your custom icon image
      iconSize: 0.12,
    );

    mapController.addSymbol(userLocationOptions);

    return LatLng(position.latitude, position.longitude);
  }
}
