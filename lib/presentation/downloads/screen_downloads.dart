import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/downloads/downloads_bloc.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/presentation/downloads/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});
  final List imageList = [
    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg",
    "https://www.themoviedb.org/t/p/w300_and_h450_bestv2/n1hqbSCtyBAxaXEl1Dj3ipXJAJG.jpg",
    "https://www.themoviedb.org/t/p/w300_and_h450_bestv2/1H2xEZOixs0z0JKwyjANZiKNNVJ.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadImage());
    });
    // BlocProvider.of<DownloadsBloc>(context)
    //     .add(const DownloadsEvent.getDownloadImage());

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: AppBarWidget(title: "Downloads"),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            width: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: _SmartDownloads(),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Introducing downloads for you',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'we will download a personalised selection of movies and shows for you.so there is something to watch on your device.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<DownloadsBloc, DownloadsState>(
            builder: (context, state) {
              return SizedBox(
                child: Center(
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: size.width * .42,
                            ),
                            DownloadImageWidget(
                              imageUrl: state.downloads!.isNotEmpty
                                  ? '$imageBaseUrl${state.downloads![0].posterPath}'
                                  : "",
                              margin:
                                  const EdgeInsets.only(left: 130, bottom: 50),
                              angle: 20,
                              size: Size(size.width * 0.4, size.width * .58),
                            ),
                            DownloadImageWidget(
                              imageUrl: state.downloads!.isNotEmpty
                                  ? '$imageBaseUrl${state.downloads![1].posterPath}'
                                  : "",
                              margin:
                                  const EdgeInsets.only(right: 130, bottom: 50),
                              angle: -20,
                              size: Size(size.width * 0.4, size.width * 0.58),
                            ),
                            DownloadImageWidget(
                              imageUrl: state.downloads!.isNotEmpty
                                  ? '$imageBaseUrl${state.downloads![2].posterPath}'
                                  : "",
                              margin: const EdgeInsets.only(left: 0),
                              angle: 0,
                              size: Size(size.width * 0.45, size.width * 0.75),
                            ),
                          ],
                        ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: MaterialButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Setup',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: MaterialButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'See what you can download',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
        SizedBox(
          width: 20,
        ),
        Text('Smart downloads')
      ],
    );
  }
}

class DownloadImageWidget extends StatelessWidget {
  const DownloadImageWidget({
    super.key,
    required this.imageUrl,
    this.angle = 0,
    required this.margin,
    required this.size,
  });

  final String imageUrl;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: NetworkImage(imageUrl))),
      ),
    );
  }
}
