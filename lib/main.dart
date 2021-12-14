import 'package:bpm_finder/home_page/data/repositories/spotify_repository.dart';
import 'package:flutter/material.dart';

import 'package:bpm_finder/app.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/dependency_injection.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await Hive.initFlutter();

  await configureDependencies();

  runApp(
    RepositoryProvider(
      create: (context) => SpotifyRepository(),
      child: const App(),
    ),
  );
}
