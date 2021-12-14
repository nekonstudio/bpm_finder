import 'package:bpm_finder/config/dependency_injection.dart';
import 'package:bpm_finder/constants/app_colors.dart';
import 'package:bpm_finder/home_page/bloc/home_page_bloc/home_page_cubit.dart';
import 'package:bpm_finder/home_page/bloc/search_bloc/search_bloc.dart';
import 'package:bpm_finder/widgets/result_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: WillPopScope(
          onWillPop: () async {
            getIt.get<HomePageCubit>().backToPreviousPage();

            return false;
          },
          child: BlocBuilder<SearchBloc, SearchState>(
            bloc: getIt.get<SearchBloc>(),
            builder: (context, state) {
              if (state is SearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SearchResults) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Search Results',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontWeight: FontWeight.w900,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ...state.tracks.map((track) {
                      return ResultTile(track: track);
                    }).toList(),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
