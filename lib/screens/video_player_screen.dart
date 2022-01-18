import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../constants.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  final String? id;
  const VideoPlayerScreen({Key? key, required this.url, this.id}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? _controller;

  runYoutubePlayer(){
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: true,
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    runYoutubePlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _controller!.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        title: Text('انفورما'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/appBg.png')
            )
        ),
        child: Center(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              progressColors: ProgressBarColors(
                playedColor: primaryColor,
                handleColor: Colors.white
              ),
              progressIndicatorColor: primaryColor,
              controller: _controller!,
            ),
            builder: (context , player) {
              return player;
            },
          ),
        ),
      ),
    );
  }
}
