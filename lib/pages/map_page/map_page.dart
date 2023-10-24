import 'package:demo_google_map/services/bloc/map_bloc/map_bloc.dart';
import 'package:demo_google_map/services/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  TextEditingController serchController = TextEditingController();

  MapboxMapController? mapController;
  void _onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapboxMap(
            accessToken: accessToken,
            styleString: outdoorStyle,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(36.315, 55.283),
              zoom: 5,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            left: MediaQuery.of(context).size.width * 0.88,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white54,
              ),
              width: 40,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.map_sharp),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                    indent: 1,
                  ),
                  Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            left: MediaQuery.of(context).size.width * 0.88,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white54,
              ),
              width: 40,
              height: 40,
              child: FloatingActionButton(
                onPressed: () {
                  context
                      .read<MapBloc>()
                      .add(CurrentLocation(mapController: mapController!));
                },
                tooltip: 'Current Location',
                child: const Icon(Icons.my_location_rounded),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: BottomSheet(
        showDragHandle: true,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: serchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Maps',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.abc),
                      onPressed: () {
                        // Handle sending message
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        onClosing: () {},
      ),
    );
  }
}
