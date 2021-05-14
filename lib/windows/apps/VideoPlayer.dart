import 'package:flutter/material.dart';
import 'package:flutterOs/Util/fileManager/consts/colors.dart';
import 'package:flutterOs/Util/fileManager/fileIconManager.dart';
import 'package:flutterOs/windows/window.dart';
import 'package:video_player/video_player.dart';
import '../WindowListener.dart';

class VideoPlayerApp extends Application {
  final String videoUrl;
  VideoPlayerApp(
      {required Key key,
      GlobalKey? appKey,
      String? title,
      WindowListener? listener,
      required this.videoUrl})
      : super(key: key, appKey: appKey, title: title, listener: listener);
  @override
  double getHeight() {
    return 600;
  }

  @override
  double getWidth() {
    return 800;
  }
  @override
  FileType getFileType() {
    return FileType.APP_VIDEO_PLAYER;
  }

  @override
  _VideoPlayerState createState() => _VideoPlayerState(videoUrl);
}

class _VideoPlayerState extends ApplicationState {
  late VideoPlayerController _controller;
  double _controllersHeight = 50.0;
  int _sliderValue = 0;
  int _sliderMax = 100000;
  int _sliderMin = 0;

  _VideoPlayerState(String videoUrl) {
    _controller = VideoPlayerController.network(videoUrl,
        videoPlayerOptions: VideoPlayerOptions())
      ..initialize().then((_) {
        _sliderMax = _controller.value.duration.inMilliseconds;
        _controller.addListener(() async {
          _sliderValue = _controller.value.position.inMilliseconds;

          setState(() {});
        });

        widget.windowHeight = widget.windowWidth *
                _controller.value.size.height /
                _controller.value.size.width +
            _controllersHeight;
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget getApp() {
    return Container(
      height: widget.windowHeight,
      width: widget.windowWidth,
      child: Column(
        children: [
          Container(
            height: widget.windowHeight - _controllersHeight,
            width: widget.windowWidth,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Container(
            height: _controllersHeight,
            color: Resources.WINDOW_BODY_COLOR,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: Slider(
                          min: _sliderMin.toDouble(),
                          max: _sliderMax.toDouble(),
                          value: _sliderValue.toDouble(),
                          onChanged: _onSliderChange)),
                  Text(
                      "${_printDuration(_controller.value.position)}/${_printDuration(_controller.value.duration)}"),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    icon: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onSliderChange(double value) {
    setState(() {
      _sliderValue = value.round();
      _controller.seekTo(Duration(milliseconds: value.round()));
    });
  }

  //Format Duration
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }


}
