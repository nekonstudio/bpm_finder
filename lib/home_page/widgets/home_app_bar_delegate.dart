import 'dart:math';

import 'package:bpm_finder/config/dependency_injection.dart';
import 'package:bpm_finder/constants/app_colors.dart';
import 'package:bpm_finder/home_page/bloc/home_page_bloc/home_page_cubit.dart';
import 'package:bpm_finder/home_page/pages/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print('shrinkOffset: $shrinkOffset');
    return Stack(
      // fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppColors.appbarGradient1,
                AppColors.appbarGradient2
              ],
            ),
          ),
        ),
        Positioned.fill(
          top: 60.0,
          child: Transform.scale(
            scale: titleOpacity(shrinkOffset),
            child: Text(
              'BPM Finder',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
                fontSize: 44.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        Positioned(
          // top: 100.0,
          bottom: 0.0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                // controller: _textFieldController,
                showCursor: false,
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search songs, artists or tempo...',
                  hintStyle: const TextStyle(fontSize: 15.0),
                  suffixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 26.0,
                  ),
                ),
                onSubmitted: (value) {
                  // getIt.get<HomePageCubit>().showSearchResultsPage(value);
                  // getIt.get<SearchBloc>().add(PerformSearch(input: value));
                },

                onTap: () {
                  // Navigator.of(context).push(PageRouteBuilder(
                  //   pageBuilder: (context, animation, secondaryAnimation) {
                  //     return HistoryScreen();
                  //   },
                  // ));
                  final state = getIt.get<HomePageCubit>().state;
                  if (state is! RecentSearchsPage) {
                    getIt.get<HomePageCubit>().showRecentSearchsPage();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 120.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
