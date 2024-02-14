import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/search/search_bloc.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/presentation/search/widget/title.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTitle(title: "Top Searches"),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text("Error Occured!"),
                );
              } else if (state.idleList!.isEmpty) {
                return const Center(
                  child: Text("The list is Empty!"),
                );
              }

              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (ctx, newIndex) {
                    final moviTitle = state.idleList![newIndex].originalTitle;
                    final url = state.idleList![newIndex].posterPath;
                    return TopSearchItemTitle(
                        title: moviTitle ?? "",
                        imageUrl: url != null ? '$imageBaseUrl$url' : "");
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(height: 5);
                  },
                  itemCount: state.idleList!.length);
            },
          ),
        ),
      ],
    );
  }
}

class TopSearchItemTitle extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTitle(
      {super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    print("satheesh-url - ${imageUrl}");
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 23,
            child: Icon(
              Icons.play_circle_fill,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
