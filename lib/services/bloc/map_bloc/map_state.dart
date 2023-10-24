part of 'map_bloc.dart';

abstract class MapState {}

class InitialMapState extends MapState {}

class MapLoadingState extends MapState {}

class MapReadyState extends MapState {
  MapReadyState();
}
