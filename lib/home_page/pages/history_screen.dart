import 'package:bpm_finder/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
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
          title: Text('BPM Finder'),
          centerTitle: true,
        ),
      ),
    );
  }
}
