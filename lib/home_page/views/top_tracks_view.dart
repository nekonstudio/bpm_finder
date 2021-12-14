import 'package:bpm_finder/constants/app_colors.dart';
import 'package:bpm_finder/home_page/data/models/track.dart';
import 'package:bpm_finder/widgets/result_tile.dart';
import 'package:flutter/material.dart';

class TopTracksView extends StatelessWidget {
  const TopTracksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Top Tracks',
              style: TextStyle(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w900,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 10.0),
            ResultTile(
              track: Track(
                id: '',
                imageUrl:
                    'https://t2.genius.com/unsafe/327x327/https%3A%2F%2Fimages.genius.com%2F37ac6ac5bdd668397520c1c0081c9e7e.1000x1000x1.jpg',
                artist: 'Adele',
                name: 'Easy On Me',
                tempo: 81,
                album: '',
              ),
            ),
            ResultTile(
              track: Track(
                id: '',
                imageUrl: 'https://m.media-amazon.com/images/I/81NOC+t-AIL.jpg',
                artist: 'Beastie Boys',
                name: 'Sabotage',
                tempo: 92,
                album: '',
              ),
            ),
            ResultTile(
              track: Track(
                id: '',
                imageUrl: 'https://m.media-amazon.com/images/I/61VYFSVmDML.jpg',
                artist: 'Michael Bublé',
                name: "It's Beginning To Look A Lot Like Christmas",
                tempo: 142,
                album: '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
