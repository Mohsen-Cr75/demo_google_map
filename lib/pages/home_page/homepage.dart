import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/bloc/app_bloc/internet_bloc.dart';
import '../map_page/map_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is NotConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Offline'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("online"),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ConnectedState) {
            return MapPage();
          } else if (state is NotConnectedState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
                  color: Colors.redAccent,
                ),
                Text(state.message)
              ],
            ));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
