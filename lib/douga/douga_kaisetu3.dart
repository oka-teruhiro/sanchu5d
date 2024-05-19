import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DougaKaisetu3 extends StatefulWidget {
  const DougaKaisetu3({super.key});

  @override
  State<DougaKaisetu3> createState() => _DougaKaisetu3State();
}

class _DougaKaisetu3State extends State<DougaKaisetu3> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // YoutubePlayerController を初期化します
    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'StwDgaLTwwQ',
      params: const YoutubePlayerParams(
        playsInline: true,
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    // 動画の再生状態を監視するリスナーを追加
    _controller.listen((event) {
      if (event.playerState == PlayerState.ended){
        // 動画が終了したら元のページに遷移します
        Navigator.pop(context);
      }
    });
    _controller.pauseVideo();
  }

  @override
  void dispose(){
    super.dispose();
    _controller.close();
  }

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
      body: Container(
        color: Colors.black,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: YoutubePlayer(
            controller: _controller,
            aspectRatio: 5 / 8,
          ),
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
                  _controller.pauseVideo();
                },
                icon: const Icon(Icons.pause),
              ),
              IconButton(
                onPressed: () {
                  // 動画を再生
                  _controller.playVideo();
                },
                icon: const Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: () {
                  // 動画を終了
                  _controller.stopVideo();
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