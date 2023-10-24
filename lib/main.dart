import 'package:demo_google_map/pages/home_page/homepage.dart';
import 'package:demo_google_map/services/bloc/map_bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/bloc/app_bloc/internet_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => InternetBloc(),
            )
          ],
          child: BlocProvider(
            create: (context) => MapBloc(),
            child: const HomePage(),
          ),
        ));
  }
}
