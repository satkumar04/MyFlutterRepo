import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_app/presentation/fast_laugh/widgets/video_list_item.dart';

class ScreenFastLaugh extends StatelessWidget {
  const ScreenFastLaugh({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughBloc>(context).add(
        const Initialize(),
      );
    });
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: BlocBuilder<FastLaughBloc, FastLaughState>(
            builder: (context, state) {
              if (state.isError) {
                return const Center(
                  child: Text("Error Occured"),
                );
              } else if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.videoList.isEmpty) {
                return const Center(
                  child: Text("Video List is Empty"),
                );
              } else {
                return PageView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(state.videoList.length, (newIndex) {
                    return VideoListItemInheritedWidget(
                      widget: VideoListItem(
                        key: Key(
                          newIndex.toString(),
                        ),
                        index: newIndex,
                      ),
                      moviedata: state.videoList[newIndex],
                    );
                  }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
