import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DougaKaisetu3 extends StatefulWidget {
  const DougaKaisetu3({super.key});

  @override
  State<DougaKaisetu3> createState() => _DougaKaisetu3State();
}

class _DougaKaisetu3State extends State<DougaKaisetu3> {
  late YoutubePlayerController _controller;
  bool _isLoading = true;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    // ネットワーク接続状態を確認します
    _checkConnectivity();
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
      } else if (event.playerState == PlayerState.playing) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    _controller.pauseVideo();
  }

  void _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none){
      setState(() {
        _isConnected = false;
      });
    }
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
      body: _isConnected
      ? _isLoading
      ? const Center(
        child: Text(
          '動画をロードしています',
        style: TextStyle(color: Colors.cyan),
        ),
      )
      : Container(
        color: Colors.black,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: YoutubePlayer(
            controller: _controller,
            aspectRatio: 5 / 8,
          ),
        ),
      )
      : const Center(
        child: Text(
            'ネットに接続されていません、ネットに接続してから再起動して下さい。',
          style: TextStyle(color: Colors.white),
        ),
      ),
      persistentFooterButtons: _isConnected && !_isLoading
          ? <Widget>[
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
      ]
      : null,
    );
  }
}