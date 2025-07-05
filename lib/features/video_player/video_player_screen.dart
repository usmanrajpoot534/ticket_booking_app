// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:ticket_booking_app/core/utils/app_config.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String? videoKey;
  const VideoPlayerScreen(this.videoKey, {super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isVideoEnded = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _controller =
        YoutubePlayerController(
          initialVideoId: '${widget.videoKey}',
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            disableDragSeek: false,
            loop: false,
            isLive: false,
            forceHD: true,
            enableCaption: false,
          ),
        )..addListener(() {
          if (_controller.value.hasError) return;

          if (!_isVideoEnded &&
              _controller.value.playerState == PlayerState.ended) {
            _isVideoEnded = true;
            context.pop();
          }
        });
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    AppConfig.setSystemUIOverlayStyle();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Future<void> _exitPlayer() async {
    await AppConfig.setPreferredOrientations();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              onEnded: (metaData) => _exitPlayer(),
            ),
            builder: (context, player) {
              return Center(child: player);
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: _exitPlayer,
                icon: Icon(Icons.close, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
