import 'package:equatable/equatable.dart';

class Track extends Equatable {
  final String id;
  final String artist;
  final String album;
  final String name;
  final String imageUrl;
  final int tempo;

  const Track({
    required this.id,
    required this.artist,
    required this.album,
    required this.name,
    required this.imageUrl,
    required this.tempo,
  });

  @override
  List<Object?> get props => [id, artist, album, name, imageUrl, tempo];
}
