import 'dart:async';

import 'package:bpm_finder/config/dependency_injection.dart';
import 'package:bpm_finder/constants/app_colors.dart';
import 'package:bpm_finder/home_page/bloc/home_page_bloc/home_page_cubit.dart';
import 'package:bpm_finder/home_page/data/repositories/recent_searches_repository.dart';
import 'package:bpm_finder/home_page/data/sources/local_storage.dart';
import 'package:bpm_finder/home_page/pages/track_details_page.dart';
import 'package:bpm_finder/home_page/views/favorites_view.dart';
import 'package:bpm_finder/home_page/views/recent_searches_view.dart';
import 'package:bpm_finder/home_page/views/search_results_view.dart';
import 'package:bpm_finder/home_page/views/top_tracks_view.dart';
import 'package:bpm_finder/home_page/widgets/home_app_bar_delegate.dart';
import 'package:bpm_finder/home_page/widgets/home_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription<bool> keyboardVisibilitySubscription;

  @override
  void initState() {
    super.initState();

    keyboardVisibilitySubscription =
        KeyboardVisibilityController().onChange.listen((isKeyboardVisible) {
      final cubit = getIt.get<HomePageCubit>();
      if (!isKeyboardVisible && cubit.state is RecentSearchsPage) {
        cubit.backToPreviousPage();
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    keyboardVisibilitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();

          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: HomeAppBarDelegate(),
            ),
            // SliverAppBar(
            //   pinned: true,
            //   expandedHeight: 160.0,
            //   title: Text(
            //     'BPM Finder',
            //     style: GoogleFonts.lato(
            //       color: Colors.white,
            //       fontSize: 44.0,
            //       fontWeight: FontWeight.w900,
            //     ),
            //   ),
            //   centerTitle: true,
            //   flexibleSpace:
            //       // FlexibleSpaceBar(
            //       //   title:
            //       Padding(
            //     padding: const EdgeInsets.all(0.0),
            //     child: TextField(
            //       // controller: _textFieldController,
            //       decoration: InputDecoration(
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(30.0),
            //           borderSide: const BorderSide(
            //             width: 0,
            //             style: BorderStyle.none,
            //           ),
            //         ),
            //         filled: true,
            //         fillColor: Colors.white,
            //         hintText: 'Search songs, artists or tempo...',
            //         hintStyle: const TextStyle(fontSize: 15.0),
            //         suffixIcon: const Icon(Icons.search),
            //         contentPadding: const EdgeInsets.symmetric(
            //           horizontal: 26.0,
            //         ),
            //       ),
            //       onSubmitted: (value) {
            //         // getIt.get<HomePageCubit>().showSearchResultsPage(value);
            //         // getIt.get<SearchBloc>().add(PerformSearch(input: value));
            //       },
            //       onTap: () {
            //         // Navigator.of(context).push(MaterialPageRoute(
            //         //   builder: (context) => const HistoryScreen(),
            //         // ));
            //         // final state = getIt.get<HomePageCubit>().state;
            //         // if (state is! RecentSearchsPage) {
            //         //   getIt.get<HomePageCubit>().showRecentSearchsPage();
            //         // }
            //       },
            //     ),
            //   ),
            //   // centerTitle: true,
            //   // ),
            // ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, i) {
                return BlocBuilder(
                  bloc: getIt.get<HomePageCubit>(),
                  builder: (context, state) {
                    if (state is TopTracksPage) {
                      return const TopTracksView();
                    }
                    if (state is RecentSearchsPage) {
                      return const RecentSearchesView();
                    }

                    return const Text('Error!');
                  },
                );
              },
              childCount: 1,
            )),
          ],
        ),
      ),
    );

    return BlocBuilder<HomePageCubit, HomePageState>(
      bloc: getIt.get<HomePageCubit>(),
      builder: (context, state) {
        int? currentTabIndex;
        if (state is TopTracksPage) {
          currentTabIndex = 0;
        } else if (state is FavoritesPage) {
          currentTabIndex = 1;
        }

        print(state);

        return Scaffold(
          // appBar: HomePageAppBar(
          //   showBackButton:
          //       state is SearchResultsPage || state is RecentSearchsPage,
          // ),
          body: Builder(
            builder: (context) {
              late final Widget bodyWidget;

              if (state is TopTracksPage) {
                bodyWidget = const TopTracksView();
              } else if (state is RecentSearchsPage) {
                bodyWidget = const RecentSearchesView();
              } else if (state is SearchResultsPage) {
                bodyWidget = const SearchResultsView();
              } else if (state is FavoritesPage) {
                bodyWidget = const FavoritesView();
              } else if (state is TrackDetailsPage) {
                bodyWidget = TrackDetailsView(track: state.track);
              } else {
                bodyWidget = const SizedBox();
              }

              return Column(
                children: [
                  HomePageAppBar(
                      showBackButton: state is SearchResultsPage ||
                          state is RecentSearchsPage ||
                          state is TrackDetailsPage),
                  Expanded(child: bodyWidget),
                ],
              );
            },
          ),
          bottomNavigationBar: currentTabIndex == null
              ? null
              : BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.star,
                      ),
                      label: 'Top tracks',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      label: 'Favorites',
                    ),
                  ],
                  currentIndex: currentTabIndex,
                  onTap: (value) {
                    final homePageCubit = getIt.get<HomePageCubit>();
                    if (value == 0) {
                      homePageCubit.showTopTracksPage();
                    } else if (value == 1) {
                      homePageCubit.showFavoritesPage();
                    }
                  },
                ),
        );
      },
    );
  }
}
