import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final String url;
  Player({required this.url});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController c;

  @override
  void initState() {
    super.initState();

    c = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        c.play();
      });
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Player")),
      body: Center(
        child: c.value.isInitialized
            ? AspectRatio(
                aspectRatio: c.value.aspectRatio,
                child: VideoPlayer(c),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
