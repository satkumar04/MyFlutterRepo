import 'package:flutter/material.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/presentation/home/widgets/number_card.dart';
import 'package:netflix_app/presentation/widgets/main_title.dart';

class NumberTitleCardWidget extends StatelessWidget {
  const NumberTitleCardWidget({super.key, required this.posterList});
  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitleWidget(title: 'Top 10 Tv shows in Insia Today.'),
        const SizedBox(
          height: 10,
        ),
        LimitedBox(
          maxHeight: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                10,
                (index) => NumberCardWidget(
                      index: index,
                      imageUrl: '$imageBaseUrl${posterList[index]}',
                    )),
          ),
        )
      ],
    );
  }
}
