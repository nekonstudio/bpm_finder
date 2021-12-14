// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../home_page/bloc/home_page_bloc/home_page_cubit.dart' as _i4;
import '../home_page/bloc/search_bloc/search_bloc.dart' as _i8;
import '../home_page/data/repositories/recent_searches_repository.dart' as _i6;
import '../home_page/data/repositories/spotify_repository.dart' as _i7;
import '../home_page/data/sources/local_storage.dart' as _i5;
import 'dependency_injection.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.factoryAsync<_i3.Box<dynamic>>(() => registerModule.box,
      preResolve: true);
  gh.singleton<_i4.HomePageCubit>(_i4.HomePageCubit());
  gh.singleton<_i5.LocalStorage>(
      _i5.LocalStorage(box: get<_i3.Box<dynamic>>()));
  gh.factory<_i6.RecentSearchesRepository>(
      () => _i6.RecentSearchesRepository(storage: get<_i5.LocalStorage>()));
  gh.lazySingleton<_i7.SpotifyRepository>(() => _i7.SpotifyRepository());
  gh.lazySingleton<_i8.SearchBloc>(() => _i8.SearchBloc(
      spotifyRepository: get<_i7.SpotifyRepository>(),
      recentSearchesRepository: get<_i6.RecentSearchesRepository>()));
  return get;
}

class _$RegisterModule extends _i9.RegisterModule {}
