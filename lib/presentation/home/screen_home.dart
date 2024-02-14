import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/home/home_bloc.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/presentation/home/widgets/background_card.dart';
import 'package:netflix_app/presentation/home/widgets/number_title_card.dart';

import 'package:netflix_app/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> scrolNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scrolNotifier,
        builder: (BuildContext ctx, index, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final direction = notification.direction;
              if (direction == ScrollDirection.reverse) {
                scrolNotifier.value = false;
              } else if (direction == ScrollDirection.forward) {
                scrolNotifier.value = true;
              }

              return true;
            },
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.isError) {
                      return const Center(
                        child: Text("Error occured!"),
                      );
                    } else {
                      //print('sate - ${state.pastYearMovieList.toString()}');
                      final releasePastYear = state.pastYearMovieList.map((m) {
                        return '$imageBaseUrl${m.posterPath}';
                      }).toList();
                      final trendingTvList = state.trendingTvList.map((m) {
                        return '$imageBaseUrl${m.posterPath}';
                      }).toList();
                      trendingTvList.shuffle();

                      final trendingMovie = state.trendingMovieList.map((m) {
                        return '$imageBaseUrl${m.posterPath}';
                      }).toList();
                      trendingMovie.shuffle();
                      final dramas = state.tenseDramasList.map((m) {
                        return '$imageBaseUrl${m.posterPath}';
                      }).toList();

                      dramas.shuffle();

                      final south = state.southIndianMovieList.map((m) {
                        return '$imageBaseUrl${m.posterPath}';
                      }).toList();
                      south.shuffle();

                      return ListView(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const BackgroundCardWidget(),
                          MainTitleCard(
                            title: 'Released in the past year',
                            posterList: releasePastYear,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MainTitleCard(
                            title: 'Trending now',
                            posterList: trendingMovie,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          NumberTitleCardWidget(
                            posterList: trendingTvList,
                          ),
                          MainTitleCard(
                            title: 'Tense Dramas',
                            posterList: dramas,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MainTitleCard(
                            title: 'South indian cinema',
                            posterList: south,
                          ),
                        ],
                      );
                    }
                  },
                ),
                scrolNotifier.value
                    ? AnimatedContainer(
                        width: double.infinity,
                        height: 100,
                        color: Colors.black.withOpacity(0.3),
                        duration: const Duration(milliseconds: 2000),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    'https://static.vecteezy.com/system/resources/previews/022/101/069/original/netflix-logo-transparent-free-png.png',
                                    height: 50,
                                    width: 50,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.cast,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Tv shows',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Movies',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Categories',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 10,
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.icon,
    this.textSize = 18,
    this.iconSize = 25,
  });

  final String title;
  final IconData icon;
  final double iconSize;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: iconSize,
        ),
        Text(
          title,
          style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
