import 'package:bpm_finder/config/dependency_injection.dart';
import 'package:bpm_finder/constants/app_colors.dart';
import 'package:bpm_finder/home_page/bloc/home_page_bloc/home_page_cubit.dart';
import 'package:bpm_finder/home_page/bloc/search_bloc/search_bloc.dart';
import 'package:bpm_finder/home_page/data/repositories/recent_searches_repository.dart';
import 'package:bpm_finder/home_page/pages/home_page.dart';
import 'package:bpm_finder/widgets/result_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentSearchesView extends StatelessWidget {
  const RecentSearchesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recentlySearched =
        getIt.get<RecentSearchesRepository>().getRecentSearches();
    // final recentlySearched = <String>[];

    return WillPopScope(
      onWillPop: () async {
        getIt.get<HomePageCubit>().backToPreviousPage();

        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          shrinkWrap: true,
          children: [
            const Text(
              'Recently searched',
              style: TextStyle(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w900,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 10.0),
            if (recentlySearched.isEmpty)
              const Text('No recent history')
            else
              Expanded(
                child: Scrollbar(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: recentlySearched.map((item) {
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              getIt
                                  .get<HomePageCubit>()
                                  .showSearchResultsPage(item);
                              getIt
                                  .get<SearchBloc>()
                                  .add(PerformSearch(input: item));
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
