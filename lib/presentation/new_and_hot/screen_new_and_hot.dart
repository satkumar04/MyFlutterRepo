import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:intl/intl.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/everyone_watching_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: AppBar(
            title: const Text(
              'New & Hot',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            actions: [
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
            bottom: TabBar(
                labelColor: Colors.black,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                dividerColor: Colors.transparent,
                isScrollable: true,
                indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Tab(
                      text: 'Coming soon',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Tab(
                      text: 'Everyone\'s watching',
                    ),
                  ),
                ]),
          ),
        ),
        body: const TabBarView(children: [
          ComingSoonListWidget(),
          EveryOneIsWatchingList(),
        ]),
      ),
    );
  }
}

class ComingSoonListWidget extends StatelessWidget {
  const ComingSoonListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child:
          BlocBuilder<HotAndNewBloc, HotAndNewState>(builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.isError) {
          return const Center(
            child: Text("Error occured!"),
          );
        } else if (state.comingSoonList.isEmpty) {
          return const Center(
            child: Text("No data!"),
          );
        } else {
          return ListView.builder(
              itemCount: state.comingSoonList.length,
              itemBuilder: (BuildContext ctx, index) {
                final movie = state.comingSoonList[index];
                print('myMovie--${movie.posterPath}');
                if (movie.id == null) {
                  return const SizedBox();
                }

                final moviedate = DateTime.parse(movie.releaseDate!);

                final formatedMonth = DateFormat.MMM('en_US').format(moviedate);
                final formatedDay = DateFormat.d('en_US').format(moviedate);
                print(formatedDay.toString());
                return ComingSoonWidget(
                    id: movie.id.toString(),
                    month: formatedMonth,
                    day: formatedDay,
                    posterPath: '$imageBaseUrl${movie.posterPath}',
                    movieName: movie.title ?? 'No title',
                    description: movie.overview ?? 'No overview');
              });
        }
      }),
    );
  }
}

class EveryOneIsWatchingList extends StatelessWidget {
  const EveryOneIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInEveryOne());
    });

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInEveryOne());
      },
      child:
          BlocBuilder<HotAndNewBloc, HotAndNewState>(builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.isError) {
          return const Center(
            child: Text("Error occured!"),
          );
        } else if (state.everyOneList.isEmpty) {
          return const Center(
            child: Text("No data!"),
          );
        } else {
          return ListView.builder(
              itemCount: state.everyOneList.length,
              itemBuilder: (BuildContext ctx, index) {
                final tv = state.everyOneList[index];
                return EveryOneWatchingWidget(
                    posterPath: '$imageBaseUrl${tv.posterPath}',
                    tvName: tv.originalName ?? 'No name',
                    description: tv.overview ?? 'No overview');
              });
        }
      }),
    );
  }
}
