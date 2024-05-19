import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

//import '../src/connectivity_sample.dart';


///
class DougaKaisetu4 extends StatelessWidget {
  ///
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: SizedBox(
            height: 1000,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return const Column(
                    children: [
                      PlayerWidget(),
                      Divider(),
                      Expanded(child: _WebViewWidget()),
                    ],
                  );
                }

                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: PlayerWidget()),
                    VerticalDivider(),
                    Expanded(child: _WebViewWidget()),
                  ],
                );
              },
            ),
          ),
        ),
      );
  }
}

///
class PlayerWidget extends StatelessWidget {
  ///
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

class _WebViewWidget extends StatefulWidget {
  const _WebViewWidget();

  @override
  State<_WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<_WebViewWidget> {
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..loadRequest(Uri.https('okatoku331.net'));
  }

  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}