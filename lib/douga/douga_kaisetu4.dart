import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
class DougaKaisetu4 extends StatelessWidget {
  const DougaKaisetu4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'アプリの使い方',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
        body: const SizedBox(
            height: 1000,
            child: Column(
                    children: [
                      PlayerWidget(),
                    ],
                  ),
            ),
      persistentFooterButtons: <Widget>[
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  // 動画を一時停止
                 // _controller.pauseVideo();
                },
                icon: const Icon(Icons.pause),
              ),
              IconButton(
                onPressed: () {
                  // 動画を再生
                  //_controller.playVideo();
                },
                icon: const Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: () {
                  // 動画を最初から再生
                 // _controller.stopVideo();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.stop),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
        controller: YoutubePlayerController.fromVideoId(
          videoId: 'StwDgaLTwwQ',
          params: const YoutubePlayerParams(
            showControls: true,
            showFullscreenButton: true,
          ),
        ),
        aspectRatio: 5 / 8,
      );
  }
}