import 'package:bpm_finder/config/dependency_injection.dart';
import 'package:bpm_finder/home_page/bloc/home_page_bloc/home_page_cubit.dart';
import 'package:bpm_finder/home_page/data/models/track.dart';
import 'package:bpm_finder/home_page/data/repositories/spotify_repository.dart';
import 'package:bpm_finder/home_page/widgets/home_page_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class TrackDetailsView extends StatefulWidget {
  final Track track;

  const TrackDetailsView({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  State<TrackDetailsView> createState() => _TrackDetailsViewState();
}

class _TrackDetailsViewState extends State<TrackDetailsView> {
  final audioPlayer = AudioPlayer();

  late Future<String?> previewUrlFuture;
  String? previewUrl;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    print('Track ID: ${widget.track.id}');

    previewUrlFuture = RepositoryProvider.of<SpotifyRepository>(context)
        .getTrackPreviewUrl(widget.track.id);

    previewUrlFuture.then((value) {
      previewUrl = value;
      audioPlayer.setUrl(previewUrl!);

      print('Song loaded!');
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        getIt.get<HomePageCubit>().backToPreviousPage();
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            Image.network(widget.track.imageUrl),
            ListTile(
              title: Text(widget.track.artist),
              subtitle: Text(widget.track.name),
              trailing: IconButton(
                onPressed: () async {
                  await Future.wait([previewUrlFuture]);

                  if (!isPlaying) {
                    audioPlayer.play();
                  } else {
                    audioPlayer.stop();
                  }

                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                icon: Icon(
                  isPlaying ? Icons.stop : Icons.play_arrow,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              'Tempo utworu: ${widget.track.tempo} BPM',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
