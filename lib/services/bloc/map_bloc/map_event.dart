part of 'map_bloc.dart';

abstract class MapEvent {}

class ChangeMapStyleEvent extends MapEvent {}

class CurrentLocation extends MapEvent {
  MapboxMapController mapController;

  CurrentLocation({required this.mapController});
}
