import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/search/search_bloc.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/presentation/search/widget/title.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTitle(title: 'Movies & Tv'),
        const SizedBox(
          height: 10,
        ),
        Expanded(child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return GridView.count(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3,
              shrinkWrap: true,
              childAspectRatio: 1 / 1.4,
              children: List.generate(state.searchResultList!.length, (index) {
                final movie = state.searchResultList![index];

                return MainCard(
                    imageUrl:
                        movie.posterPath != null ? movie.posterPath! : "");
              }),
            );
          },
        ))
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        image: DecorationImage(
          fit: BoxFit.fill,
          // ignore: unnecessary_null_comparison
          image:
              NetworkImage(imageUrl.isNotEmpty ? '$imageBaseUrl$imageUrl' : ""),
        ),
      ),
    );
  }
}
