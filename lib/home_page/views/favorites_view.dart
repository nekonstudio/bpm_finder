import 'package:bpm_finder/constants/app_colors.dart';
import 'package:bpm_finder/widgets/result_tile.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Your favorites',
              style: TextStyle(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w900,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
