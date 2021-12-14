import 'package:bpm_finder/config/dependency_injection.dart';
import 'package:bpm_finder/home_page/bloc/search_bloc/search_bloc.dart';
import 'package:bpm_finder/home_page/pages/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bpm_finder/constants/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bpm_finder/home_page/bloc/home_page_bloc/home_page_cubit.dart';

class HomePageAppBar extends StatefulWidget
// implements PreferredSizeWidget
{
  final bool showBackButton;

  const HomePageAppBar({
    Key? key,
    required this.showBackButton,
  }) : super(key: key);

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();

  // @override
  // Size get preferredSize => const Size.fromHeight(160);
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  final _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.showBackButton);
    return BlocConsumer<HomePageCubit, HomePageState>(
      bloc: getIt.get<HomePageCubit>(),
      listener: (_, state) {
        if (state is SearchResultsPage) {
          _textFieldController.text = state.searchPhrase;

          FocusScope.of(context).unfocus();
        } else if (state is! RecentSearchsPage && state is! TrackDetailsPage) {
          _textFieldController.clear();
        }
      },
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          // height: state is TrackDetailsPage ? 140 : 200,
          height: 200,
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
          child: Column(
            children: [
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Visibility(
                    visible: widget.showBackButton,
                    // visible: true,
                    maintainState: true,
                    maintainAnimation: true,
                    maintainSize: true,
                    child: IconButton(
                      onPressed: () {
                        getIt.get<HomePageCubit>().backToPreviousPage();
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'BPM Finder',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 44.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Visibility(
                    visible: false,
                    maintainState: true,
                    maintainAnimation: true,
                    maintainSize: true,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    ),
                  ),
                ],
              ),
              // if (state is! TrackDetailsPage)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _textFieldController,
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
                    getIt.get<HomePageCubit>().showSearchResultsPage(value);
                    getIt.get<SearchBloc>().add(PerformSearch(input: value));
                  },
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => const HistoryScreen(),
                    // ));
                    final state = getIt.get<HomePageCubit>().state;
                    if (state is! RecentSearchsPage) {
                      getIt.get<HomePageCubit>().showRecentSearchsPage();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
