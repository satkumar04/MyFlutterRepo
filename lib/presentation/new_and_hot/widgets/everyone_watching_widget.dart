import 'package:flutter/material.dart';
import 'package:netflix_app/presentation/home/screen_home.dart';

class EveryOneWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String tvName;
  final String description;

  const EveryOneWatchingWidget({
    super.key,
    required this.posterPath,
    required this.tvName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            tvName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.network(
                  posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext _, Widget child,
                      ImageChunkEvent? progress) {
                    if (progress == null) {
                      return child;
                    } else {
                      return const CircularProgressIndicator(
                        strokeWidth: 2,
                      );
                    }
                  },
                  errorBuilder:
                      (BuildContext _, Object obj, StackTrace? trace) {
                    return const Center(child: Icon(Icons.wifi));
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 22,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.volume_off),
                    iconSize: 30,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                icon: Icons.share,
                title: "Share",
                iconSize: 25,
                textSize: 18,
              ),
              SizedBox(
                width: 10,
              ),
              CustomButton(
                icon: Icons.add,
                title: "My List",
                iconSize: 25,
                textSize: 18,
              ),
              SizedBox(
                width: 10,
              ),
              CustomButton(
                icon: Icons.play_arrow,
                title: "Play",
                iconSize: 25,
                textSize: 18,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
