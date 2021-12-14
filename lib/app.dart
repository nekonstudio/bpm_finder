import 'package:bpm_finder/config/dependency_injection.dart';
import 'package:bpm_finder/constants/app_colors.dart';
import 'package:bpm_finder/home_page/bloc/home_page_bloc/home_page_cubit.dart';
import 'package:bpm_finder/home_page/bloc/search_bloc/search_bloc.dart';
import 'package:bpm_finder/home_page/data/repositories/recent_searches_repository.dart';
import 'package:bpm_finder/home_page/data/repositories/spotify_repository.dart';
import 'package:flutter/material.dart';

import 'package:bpm_finder/home_page/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getIt.get<SpotifyRepository>().authenticate();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.latoTextTheme().apply(
          bodyColor: AppColors.almostBlack,
          displayColor: AppColors.almostBlack,
        ),
      ),
      home: HomePage(),
    );
  }
}
