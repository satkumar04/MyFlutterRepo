import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/domain/downloads/models/downloads.dart';
import 'package:netflix_app/presentation/fast_laugh/widgets/video_actions_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

const url =
    "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg";

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads moviedata;

  const VideoListItemInheritedWidget({
    Key? key,
    required this.widget,
    required this.moviedata,
  }) : super(key: key, child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.moviedata != moviedata;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  const VideoListItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.moviedata.posterPath;
    final videoUrl = videoUrls[index % videoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(
          videoUrel: videoUrl,
          onStateChanged: (isReady) {},
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.volume_mute),
                    iconSize: 30,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: posterPath == null
                          ? null
                          : NetworkImage('$imageBaseUrl$posterPath'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder(
                      valueListenable: likedVideoNotifier,
                      builder:
                          (BuildContext c, Set<int> newLikedLitIds, Widget? _) {
                        final newIndex = index;
                        if (newLikedLitIds.contains(newIndex)) {
                          return GestureDetector(
                            onTap: () {
                              likedVideoNotifier.value.remove(newIndex);
                              likedVideoNotifier.notifyListeners();
                            },
                            child: const VideoActionWidget(
                              icon: Icons.favorite_outline,
                              title: 'Liked',
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              likedVideoNotifier.value.add(newIndex);
                              likedVideoNotifier.notifyListeners();
                            },
                            child: const VideoActionWidget(
                              icon: Icons.emoji_emotions,
                              title: 'Lol',
                            ),
                          );
                        }
                      },
                    ),
                    const VideoActionWidget(
                      icon: Icons.add,
                      title: 'My List',
                    ),
                    GestureDetector(
                      onTap: () {
                        final movieName =
                            VideoListItemInheritedWidget.of(context) != null
                                ? VideoListItemInheritedWidget.of(context)
                                    ?.moviedata
                                    .originalTitle
                                : "";
                        Share.share(movieName!);
                      },
                      child: const VideoActionWidget(
                          icon: Icons.share, title: 'Share'),
                    ),
                    const VideoActionWidget(
                        icon: Icons.play_arrow, title: 'Play'),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrel;
  final void Function(bool isPlaying) onStateChanged;

  const FastLaughVideoPlayer(
      {super.key, required this.videoUrel, required this.onStateChanged});

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrel),
    );

    videoPlayerController.initialize().then((value) {
      setState(() {});
      videoPlayerController.play();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController))
          : const Center(
              child: Text('Loading'),
            ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
