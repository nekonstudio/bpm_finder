import 'dart:convert';

import 'package:bpm_finder/home_page/data/models/track.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SpotifyRepository {
  final dio = Dio();

  late String accessToken;

  Future<void> authenticate() async {
    final encodedClientData = base64.encode(
      utf8.encode(
          '6a6b383dd82640108d7d2a5157573f27:b899b0f60c18472fa3e4bfdf60080689'),
    );

    final response = await dio.post(
      'https://accounts.spotify.com/api/token/',
      data: {
        'grant_type': 'client_credentials',
      },
      options: Options(
        headers: {
          'Authorization': 'Basic $encodedClientData',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );

    accessToken = response.data['access_token'];
    print('accessToken: $accessToken');
  }

  Future<List<Track>> searchTracks(String name) async {
    final response = await dio.get(
      'https://api.spotify.com/v1/search?q=$name&type=track',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    final items = response.data['tracks']['items'] as List<dynamic>;

    final result = <Track>[];

    for (final item in items) {
      final id = item['id'];
      final artist = item['album']['artists'][0]['name'];
      final album = item['album']['name'];
      final name = item['name'];
      final imageUrl = item['album']['images'][0]['url'];
      final tempo = await getTrackTempo(id);

      result.add(Track(
        id: id,
        artist: artist,
        album: album,
        name: name,
        imageUrl: imageUrl,
        tempo: tempo,
      ));
    }

    print(result);

    return result;
  }

  Future<int> getTrackTempo(String trackId) async {
    final response = await dio.get(
      'https://api.spotify.com/v1/audio-features/$trackId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    final tempo = (response.data['tempo'] as double).truncate();
    return tempo;
  }

  Future<String?> getTrackPreviewUrl(String trackId) async {
    final response = await dio.get(
      'https://api.spotify.com/v1/tracks/$trackId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    final url = response.data['preview_url'] as String?;
    return url;
  }
}
