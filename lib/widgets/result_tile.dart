import 'package:bpm_finder/config/dependency_injection.dart';
import 'package:bpm_finder/home_page/bloc/home_page_bloc/home_page_cubit.dart';
import 'package:bpm_finder/home_page/pages/track_details_page.dart';
import 'package:flutter/material.dart';

import 'package:bpm_finder/home_page/data/models/track.dart';

class ResultTile extends StatelessWidget {
  final Track track;

  const ResultTile({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getIt.get<HomePageCubit>().showTrackDetailsPage(track);
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => TrackDetailsPage(track: track),
        // ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 100,
              spreadRadius: 0,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  track.imageUrl,
                  height: 80,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      track.artist,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  const Text(
                    'BPM',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    track.tempo.toString(),
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
