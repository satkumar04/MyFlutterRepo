import 'package:flutter/material.dart';
import 'package:netflix_app/presentation/widgets/main_card_item.dart';
import 'package:netflix_app/presentation/widgets/main_title.dart';

class MainTitleCard extends StatelessWidget {
  const MainTitleCard({
    super.key,
    required this.title,
    required this.posterList,
  });

  final String title;
  final List<String> posterList;
  @override
  Widget build(BuildContext context) {
    if (posterList.isNotEmpty) {
      //  print('sath----${posterList[0]}');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitleWidget(title: title),
        const SizedBox(
          height: 10,
        ),
        LimitedBox(
          maxHeight: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(posterList.length,
                (index) => MainCardItem(imageUrl: posterList[index])),
          ),
        )
      ],
    );
  }
}
